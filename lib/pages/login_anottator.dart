import 'package:flutter/material.dart';

class LoginAnottatorScreen extends StatelessWidget {
  const LoginAnottatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Iniciar Sesion',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/abajo.png',
                    width: 240,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.restorablePushReplacementNamed(
                            context, 'anottator');
                      },
                      // ignore: prefer_const_constructors
                      child: Text(
                        "Registrarse",
                        style: TextStyle(fontSize: 18, color: Colors.green),
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
