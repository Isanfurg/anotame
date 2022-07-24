import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:anotame/services/firebase_client.dart';

import '../../../models/local_data.dart';

class SetWorkScreen extends StatelessWidget {
  List<QueryDocumentSnapshot> workers = [];
  List<Object?> showed = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar Trabajo',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: getWorkers(),
          builder: (context, snapshot) {
            if (workers != []) {
              return FutureBuilder(
                future: makeWorkersToday(),
                builder: (context, snapshot) {
                  if (showed.length != 0) {
                    return ListView.builder(
                        itemCount: showed.length,
                        itemBuilder: (BuildContext context, int index) {
                          var aux = showed[index];

                          var data = aux as Map<String, dynamic>;
                          int n_cajas = int.parse(data['n_cajas']);
                          print("building:" + aux.toString());
                          print(data['worker_name']);
                          return Container(
                            padding: EdgeInsets.all(5),
                            height: 120,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 7,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/icon.png',
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        data['worker_name'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        data[
                                                            'worker_last_name'],
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(" [ " +
                                                          data['worker_rut'] +
                                                          " ] "),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      removeWorkToWorker(
                                                          data['worker_rut'],
                                                          data['date']);

                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              'setWork');
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              'setWork');
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .remove_circle_outline_outlined,
                                                      size: 40,
                                                      color: Colors.red[900],
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(n_cajas.toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black)),
                                                IconButton(
                                                    onPressed: () {
                                                      addWorkToWorker(
                                                          data['worker_rut'],
                                                          data['date']);

                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              'setWork');
                                                    },
                                                    icon: Icon(
                                                      Icons.add_circle,
                                                      size: 40,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.green,
                                    )
                                  ]),
                            ),
                          );
                        });
                  }
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ));
                },
              );
            }

            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(),
              ],
            ));
          }),
    );
  }

  Future getWorkers() async {
    // ignore: await_only_futures
    workers = await getWorkersByEmail(LocalData().email);
  }

  Future<void> makeWorkersToday() async {
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    await Future.forEach(workers, (element) async {
      var aux = element! as QueryDocumentSnapshot;
      var data = aux.data() as Map<String, dynamic>;

      var rut = data['RUT'];
      var work_data =
          await getWorkByDayToUser(LocalData().email, date.toString(), rut);
      if (work_data.isEmpty) {
        addWorkToday(data['names'], rut, data['lastNames']);
        work_data =
            await getWorkByDayToUser(LocalData().email, date.toString(), rut);
      }
      print(work_data.first.data());
      showed.add(work_data.first.data());
    });
  }
}
