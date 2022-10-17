import 'dart:convert';

import 'package:dashboard_app/models/icon_data.dart';

List<CurrencyDetail> demoFromJson(String str) => List<CurrencyDetail>.from(
    json.decode(str).map((x) => IconDetail.fromJson(x)));

String demoToJson(List<CurrencyDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyDetail {
  CurrencyDetail({
    required this.id,
    required this.currencyname,});

  int id;
  String? currencyname;

  factory CurrencyDetail.fromJson(Map<String, dynamic> json) => CurrencyDetail(
    id: json["id"],
    currencyname: json["currencyname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currencyname": currencyname,
  };
}
