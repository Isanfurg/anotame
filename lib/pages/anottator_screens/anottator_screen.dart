// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:anotame/services/firebase_client.dart';
import 'package:anotame/widgets/weather_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/local_data.dart';

class AnottatorScreen extends StatelessWidget {
  AnottatorScreen({Key? key}) : super(key: key);
  List? workers;
  int n_workers = 0;
  int n_bins = 0;
  int n_cajas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anotador!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
          child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Image.asset(
            'assets/abajo.png',
            width: 160,
            height: 160,
          ),
          FutureBuilder(
              future: getData(),
              builder: (BuildContext context, snapshot) {
                return Row(children: [
                  Expanded(
                    child: Card(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Bins",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                n_bins.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Trabajadores",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                n_workers.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Cajas",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                n_cajas.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ),
                ]);
              }),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'addWorker');
                },
                // ignore: prefer_const_constructors
                child: Text(
                  "Agregar Trabajador",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'setWork');
                },
                // ignore: prefer_const_constructors
                child: Text(
                  "Agregar Caja",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'report');
                },
                // ignore: prefer_const_constructors
                child: Text(
                  "Ver trabajo",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          WeatherTool(),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
                onPressed: () {
                  LocalData().signOut();
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, 'home');
                },
                // ignore: prefer_const_constructors
                child: Text(
                  "Desconectarse",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  getData() async {
    n_cajas = await getNCajasAnottator(LocalData().email);
    n_workers = await getNWorkerToAnottator(LocalData().email);
    n_bins = (n_cajas / 24).round();
  }
}
