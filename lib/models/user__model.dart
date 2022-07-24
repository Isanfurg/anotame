// ignore_for_file: non_constant_identifier_names

class UserCustom {
  String? email;
  String? names;
  String? lastNames;
  String? RUT;
  String? birthDate;
  String? type;
  UserCustom({
    this.email,
    this.names,
    this.lastNames,
    this.RUT,
    this.birthDate,
    this.type,
  });
  UserCustom.fromQuery(Map<String, dynamic> data) {
    names = data['name'];
    lastNames = data['lastNames'];
    RUT = data['RUT'];
    birthDate = data['birthDate'].toString();
    type = data['type'];
    email = data['email'];
  }
}
