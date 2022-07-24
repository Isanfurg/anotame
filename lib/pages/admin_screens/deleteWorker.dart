import 'package:anotame/services/firebase_client.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/local_data.dart';

class AdminDeleteScreen extends StatelessWidget {
  AdminDeleteScreen({Key? key}) : super(key: key);
  List<QueryDocumentSnapshot> workers = [];
  List<Object?> showed = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eliminar Trabajador',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: getWorkers(),
          builder: (context, snapshot) {
            if (workers != []) {
              return ListView.builder(
                  itemCount: workers.length,
                  itemBuilder: (BuildContext context, int index) {
                    print(workers[index]);
                    return Container(
                      padding: EdgeInsets.all(10),
                      height: 120,
                      width: 100,
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      flex: 8,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/icon.png',
                                            width: 80,
                                            height: 80,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Cosechero",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  ),
                                                  Text(
                                                    workers[index]['names'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    workers[index]['lastNames'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Anotador",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  ),
                                                  Text(
                                                    workers[index]['anottator'],
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  await deleteWorker(
                                                      workers[index]['RUT']);

                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          'deleteWorker');
                                                },
                                                icon: Icon(
                                                  Icons.delete_forever_outlined,
                                                  size: 40,
                                                  color: Colors.red[900],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
          }),
    );
  }

  Future getWorkers() async {
    // ignore: await_only_futures
    workers = await getWorkersAdmin();
  }
}
