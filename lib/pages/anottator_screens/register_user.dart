import 'package:anotame/models/local_data.dart';
import 'package:anotame/models/user__model.dart';
import 'package:anotame/services/firebase_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/worker__model.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  String email = '';
  String names = '';
  String lastNames = '';
  String password = '';
  String secondPassword = '';
  String rut = '';
  DateTime currentSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro anotador',
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
              'assets/abajo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    hintText: 'tucorreo@gmail.com',
                    labelText: 'Correo',
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    email = value;
                  },
                )),
            SizedBox(
                width: 200,
                child: TextFormField(
                  initialValue: '',
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
                  initialValue: '',
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
                  initialValue: '',
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
                  initialValue: '',
                  decoration: InputDecoration(
                    hintText: '********',
                    labelText: 'Contraseña',
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                )),
            SizedBox(
                width: 300,
                child: TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    hintText: '********',
                    labelText: 'Repetir contraseña',
                  ),
                  onChanged: (value) {
                    secondPassword = value;
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
                    if (password != secondPassword) {
                      print('Passwords Distintos');
                    }
                    UserCredential user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    UserCustom userCustom = UserCustom(
                        email: email,
                        RUT: rut,
                        birthDate: currentSelectedDate.toString(),
                        names: names,
                        lastNames: lastNames,
                        type: 'anottator');
                    await userSetup(userCustom);
                    print("Registrando usuario nuevo");
                    Navigator.pushNamed(context, 'anottator');
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Registrarse",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
