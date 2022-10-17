import 'dart:convert';

List<IconDetail> demoFromJson(String str) => List<IconDetail>.from(
    json.decode(str).map((x) => IconDetail.fromJson(x)));

String demoToJson(List<IconDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IconDetail {
  IconDetail({
    required this.id,
    required this.category_name,
    required this.category_symbole,
  required this.symbole_color,
  required this.category_class});

  int id;
  String? category_name;
  String? category_symbole;
  String? symbole_color;
  String? category_class;

  factory IconDetail.fromJson(Map<String, dynamic> json) => IconDetail(
      id: json["id"],
  category_name: json["category_name"],
    category_symbole: json["category_symbole"],
      symbole_color:json["symbole_color"],
      category_class:json["category_class"]
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_name": category_name,
    "category_image": category_symbole,
    "symbole_color":symbole_color,
    "category_class":category_class
  };
}
