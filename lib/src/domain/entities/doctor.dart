import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/person.dart';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor extends Person {

  String id;
  String name;
  String surname;
  int age;
  String gender;
  String degree;
  int experience;
  String workday;

  Doctor({
    this.id,
    this.name,
    this.surname,
    this.age,
    this.gender,
    this.degree,
    this.experience,
    this.workday,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["id"],
    name: json["name"],
    surname: json["surname"],
    age: json["age"],
    gender: json["gender"],
    degree: json["degree"],
    experience: json["experience"],
    workday: json["workday"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "surname": surname,
    "age": age,
    "gender": gender,
    "degree": degree,
    "experience": experience,
    "workday": workday,
  };
}