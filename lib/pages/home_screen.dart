// ignore_for_file: avoid_print, prefer_const_constructors, duplicate_ignore

import 'package:anotame/models/local_data.dart';
import 'package:anotame/models/user__model.dart';
import 'package:anotame/pages/admin_screens/admin_screen.dart';
import 'package:anotame/pages/anottator_screens/anottator_screen.dart';
import 'package:anotame/services/firebase_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final bool _isObscure = true;
  String password = "";
  String email = "";
  LocalData local = LocalData();
  @override
  Widget build(BuildContext context) {
    if (LocalData().checkUserLogged()) {
      print("Logged as:" + LocalData().email);
      if (LocalData().type == 'anottator') {
        return AnottatorScreen();
      }
      if (LocalData().type == 'admin') {
        return AdminScreen();
      }
      print(LocalData().type);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenido!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(30),
          children: <Widget>[
            Image.asset(
              'assets/abajo.png',
              width: 350,
              height: 350,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  initialValue: '',
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'tucorreo@gmail.com',
                    labelText: 'Correo',
                  ),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    email = value;
                  },
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 300,
                child: TextFormField(
                  initialValue: '',
                  decoration: InputDecoration(
                    icon: Icon(Icons.key),
                    hintText: '********',
                    labelText: 'Contraseña',
                  ),
                  obscureText: _isObscure,
                  onChanged: (value) {
                    password = value;
                  },
                )),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  signIn(context);
                },
                // ignore: prefer_const_constructors
                child: Text(
                  "Iniciar Sesion",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                )),
            SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                child: Text(
                  "Registrarse",
                  style: TextStyle(fontSize: 18, color: Colors.green),
                )),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    try {
      UserCredential userCredetenial = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await LocalData().signIn(email, password);
      print("Tipo de usuario:" + LocalData().type);
      if (LocalData().type == 'admin') {
        Navigator.pushReplacementNamed(context, 'admin');
      } else if (LocalData().type == 'anottator') {
        Navigator.pushReplacementNamed(context, 'anottator');
      }
    } on FirebaseAuthException catch (e) {
      print("Error Loggin =\t" + e.toString());
    }
  }
}
