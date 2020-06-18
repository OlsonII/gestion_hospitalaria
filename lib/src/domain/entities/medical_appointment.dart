
import 'dart:convert';

import 'package:gestion_hospitalaria/src/domain/entities/doctor.dart';
import 'package:gestion_hospitalaria/src/domain/entities/i_medical_service.dart';
import 'package:gestion_hospitalaria/src/domain/entities/patient.dart';
import 'package:gestion_hospitalaria/src/domain/entities/prescription.dart';

MedicalAppointment medicalAppointmentFromJson(String str) => MedicalAppointment.fromJson(json.decode(str));

String medicalAppointmentToJson(MedicalAppointment data) => json.encode(data.toJson());

class MedicalAppointment implements IMedicalService{

  @override
  String time;
  @override
  int turn;
  @override
  double cost;
  @override
  DateTime date;
  @override
  String state;
  @override
  Patient patient;
  Doctor doctor;
  int id;
  Prescription prescription;

  MedicalAppointment({
    this.id,
    this.doctor,
    this.patient,
    this.date,
    this.time,
    this.turn,
    this.state,
    this.prescription,
    this.cost
  });

  factory MedicalAppointment.fromJson(Map<String, dynamic> json) => MedicalAppointment(
    id: json["id"],
    doctor: Doctor.fromJson(json["doctor"]),
    patient: Patient.fromJson(json["patient"]),
    date: DateTime.parse(json["date"]),
    time: json["time"],
    turn: json["turn"],
    state: json["state"],
    cost: json["cost"],
//    prescription: Prescription.fromJson(json["Prescription"]),
  );

  Map<String, dynamic> toJson() => {
    "identification": this.id == null ? 0 : this.id,
    "doctor": {
      "id": doctor.identification
    },
    "patient": {
      "id": patient.identification
    },
    "date": date.toIso8601String(),
    "prescription": prescription.toJson()
  };

  Map<String, dynamic> complete(){
    return {
      "identification": this.id == null ? 0 : this.id,
      "prescription": prescription.toJson()
    };
  }

}