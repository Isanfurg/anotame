import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/local_data.dart';
import '../../services/firebase_client.dart';

class ViewDayScreen extends StatelessWidget {
  ViewDayScreen({Key? key}) : super(key: key);
  List<QueryDocumentSnapshot> data = [];
  List<Map<String, dynamic>> showed = [];
  String date = '';
  @override
  Widget build(BuildContext context) {
    date = LocalData().selectedDate.substring(0, 10);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reporte: ' + date,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: FutureBuilder(
          future: getDataDate(),
          builder: (BuildContext context, snapshot) {
            if (showed != []) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var aux = showed[index];
                    print(data);
                    return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        height: 120,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Cosechero ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                        Text(
                                          aux['worker_name'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          aux['worker_last_name'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Cajas ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      aux['n_cajas'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ))
                          ],
                        ));
                  });
            }
            return Center(child: Text("Seleccione fecha"));
          },
        ),
      ),
    );
  }

  Future<void> getDataDate() async {
    data = await getWorkedOnDay(LocalData().email, LocalData().selectedDate);
    await Future.forEach(data, (element) async {
      var aux = element! as QueryDocumentSnapshot;
      var value = aux.data() as Map<String, dynamic>;
      showed.add(value);
    });
  }
}
