
import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/person.dart';

Patient patientFromJson(String str) => Patient.fromJson(json.decode(str));

String patientToJson(Patient data) => json.encode(data.toJson());

class Patient extends Person {
  String id;
  String name;
  String surname;
  int age;
  String gender;
  String eps;
  int stratum;
  int discount;

  Patient({
    this.id,
    this.name,
    this.surname,
    this.age,
    this.gender,
    this.eps,
    this.stratum,
    this.discount,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    age: json["age"],
    gender: json["gender"],
    eps: json["eps"],
    stratum: json["stratum"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "age": age,
    "gender": gender,
    "eps": eps,
    "stratum": stratum,
    "discount": discount,
  };
}