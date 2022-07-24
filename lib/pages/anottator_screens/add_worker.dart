import 'package:anotame/models/local_data.dart';
import 'package:anotame/models/worker__model.dart';
import 'package:anotame/services/firebase_client.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'camera_page.dart';

class AddWorkerScreen extends StatelessWidget {
  AddWorkerScreen({Key? key}) : super(key: key);

  String names = '';
  String lastNames = '';
  String rut = '';
  String nationalitie = '';
  String gender = '';
  DateTime currentSelectedDate = DateTime.now();
  int flag = 0;

  @override
  Widget build(BuildContext context) {
    getDataCamera();
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    await availableCameras().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraPage(
                            cameras: value,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.camera,
                    size: 26.0,
                  ),
                )),
          ],
          title: const Text(
            'Agregar trabajador',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/icon.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue: names,
                    decoration: const InputDecoration(
                      hintText: 'Juan Carlos',
                      labelText: 'Nombres',
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      names = value;
                    },
                  )),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: lastNames,
                    decoration: const InputDecoration(
                      hintText: 'Morales Morales',
                      labelText: 'Apellidos',
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      lastNames = value;
                    },
                  )),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: rut,
                    decoration: InputDecoration(
                      hintText: '11.223.333-k',
                      labelText: 'Rut',
                    ),
                    onChanged: (value) {
                      rut = value;
                    },
                  )),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: gender,
                    decoration: InputDecoration(
                      hintText: 'Masculino/Femenino/Otro',
                      labelText: 'Sexo',
                    ),
                    onChanged: (value) {
                      gender = value;
                    },
                  )),
              SizedBox(
                  width: 300,
                  child: TextFormField(
                    initialValue: nationalitie,
                    decoration: InputDecoration(
                      hintText: 'chileno/haitiano/argentino/etc',
                      labelText: 'Nacionalidad',
                    ),
                    onChanged: (value) {
                      nationalitie = value;
                    },
                  )),
              SizedBox(
                height: 14,
              ),
              Text(
                "Fecha de nacimiento",
                style: TextStyle(color: Colors.black87),
              ),
              SizedBox(
                height: 50,
                child: Card(
                  elevation: 1,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(1969, 1, 1),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      currentSelectedDate = newDateTime;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    onPressed: () async {
                      print("Registrando trabajador nuevo");
                      Worker worker = Worker(
                          names: names,
                          nationalitie: nationalitie,
                          RUT: rut,
                          birthDate: currentSelectedDate.toString(),
                          gender: gender,
                          lastNames: lastNames);
                      await addWorker(worker, LocalData().email);
                      Navigator.pushNamed(context, 'anottator');
                    },
                    // ignore: prefer_const_constructors
                    child: Text(
                      "Guardar trabajador",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }

  getDataCamera() {
    Worker? worker = LocalData().worker;
    if (worker != null) {
      names = worker.names!;
      lastNames = worker.lastNames!;
      rut = worker.RUT!;
      nationalitie = worker.nationalitie!;
      LocalData().consumeWorker();
    }
  }
}
