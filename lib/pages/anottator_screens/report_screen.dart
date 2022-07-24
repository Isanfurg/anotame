import 'package:anotame/models/local_data.dart';
import 'package:anotame/services/firebase_client.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  List<String> options = [];
  List<Object?> data = [];
  String dropdownvalue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reportes por dia!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Seleccione una fecha",
                style: TextStyle(fontSize: 30),
              ),
              _ReportScreen(
                dropDownValue: dropdownvalue,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (LocalData().selectedDate != '') {
                      Navigator.pushNamed(context, 'day');
                    }
                  },
                  child: Text(
                    "Ver Seleccionado",
                    style: TextStyle(fontSize: 20),
                  )),
            ]),
      ),
    );
  }
}

class _ReportScreen extends StatefulWidget {
  final dropDownValue;
  const _ReportScreen({
    super.key,
    required this.dropDownValue,
  });

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<_ReportScreen> {
  late Future<void> _initializeControllerFuture;
  late String _dropDownValue = '2022-07-06 00:00:00.000';
  late List<String> options = [];
  late List<Object?> data = [];
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      options = await getWorkedDays(LocalData().email) as List<String>;
      //your async 'await' codes goes here
    });
    super.initState();

    // Next, initialize the controller. This returns a Future.
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FutureBuilder(
              future: getDates(),
              builder: (BuildContext context, snapshot) {
                if (getDates() != []) {
                  return DropdownButton(
                      value: _dropDownValue,
                      items: options.map((String options) {
                        return DropdownMenuItem(
                          value: options,
                          child: Text(options),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropDownValue = newValue!;
                          LocalData().saveSelectedDate(_dropDownValue);
                        });
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
              })
        ],
      ),
    );
  }

  Future<void> getDates() async {
    options = await getWorkedDays(LocalData().email) as List<String>;
  }

  Future<void> getDataDate() async {
    data = await getWorkedOnDay(LocalData().email, _dropDownValue);
  }
}
