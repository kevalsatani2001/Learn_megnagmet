import 'dart:convert';

List<IncomeDetail> demoFromJson(String str) => List<IncomeDetail>.from(
    json.decode(str).map((x) => IncomeDetail.fromJson(x)));

String demoToJson(List<IncomeDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeDetail {
  IncomeDetail({
    required this.id,
    required this.category_name,
    required this.category_symbole,
    required this.symbole_color});

  int id;
  String? category_name;
  String? category_symbole;
  String? symbole_color;

  factory IncomeDetail.fromJson(Map<String, dynamic> json) => IncomeDetail(
      id: json["id"],
      category_name: json["category_name"],
      category_symbole: json["category_symbole"],
      symbole_color:json["symbole_color"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": category_name,
    "category_image": category_symbole,
    "symbole_color":symbole_color
  };
}
