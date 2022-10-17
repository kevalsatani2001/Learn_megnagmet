import 'package:dashboard_app/models/income_data.dart';
import 'package:dashboard_app/utils/constant.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/controller.dart';
import '../helpers/icons_helper.dart';
import '../models/icon_data.dart';
import '../utils/screen_size.dart';
import 'edit.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List<IconDetail>? detail;
  List<IncomeDetail>? incomedetail;
  RxString selectedType = Constant.typeExpence.obs;

  AddScreenController addScreenController = Get.put(AddScreenController());
  TextEditingController timeCtl = TextEditingController();
  TextEditingController amountfieldController = TextEditingController();
  var dbHelper = DataBase();
  DateTime? date = DateTime.now();
  TimeOfDay? time = TimeOfDay.now();
  List<IconData> data = [];

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: GetBuilder(
              init: AddScreenController(),
              builder: (AddScreenController) => SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        child: Icon(Icons.arrow_back_ios),
                                        onTap: () {
                                          Get.back();
                                        },
                                      ),
                                      SizedBox(width: 35.w),
                                      GestureDetector(
                                        onTap: () {},
                                        child: FDottedLine(
                                          corner: FDottedLineCorner.all(15.h),
                                          color: Colors.blue,
                                          height: 200.0.h,
                                          width: 100.w,
                                          strokeWidth: 1.5.w,
                                          dottedLength: 7.0,
                                          space: 5.0,
                                          child: SizedBox(
                                            height: 40.h,
                                            width: 150.w,
                                            child: Center(
                                              child: Text(
                                                "Add Expence",
                                                style: TextStyle(
                                                    fontSize: 22.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF2296F3)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              GetBuilder<HistoryScreenController>(
                                  init: HistoryScreenController(),
                                  builder: (controller) => Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              if (addScreenController
                                                          .expence_button ==
                                                      true &&
                                                  controller.histrytap ==
                                                      false && addScreenController.category !=null) {
                                                dbHelper.insertHistryData(
                                                    detail![addScreenController.category!]
                                                        .category_name!,
                                                    detail![addScreenController.category!]
                                                        .category_symbole!,
                                                    "${AddScreenController.time.hour}:${AddScreenController.time.minute}",
                                                    DateFormat('d MMM').format(
                                                        AddScreenController
                                                            .date),
                                                    AddScreenController.update_rate
                                                        .toString(),
                                                    DateFormat('d').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('MMM').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('y').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(
                                                            AddScreenController
                                                                .date),
                                                    "${  detail![addScreenController.category!].symbole_color}",
                                                    "expence",
                                                    detail![addScreenController.category!].id);
                                                dbHelper
                                                    .getData()
                                                    .then((value) {
                                                  setState(() {});
                                               });
                                                Get.back();
                                              } else if (controller.histrytap ==true&&detail![addScreenController.category!].category_class=='expence') {
                                                dbHelper.updateHistryData("${AddScreenController.update_rate
                                                    .toString()}",detail![addScreenController.category!].category_name!, detail![addScreenController.category!]
                                                    .category_symbole!,detail![addScreenController.category!]
                                                    .symbole_color!,detail![addScreenController.category!]
                                                    .category_class!, controller.histryDetail!.id!).then((value) => print("update true"));
                                                dbHelper
                                                    .getHistrtyData()
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                Get.back();
                                              }
                                              else if (controller.histrytap ==true&&detail![addScreenController.category!].category_class=='income') {
                                                dbHelper.updateHistryData("${AddScreenController.update_rate
                                                    .toString()}",detail![addScreenController.category!].category_name!, detail![addScreenController.category!]
                                                    .category_symbole!,detail![addScreenController.category!]
                                                    .symbole_color! ,detail![addScreenController.category!]
                                                    .category_class!,controller.histryDetail!.id!).then((value) => print("update true"));
                                                dbHelper
                                                    .getHistrtyData()
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                Get.back();
                                              }else {
                                                dbHelper.insertHistryData(
                                                    detail![addScreenController.category!]
                                                        .category_name!,
                                                    detail![addScreenController.category!]
                                                        .category_symbole!,
                                                    "${AddScreenController.time.hour}:${AddScreenController.time.minute}",
                                                    DateFormat('d MMM').format(
                                                        AddScreenController
                                                            .date),
                                                    AddScreenController.update_rate
                                                        .toString(),
                                                    DateFormat('d').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('MMM').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('y').format(
                                                        AddScreenController
                                                            .date),
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(
                                                            AddScreenController
                                                                .date),
                                                    "${detail![addScreenController.category!].symbole_color}",
                                                    "income",
                                                    detail![addScreenController.category!].id);
                                                dbHelper
                                                    .getData()
                                                    .then((value) {
                                                  setState(() {});
                                                });
                                                Get.back();
                                              }
                                            },
                                            child: Text(
                                              "Save",
                                              style: TextStyle(
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0XFF2296F3)),
                                            ),
                                          ),
                                        ],
                                      ))
                            ],
                          ),
                          Expanded(
                            child: ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: [
                                SizedBox(height: 40.h),
                                amount_field(),
                                SizedBox(height: 30.h),
                                Text(
                                  "Type",
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 20.h),
                                types(),
                                SizedBox(height: 30.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Category",
                                      style: TextStyle(
                                          fontSize: 23.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(AddExpence())!.then((value) {
                                          setState(() {});
                                        });
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF2296F3)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                GetBuilder(init:AddScreenController,builder: (controller) {
                                  String type;
                                  if(addScreenController.expence_button){
                                    type=Constant.typeExpence;
                                  }
                                  else{
                                    type=Constant.typeIncome;
                                  }
                                  return getDataList(type);
                                }, ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    date_picker(),
                                    time_picker(),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Note",
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w700)
                                ),
                                TextFormField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      hintText: 'Enter note here',
                                      hintStyle: TextStyle(
                                          color: Color(0XFF686868),
                                          fontSize: 18.sp),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0XFFEFEFEF),
                                              width: 1.w),
                                          borderRadius:
                                              BorderRadius.circular(12.h))),
                                ),
                                SizedBox(height: 10.h)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
    );
  }

  Widget amount_field() {
    return GetBuilder(
        init: SettingScreenController(),
        builder: (setcontroller) => GetBuilder(
              init: HistoryScreenController(),
              builder: (histrycontroller) => Container(
                height: 120.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFFD2D2D2).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white),
                child: Center(
                    child: TextFormField(
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0XFF666666),
                  ),
                  onChanged: (value) {
                    addScreenController.onChange_rate(double.parse(value));
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: histrycontroller.histrytap
                        ? "${histrycontroller.histryDetail!.price}"
                        : "${setcontroller.select} ${addScreenController.update_rate}",
                    hintStyle: TextStyle(
                      fontSize: 35.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF666666),
                    ),
                  ),
                )),
              ),
            ));
  }

  Widget types() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            addScreenController.onChange_button_value();

          },
          child: Container(
            height: 50.h,
            width: 120.w,
            decoration: addScreenController.expence_button
                ? BoxDecoration(
                    border: Border.all(
                      color: Color(0XFF67B7F6),
                    ),
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFFD8D8D8).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white)
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFFD8D8D8).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white),
            child: Center(
                child: Text(
              "Expense",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Color(0XFF282828),
                  fontWeight: FontWeight.w500),
            )),
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () {
            addScreenController.onChange_button_value();
          },
          child: Container(
            height: 50.h,
            width: 120.w,
            decoration: addScreenController.income_button
                ? BoxDecoration(
                    border: Border.all(
                      color: Color(0XFF67B7F6),
                    ),
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFFD8D8D8).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white)
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10.h),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0XFFD8D8D8).withOpacity(0.14),
                          offset: const Offset(-4, 5),
                          blurRadius: 16.h),
                    ],
                    color: Colors.white),
            child: Center(
                child: Text("Income",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0XFF282828),
                        fontWeight: FontWeight.w500))),
          ),
        ),
      ],
    );
  }

  Widget getDataList(String selected) {
    return FutureBuilder(
      future: dbHelper.getDataByType(selected),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          detail = snapshot.data as List<IconDetail>?;
          print("lidstgy${detail!.length}");
          return GetBuilder<HistoryScreenController>(
            init: HistoryScreenController(),
            builder: (setcontroller) => GridView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: detail!.length,
              itemBuilder: (context, index) {
                return GetBuilder<AddScreenController>(
                    init: AddScreenController(),
                    builder: (addScreencontroller) {
                      return GestureDetector(
                        onTap: () {
                          addScreenController
                              .onchange_category_position(
                              index, detail![index].id);
                        },
                        child: setcontroller.histrytap
                            ? Container(
                            decoration:
                            addScreenController.category==index
                                ? BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12.h),
                                border: Border.all(
                                    color:Color(0XFF67B7F6)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0XFFD5D5D5)
                                          .withOpacity(0.10),
                                      offset:
                                      const Offset(-4, 5),
                                      blurRadius: 16.h),
                                ],
                                color: Colors.white)
                                : BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0XFFD5D5D5)
                                          .withOpacity(0.10),
                                      offset:
                                      const Offset(-4, 5),
                                      blurRadius: 16.h),
                                ],
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                if (detail![index]
                                    .category_symbole!
                                    .split('.')
                                    .last
                                    .toString() ==
                                    "svg") ...[
                                  SvgPicture.asset(
                                    'asset/${detail![index].category_symbole}',
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ] else ...[
                                  Icon(
                                    IconData(
                                        int.parse(detail![index]
                                            .category_symbole!),
                                        fontFamily:
                                        'MaterialIcons'),
                                    color: Color(int.parse(
                                        detail![index]
                                            .symbole_color!)),
                                  )
                                ],
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w),
                                  child: Text(
                                      detail![index].category_name!,
                                      style: TextStyle(
                                        overflow:
                                        TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                      )),
                                ),
                              ],
                            ))
                            : Container(
                            decoration: addScreenController
                                .category ==
                                index
                                ? BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12.h),
                                border: Border.all(
                                    color: Color(0XFF67B7F6)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0XFFD5D5D5)
                                          .withOpacity(0.10),
                                      offset:
                                      const Offset(-4, 5),
                                      blurRadius: 16.h),
                                ],
                                color: Colors.white)
                                : BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0XFFD5D5D5)
                                          .withOpacity(0.10),
                                      offset:
                                      const Offset(-4, 5),
                                      blurRadius: 16.h),
                                ],
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                if (detail![index]
                                    .category_symbole!
                                    .split('.')
                                    .last
                                    .toString() ==
                                    "svg") ...[
                                  SvgPicture.asset(
                                    'asset/${detail![index].category_symbole}',
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ] else ...[
                                  Icon(
                                    IconData(
                                        int.parse(detail![index]
                                            .category_symbole!),
                                        fontFamily:
                                        'MaterialIcons'),
                                    color: Color(int.parse(
                                        detail![index]
                                            .symbole_color!)),
                                  )
                                ],
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w),
                                  child: Text(
                                      detail![index].category_name!,
                                      style: TextStyle(
                                        overflow:
                                        TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                      )),
                                ),
                              ],
                            )),
                      )
                         ;
                    });
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 100,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10.h),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget date_picker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date",
            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700)),
        GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now())
                .then((value) => {addScreenController.onChange_date(value!)});
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0XFFF0F0F0),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              height: 45.h,
              width: 160.w,
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('dd/MM/yyyy')
                            .format(addScreenController.date),
                        style: TextStyle(fontSize: 18)),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              ))),
        ),
      ],
    );
  }

  Widget time_picker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Time",
            style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w700)),
        GestureDetector(
          onTap: () {
            showTimePicker(context: context, initialTime: TimeOfDay.now())
                .then((value) => {addScreenController.onChange_time(value!)});
          },
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0XFFF0F0F0),
                  ),
                  borderRadius: BorderRadius.circular(10)),
              height: 45.h,
              width: 160.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat.Hm().format(DateTime.now()),
                      style: TextStyle(fontSize: 18),
                    ),
                    Icon(Icons.arrow_drop_down)
                  ],
                ),
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    amountfieldController.dispose();
    super.dispose();
  }
}
