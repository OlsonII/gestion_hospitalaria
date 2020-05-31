
import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/person.dart';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient extends Person {
  String identification;
  String name;
  String surname;
  int age;
  String gender;
  String eps;
  int stratum;
  double discount;

  Patient({
    this.identification,
    this.name,
    this.surname,
    this.age,
    this.gender,
    this.eps,
    this.stratum,
    this.discount,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    identification: json["id"],
    name: json["name"],
    surname: json["surname"],
    age: json["age"],
    gender: json["gender"],
    eps: json["eps"],
    stratum: json["stratum"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "identification": identification,
    "name": name,
    "surname": surname,
    "age": age,
    "gender": gender,
    "eps": eps,
    "stratum": stratum
  };
}