
import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/i_medical_service.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';

MedicalExam medicalExamFromJson(String str) => MedicalExam.fromJson(json.decode(str));

String medicalExamToJson(MedicalExam data) => json.encode(data.toJson());

class MedicalExam implements IMedicalService{
  @override
  double cost;

  @override
  DateTime date;

  @override
  Patient patient;

  @override
  String state;

  @override
  String time;

  @override
  int turn;

  String name;

  int id;

  MedicalExam({
    this.id,
    this.cost,
    this.date,
    this.patient,
    this.state,
    this.time,
    this.turn,
    this.name
  });

  factory MedicalExam.fromJson(Map<String, dynamic> json) => MedicalExam(
    id: json["id"],
    patient: Patient.fromJson(json["patient"]),
    date: DateTime.parse(json["date"]),
    time: json["time"],
    turn: json["turn"],
    state: json["state"],
    cost: json["cost"],
  );

  Map<String, dynamic> toJson() => {
    "identification": this.id == null ? 0 : this.id,
    "patient": {
      "id": patient.identification
    },
    "date": date.toIso8601String()
  };
}