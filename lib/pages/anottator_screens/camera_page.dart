import 'dart:io';

import 'package:anotame/models/local_data.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../models/worker__model.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;

  CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    controller = CameraController(
      widget.cameras![0],
      ResolutionPreset.max,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tomar foto',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 300,
                width: MediaQuery.of(context).size.width,
                child: CameraPreview(controller),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                pictureFile = await controller.takePicture();
                setState(() {});
              },
              child: const Text('Analizar carnet!'),
            ),
          ),
          if (pictureFile != null)
            FutureBuilder(
                future: recognizeText(pictureFile!),
                builder: (context, snapshot) {
                  if (LocalData().worker?.RUT != '') {
                    Navigator.of(context).pop();
                  }
                  return SizedBox(
                    height: 1,
                  );
                }),
          //Android/iOS
          // Image.file(File(pictureFile!.path)))
        ],
      ),
    );
  }

  Future<void> recognizeText(XFile file) async {
    final TextRecognizer textRecognizer = TextRecognizer();
    var recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(file.path));
    var listed_text = recognizedText.text.split('\n');
    String names = "";
    String last_names = "";
    String RUT = " ";
    String birthDate = "";
    String nationalitie = "";
    for (var i = 0; i < listed_text.length; i++) {
      //print("Parsed Text: " + listed_text[i] + "\n");
      if (listed_text[i] == "APELLIDOS" || listed_text[i] == "APELLID0S") {
        last_names = listed_text[i + 1] + " " + listed_text[i + 2];
      }
      if (listed_text[i] == "NOMBRES" || listed_text[i] == "N0MBRES") {
        names = listed_text[i + 1];
      }
      if (listed_text[i] == "NACIONALIDAD") {
        nationalitie = listed_text[i + 1];
      }
      if (listed_text[i] == "FECHA DE NACIMIENTO") {
        birthDate = listed_text[i + 1];
      }
      if (listed_text[i].split(" ")[0] == "RUN") {
        RUT = listed_text[i].split(" ")[1];
      }
    }
    print("Nombres: " + names);
    print("Apellidos: " + last_names);
    print("RUT: " + RUT);
    print("Nacionalidad: " + nationalitie);
    print("Fecha de nacimiento: " + birthDate);
    Worker worker = Worker(
        names: names,
        nationalitie: nationalitie,
        RUT: RUT,
        birthDate: "",
        lastNames: last_names);
    LocalData().saveWorker(worker);
  }
}
