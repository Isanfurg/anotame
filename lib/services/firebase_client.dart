// ignore_for_file: avoid_print

import 'package:anotame/models/local_data.dart';
import 'package:anotame/models/worker__model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anotame/models/user__model.dart';
import 'package:flutter/material.dart';

Future<Widget> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return SnackBar(
      content: Text("Sesion Iniciada"),
    );
  } on FirebaseAuthException catch (e) {
    return SnackBar(
      content: Text('Error' + e.toString()),
    );
    return SnackBar(content: CircularProgressIndicator());
  }
}

Future<void> userSetup(UserCustom user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid = auth.currentUser?.uid.toString();
  users.add({
    'email': user.email,
    'uid': uid,
    'names': user.names,
    'lastNames': user.lastNames,
    'RUT': user.RUT,
    'birthDate': user.birthDate,
    'type': user.type
  });
  print('User Added');
}

Future<UserCustom> getUserByEmail(String email) async {
  var result = await FirebaseFirestore.instance
      .collection('Users')
      .where("email", isEqualTo: email)
      .get();
  return UserCustom.fromQuery(result.docs.first.data());
}

Future<void> addWorker(Worker worker, String email) async {
  CollectionReference workers =
      FirebaseFirestore.instance.collection('Workers');
  workers.add({
    'names': worker.names,
    'lastNames': worker.lastNames,
    'RUT': worker.RUT,
    'birthDate': worker.birthDate,
    'gender': worker.gender,
    'nationalitie': worker.nationalitie,
    'anottator': email
  });
  print('Worker Added');
}

Future<void> addWorkToday(
    String worker_name, String rut, String last_names) async {
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  CollectionReference workToday =
      FirebaseFirestore.instance.collection('TodayWork');
  workToday.add({
    'anottator': LocalData().email,
    'date': date.toString(),
    'n_cajas': "0",
    'worker_name': worker_name,
    'worker_rut': rut,
    'worker_last_name': last_names
  });
}

Future<void> addWorkToWorker(String worker_rut, String date) async {
  CollectionReference workToday =
      FirebaseFirestore.instance.collection('TodayWork');
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("worker_rut", isEqualTo: worker_rut)
      .where("date", isEqualTo: date)
      .get();
  var id = result.docs.first.id;
  var actualData = result.docs.first.data();
  int n = int.parse(actualData['n_cajas']) + 1;
  workToday.doc(id).update({
    'anottator': actualData['anottator'],
    'date': actualData['date'],
    'n_cajas': n.toString(),
    'worker_name': actualData['worker_name'],
    'worker_rut': worker_rut,
  });
  print("Work added!");
}

Future<void> removeWorkToWorker(String worker_rut, String date) async {
  CollectionReference workToday =
      FirebaseFirestore.instance.collection('TodayWork');
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("worker_rut", isEqualTo: worker_rut)
      .where("date", isEqualTo: date)
      .get();
  var id = result.docs.first.id;
  var actualData = result.docs.first.data();
  int n = int.parse(actualData['n_cajas']) - 1;
  if (n < 0) {
    n = 0;
  }
  workToday.doc(id).update({
    'anottator': actualData['anottator'],
    'date': actualData['date'],
    'n_cajas': n.toString(),
    'worker_name': actualData['worker_name'],
    'worker_rut': worker_rut,
  });
  print("Work added!");
}

Future<List<QueryDocumentSnapshot>> getWorkersByEmail(String email) async {
  print("geeting workers");
  print("email: " + email);
  var result = await FirebaseFirestore.instance
      .collection('Workers')
      .where("anottator", isEqualTo: email)
      .get();

  return result.docs;
}

Future<List<QueryDocumentSnapshot>> getWorkersAdmin() async {
  print("geeting workers");
  var result = await FirebaseFirestore.instance.collection('Workers').get();

  return result.docs;
}

Future<List<QueryDocumentSnapshot>> getWorkByDayToUser(
    String email, String date, String rut) async {
  print("geeting work from date");
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("anottator", isEqualTo: email)
      .where("date", isEqualTo: date)
      .where("worker_rut", isEqualTo: rut)
      .get();
  return result.docs;
}

Future<List> getWorkedDays(String user) async {
  CollectionReference workToday =
      FirebaseFirestore.instance.collection('TodayWork');
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("anottator", isEqualTo: user)
      .get();
  List<String> dates = [];
  result.docs.forEach((element) {
    var data = element.data()['date'];
    if (!dates.contains(data)) {
      dates.add(data);
      print(data);
    }
  });
  return dates;
}

Future<List> getWorkedDaysAdmin() async {
  CollectionReference workToday =
      FirebaseFirestore.instance.collection('TodayWork');
  var result = await FirebaseFirestore.instance.collection('TodayWork').get();
  List<String> dates = [];
  result.docs.forEach((element) {
    var data = element.data()['date'];
    if (!dates.contains(data)) {
      dates.add(data);
      print(data);
    }
  });
  return dates;
}

Future<List<QueryDocumentSnapshot>> getWorkedOnDay(
    String user, String date) async {
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("anottator", isEqualTo: user)
      .where('date', isEqualTo: date)
      .get();
  return result.docs;
}

Future<List<QueryDocumentSnapshot>> getWorkedAdminOnDay(String date) async {
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where('date', isEqualTo: date)
      .get();
  print(result.docs.length);
  return result.docs;
}

Future<int> getNWorkerToAnottator(String user) async {
  var result = await FirebaseFirestore.instance
      .collection('Workers')
      .where("anottator", isEqualTo: user)
      .get();

  return result.docs.length;
}

Future<int> getNWorkerToAdmin() async {
  var result = await FirebaseFirestore.instance.collection('Workers').get();

  return result.docs.length;
}

Future<int> getNCajasAnottator(
  String user,
) async {
  int n = 0;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where("anottator", isEqualTo: user)
      .where('date', isEqualTo: date.toString())
      .get();
  result.docs.forEach((element) {
    n = n + int.parse(element['n_cajas']);
  });
  return n;
}

Future<int> getNCajasAdmin() async {
  int n = 0;
  DateTime now = new DateTime.now();
  DateTime date = new DateTime(now.year, now.month, now.day);
  var result = await FirebaseFirestore.instance
      .collection('TodayWork')
      .where('date', isEqualTo: date.toString())
      .get();
  result.docs.forEach((element) {
    n = n + int.parse(element['n_cajas']);
  });
  return n;
}

Future<int> getAnottatorsN() async {
  var result = await FirebaseFirestore.instance
      .collection('Users')
      .where("type", isEqualTo: 'anottator')
      .get();
  return result.docs.length;
}

Future<void> deleteWorker(String rut) async {
  print("eliminando...");

  var result = await FirebaseFirestore.instance
      .collection('Workers')
      .where('RUT', isEqualTo: rut)
      .get();
  print(rut);
  print("asdasdsa");
  print(result.docs.first.id);
  var id = result.docs.first.id;
  var collection =
      FirebaseFirestore.instance.collection('Workers').doc(id).delete();
  print("Worker deleted");
}

Future<List> getAnottatorsAdmin() async {
  var result = await FirebaseFirestore.instance
      .collection('Users')
      .where('type', isEqualTo: 'anottator')
      .get();
  return result.docs;
}
