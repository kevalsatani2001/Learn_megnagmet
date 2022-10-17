import 'dart:convert';

List<HistryDetail> demoFromJson(String str) => List<HistryDetail>.from(
    json.decode(str).map((x) => HistryDetail.fromJson(x)));

String demoToJson(List<HistryDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistryDetail {
  HistryDetail(
      {required this.id,
      required this.category_name,
      required this.category_symbole,
      required this.time,
      required this.date,
        required this.price,
      required this.add_day,
      required this.add_month,
      required this.add_year,
      required this.full_date,
      required this.icon_color,
        this.total,
      required this.category_class,
      required this.main_id});

  int? id;
  int? total;
  String? category_name;
  String? category_symbole;
  String? time;
  String? date;
  String? price;
  String? add_day;
  String? add_month;
  String? add_year;
  String? full_date;
  String? icon_color;
  String?category_class;
  int? main_id;

  factory HistryDetail.fromJson(Map<String, dynamic> json) => HistryDetail(
      id: json["id"],
      category_name: json["category_name"],
      category_symbole: json["category_symbole"],
      time: json["time"],
      date: json["date"],
      price:json["price"],
      add_day: json["add_day"],
      add_month: json["add_month"],
      add_year: json["add_year"],
  full_date:json["full_date"],
  icon_color:json["icon_color"],
      category_class:json["category_class"],
  main_id:json["main_id"]);



  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": category_name,
        "category_image": category_symbole,
        "time": time,
        "date": date,
    "price":price,
        "add_day": add_day,
        "add_month": add_month,
        "add_year": add_year,
    "full_date":full_date,
    "icon_color":icon_color,
    "category_class":category_class,
    "main_id":main_id
      };
}
