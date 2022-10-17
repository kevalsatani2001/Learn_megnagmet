class HistryGraph{
  final int? id;
  final int? total;
  final String? category_name;
  final  String? category_symbole;
  final  String? time;
  final String? date;
  int? price;
  final String? add_day;
  final String? add_month;
  final String? add_year;
  final String? full_date;
  final String? icon_color;
  final  String?category_class;
  final int? main_id;

  HistryGraph(
      {this.id,
      this.total,
      this.category_name,
      this.category_symbole,
      this.time,
      this.date,
      this.add_day,
      this.add_month,
      this.add_year,
      this.full_date,
      this.icon_color,
      this.category_class,
      this.main_id,
      this.price = 0});
}