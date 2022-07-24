// ignore_for_file: non_constant_identifier_names


class Worker {
  String? names;
  String? lastNames;
  String? RUT;
  String? birthDate;
  String? gender;
  String? nationalitie;
  String? anottator;
  Worker(
      {this.names,
      this.lastNames,
      this.RUT,
      this.birthDate,
      this.gender,
      this.nationalitie,
      this.anottator});
  Worker.fromQuery(Map<String, dynamic> data) {
    names = data['name'];
    lastNames = data['lastNames'];
    RUT = data['RUT'];
    birthDate = data['birthDate'];
    gender = data['gender'];
    nationalitie = data['nationalite'];
    anottator = data['anottator'];
  }
}
