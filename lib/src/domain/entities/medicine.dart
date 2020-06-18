import 'dart:convert';

Medicine medicineFromJson(String str) => Medicine.fromJson(json.decode(str));

String medicineToJson(Medicine data) => json.encode(data.toJson());

class Medicine {
  int id;
  String name;
  int quantity;
  int periodicity;

  Medicine({
    this.id,
    this.name,
    this.quantity,
    this.periodicity,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
    id: json["id"],
    name: json["name"],
    quantity: int.parse(json["quantity"]),
    periodicity: int.parse(json["periodicity"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "periodicity": periodicity == null ? 0 : periodicity,
  };
}
