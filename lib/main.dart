// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, depend_on_referenced_packages

import 'package:anotame/models/local_data.dart';
import 'package:anotame/pages/admin_screens/admin_anottator.dart';
import 'package:anotame/pages/admin_screens/admin_day.dart';
import 'package:anotame/pages/admin_screens/admin_report.dart';
import 'package:anotame/pages/admin_screens/deleteWorker.dart';
import 'package:anotame/pages/anottator_screens/add_worker.dart';
import 'package:anotame/pages/anottator_screens/camera_register.dart';
import 'package:anotame/pages/pages.dart';
import 'package:anotame/pages/anottator_screens/register_user.dart';
import 'package:anotame/pages/anottator_screens/report_screen.dart';
import 'package:anotame/pages/anottator_screens/set_worker.dart';
import 'package:anotame/pages/anottator_screens/view_day.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  LocalData().getDataLocalStorage;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anotame',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomeScreen(),
        'anottator': (BuildContext context) => AnottatorScreen(),
        'loginAnottator': (BuildContext context) => LoginAnottatorScreen(),
        'admin': (BuildContext context) => AdminScreen(),
        'register': (BuildContext context) => RegisterScreen(),
        'addWorker': (BuildContext context) => AddWorkerScreen(),
        'setWork': (BuildContext context) => SetWorkScreen(),
        'report': (BuildContext context) => ReportScreen(),
        'day': (BuildContext context) => ViewDayScreen(),
        'takePicture': (BuildContext context) => CameraRegisterScreen(),
        'adminReport': (BuildContext context) => AdminReportScreen(),
        'adminDayReport': (BuildContext context) => AdminViewDayScreen(),
        'deleteWorker': (BuildContext context) => AdminDeleteScreen(),
        'adminAnottators': (BuildContext context) => AdminAnottatorScreen(),
      },
    );
  }
}
