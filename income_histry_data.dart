import 'dart:convert';

List<IncomeHistryDetail> demoFromJson(String str) => List<IncomeHistryDetail>.from(
    json.decode(str).map((x) => IncomeHistryDetail.fromJson(x)));

String demoToJson(List<IncomeHistryDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeHistryDetail {
  IncomeHistryDetail(
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
        required this.icon_color});

  int id;
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

  factory IncomeHistryDetail.fromJson(Map<String, dynamic> json) => IncomeHistryDetail(
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
      icon_color:json["icon_color"]);

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
    "icon_color":icon_color
  };
}
