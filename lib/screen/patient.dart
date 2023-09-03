// To parse this JSON data, do
//
//     final patients = patientsFromJson(jsonString);

import 'dart:convert';

List<Patients> patientsFromJson(String str) =>
    List<Patients>.from(json.decode(str).map((x) => Patients.fromJson(x)));

String patientsToJson(List<Patients> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patients {
  int? id;
  String? name;
  int? age;
  String? gender;
  String? symptoms;
  String? disease;
  String? treatment;

  Patients({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.symptoms,
    this.disease,
    this.treatment,
  });

  factory Patients.fromJson(Map<String, dynamic> json) => Patients(
        id: json["id"],
        name: json["Name"],
        age: json["Age"],
        gender: json["Gender"],
        symptoms: json["Symptoms"],
        disease: json["Disease"],
        treatment: json["Treatment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Age": age,
        "Gender": gender,
        "Symptoms": symptoms,
        "Disease": disease,
        "Treatment": treatment,
      };
}
