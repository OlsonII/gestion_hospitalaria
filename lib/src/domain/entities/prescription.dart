import 'dart:convert';

import 'medicine.dart';

Prescription prescriptionFromJson(String str) => Prescription.fromJson(json.decode(str));

String prescriptionToJson(Prescription data) => json.encode(data.toJson());

class Prescription {
  String id;
  DateTime creationDate;
  DateTime expirationDate;
  List<Medicine> medicines;
  String state;

  Prescription({
    this.id,
    this.creationDate,
    this.expirationDate,
    this.medicines,
    this.state,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {

    List<Medicine> medicinesList;

    var list = json['medicines'] as List;
    list != null ? medicinesList = list.map((medicine) => Medicine.fromJson(new Map<String, dynamic>.from(medicine))).toList() : medicinesList = [];

      return  Prescription(
          id: json["id"],
          creationDate: DateTime.parse(json["creation_date"]),
          expirationDate: DateTime.parse(json["expiration_date"]),
          medicines: medicinesList,
          state: json["state"],
        );
  }

  Map<String, dynamic> toJson() => {
    "creation_date": creationDate.toIso8601String(),
    "expiration_date": expirationDate.toIso8601String(),
    "medicines": mapMecinesToJson(),
    "state": state,
  };

  mapMecinesToJson(){

    var medicinesList = new List();
    medicines.forEach((element) {
      medicinesList.add(element.toJson());
    });
    return medicinesList != null ? medicinesList : medicinesList = [];

  }
}