import 'dart:convert';

import 'medicine.dart';

Prescription prescriptionFromJson(String str) => Prescription.fromJson(json.decode(str));

String prescriptionToJson(Prescription data) => json.encode(data.toJson());

class Prescription {
  String id;
  String creationDate;
  String expirationDate;
  List<Medicine> medicines;
  String state;

  Prescription({
    this.id,
    this.creationDate,
    this.expirationDate,
    this.medicines,
    this.state,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
    id: json["id"],
    creationDate: json["creation_date"],
    expirationDate: json["expiration_date"],
    medicines: List<Medicine>.from(json["medicines"].map((x) => Medicine.fromJson(x))),
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "creation_date": creationDate,
    "expiration_date": expirationDate,
    "medicines": List<dynamic>.from(medicines.map((x) => x.toJson())),
    "state": state,
  };
}