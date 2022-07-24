import 'package:anotame/models/user__model.dart';
import 'package:anotame/services/firebase_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'worker__model.dart';

class LocalData {
  static final LocalData _localdata = LocalData._internal();
  String email = '';
  String password = '';
  String type = '';
  String selectedDate = '';
  UserCustom? dataUser;
  Worker? worker;
  factory LocalData() {
    return _localdata;
  }

  LocalData._internal();

  Future getDataLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Email: " + prefs.getString('email').toString());
    email = prefs.getString('email').toString();
    password = prefs.getString('password').toString();
    type = prefs.getString('type').toString();
    print(email);
  }

  signOut() async {
    email = '';
    password = '';
    type = '';

    saveLocal();
  }

  saveLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    prefs.setString('type', type);
  }

  bool checkUserLogged() {
    return email != '';
  }

  signIn(String email, String password) async {
    dataUser = await getUserByEmail(email);
    this.email = email;
    this.password = password;
    this.type = dataUser?.type as String;
    await saveLocal();
  }

  saveSelectedDate(String date) {
    this.selectedDate = date;
  }

  saveWorker(Worker worker) {
    this.worker = worker;
  }

  consumeWorker() {
    this.worker = null;
  }
}
