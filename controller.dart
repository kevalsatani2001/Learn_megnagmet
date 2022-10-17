

import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:dashboard_app/models/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:language_picker/languages.dart';

import '../models/histry_data.dart';
var dbHelper = DataBase();
class MainHomeScreenController extends GetxController {
  List<IconDetail>? detail;
  RxInt position = 0.obs;
  double to= 0.0;
  var dbHelper = DataBase();

  onChange(int value) {
    position.value = value;
    update();
  }
  onRefreshData(var data){
    detail = data;
    update();
  }

 onTotal(double totalprice) {
    to=totalprice;
    update();
 }
}

class AddScreenController extends GetxController {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
double update_rate = 00.00;
bool expence_button=true;
  bool income_button=false;
  // int category=1;

  int? category=0;
  int? categoryid=1;

  onChange_rate(double rate){
    update_rate=rate;
    update();
  }
  onChange_date(DateTime d){
    date=d;
    update();
  }
  onChange_time(TimeOfDay t){
    time=t;
    update();
  }
  onChange_button_value(){
    expence_button=!expence_button;
    income_button=!income_button;
    update();
  }
  onchange_category_position(int index, int id){
    category=index;
    categoryid=id;
    update();
  }
}

class AddExpenceController extends GetxController{
  bool selection=true;
  int? selectionid;
  String? cat_color;
  String? cat_icon;
  String? cat_name;

  selectionChange(bool val){
selection=val;
  }
  onSelectionid(int val){
    selectionid=val;
    update();
  }
  oncategoryData(String color,String name,String symbol){
    cat_color=color;
    cat_name=name;
    cat_icon=symbol;
    update();
  }
}

class AddNewCategoryController extends GetxController {
  IconData? icon;
  String? icon1st;
  String? icon2nd;
  String? color1st;
  String? color2nd;


  Color mycolor = Colors.lightBlue;

  iconChange(IconData value) {
    icon = value;
    update();
  }
  onChange(Color color) {
    mycolor = color;
    update();
  }
  onIconStringSplite(String val){
    icon1st = val.split('+').last.toString();
    icon2nd = icon1st.toString().split(')').first.toString().toLowerCase();
    update();
  }
  onColorStringSplite(String val){
    color1st = val.split('(').last.toString().toLowerCase();
    color2nd = color1st.toString().split(')').first.toString().toUpperCase();
    update();
  }

}

class HistoryScreenController extends GetxController {
  bool histrytap = false;
  double total=0;
  // String? pri;
  int hisrypositionbutton =1;
  // int? histryid;
  int? subid;

  HistryDetail? histryDetail;
  onTotal(String val){
    double value= double.parse(val);
    total=value+total;
    subid=histryDetail!.main_id;
    update();
  }

  onHistryfilterbutton(int i) {
    hisrypositionbutton=i;
    update();
  }
  onHistryTapChange(bool val){
    histrytap = val;
    update();
  }




  onSetid(HistryDetail detail) {
  // onSetid(int id, String price,int mainId) {
    histryDetail=detail;
    // pri= price;
    update();
  }

}

class SettingScreenController extends GetxController {
  RxInt currentIntValue = 1.obs;
  Language selectedDialogLanguage = Languages.korean;
  final List<String> choice = ['\$','€','£', '¥','₹'];
  var option;
  String? select='₹';

  updateRadio(String val){
    option=val;
    update();
  }

updateDate(int val){
  currentIntValue.value=val;
  update();
}
updateLanguage(Language language){
  selectedDialogLanguage=language;
  update();
}
  void onClickPaymentRadioButton(value) {
    print(value);
    select = value;
    update();
  }
}

class ManageCategoryScreenController extends GetxController{}

class StatisticsScreenController extends GetxController{
 double Incometotal = 0.0;
  double Expencetotal = 0.0;
  onIncomeTotal(double income,double expence) {
    Incometotal=Incometotal+income;
    Expencetotal=Expencetotal+expence ;
    update();
  }
}