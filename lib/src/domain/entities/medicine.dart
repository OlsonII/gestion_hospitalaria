import 'dart:convert';

Medicine medicineFromJson(String str) => Medicine.fromJson(json.decode(str));

String medicineToJson(Medicine data) => json.encode(data.toJson());

class Medicine {
  String id;
  String nane;
  String quantity;
  String periodicity;

  Medicine({
    this.id,
    this.nane,
    this.quantity,
    this.periodicity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["id"],
    nane: json["nane"],
    quantity: json["quantity"],
    periodicity: json["periodicity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nane": nane,
    "quantity": quantity,
    "periodicity": periodicity,
  };
}
