import 'package:anotame/services/firebase_client.dart';
import 'package:flutter/material.dart';

class AdminAnottatorScreen extends StatelessWidget {
  AdminAnottatorScreen({Key? key}) : super(key: key);
  List<dynamic> anottators = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anotadores',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: FutureBuilder(
            future: getAnottators(),
            builder: (context, snapshot) {
              if (anottators != []) {
                return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: anottators.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Row(
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
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Anotador",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      anottators[index]['names'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    Text(
                                      anottators[index]['lastNames'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      anottators[index]['email'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Rut",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    Text(
                                      anottators[index]['RUT'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              height: 1,
                            )
                          ],
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Future getAnottators() async {
    // ignore: await_only_futures
    anottators = await getAnottatorsAdmin();
  }
}
