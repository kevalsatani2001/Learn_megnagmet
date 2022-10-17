import 'dart:convert';

import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:dashboard_app/home/add_screen.dart';
import 'package:dashboard_app/home/edit.dart';
import 'package:dashboard_app/models/histry_data.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../controller/controller.dart';
import '../utils/constant_widget.dart';
import '../utils/screen_size.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int m = DateTime.now().month - 1;
  var dbHelper = DataBase();
  HistoryScreenController historyScreenController =
      Get.put(HistoryScreenController());
  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder(
            init: HistoryScreenController(),
            builder: (HistoryScreenController) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FDottedLine(
                          corner: FDottedLineCorner.all(20.h),
                          color: Colors.blue,
                          height: 200.0.h,
                          width: 100.w,
                          strokeWidth: 1.5.w,
                          dottedLength: 7.0,
                          space: 5.0,
                          child: SizedBox(
                            height: 50.h,
                            width: 110.w,
                            child: Center(
                              child: Text(
                                "History",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: const Icon(Icons.filter_list),
                          onTap: () {
                            filter_dialogue();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      getMonth(DateFormat.MMM().format(DateTime.now()),
                          containercolor: Colors.blue,
                          color: Colors.white,
                          fontsize: 18.sp,
                          fontwidth: FontWeight.w500),
                      SizedBox(
                        width: 15.w,
                      ),
                      getMonth(
                          DateFormat.MMM().format(
                              DateTime.now().subtract(Duration(days: 30))),
                          containercolor: Colors.grey.withOpacity(0.14),
                          color: Colors.blue,
                          fontsize: 18.sp,
                          fontwidth: FontWeight.w500),
                    ],
                  ),
                  Expanded(
                    child: category_list(),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future filter_dialogue() {
    return Get.defaultDialog(
        title: '',
        content: SizedBox(
          width: 350.w,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              historyScreenController.onHistryfilterbutton(1);
                              Get.back();
                            },
                            child: Container(
                                height: 50,
                                decoration: historyScreenController
                                            .hisrypositionbutton ==
                                        1
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.h),
                                        border: Border.all(
                                            color: Color(0XFF67B7F6)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0XFFD5D5D5)
                                                  .withOpacity(0.10),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16.h),
                                        ],
                                        color: Colors.white)
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFDCDCDC),
                                            offset: const Offset(0, 1.5),
                                          ),
                                        ],
                                        color: Colors.white),
                                child: Center(
                                    child: Text("All",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)))))),
                    SizedBox(width: 9.w),
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              historyScreenController.onHistryfilterbutton(2);
                              Get.back();
                            },
                            child: Container(
                                height: 50,
                                decoration: historyScreenController
                                            .hisrypositionbutton ==
                                        2
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.h),
                                        border: Border.all(
                                            color: Color(0XFF67B7F6)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0XFFD5D5D5)
                                                  .withOpacity(0.10),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16.h),
                                        ],
                                        color: Colors.white)
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFDCDCDC),
                                            offset: const Offset(0, 1.5),
                                          ),
                                        ],
                                        color: Colors.white),
                                child: Center(
                                    child: Text("Expence",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)))))),
                    SizedBox(width: 9.w),
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              historyScreenController.onHistryfilterbutton(3);
                              Get.back();
                            },
                            child: Container(
                                height: 50,
                                decoration: historyScreenController
                                            .hisrypositionbutton ==
                                        3
                                    ? BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.h),
                                        border: Border.all(
                                            color: Color(0XFF67B7F6)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0XFFD5D5D5)
                                                  .withOpacity(0.10),
                                              offset: const Offset(-4, 5),
                                              blurRadius: 16.h),
                                        ],
                                        color: Colors.white)
                                    : BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0XFFDCDCDC),
                                            offset: const Offset(0, 1.5),
                                          ),
                                        ],
                                        color: Colors.white),
                                child: Center(
                                    child: Text("Income",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)))))),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 50.h,
                  width: 80.w,
                  child: Center(
                      child: Text(
                    DateFormat.y().format(DateTime.now()),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0XFFFFFFFF)),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.h),
                    color: Color(0XFF2196F3),
                  ),
                )
              ],
            ),
          ),
        )).then((value) => setState(() {}));
  }

  Widget category_list() {
    return FutureBuilder(
      future: dbHelper.getHistrtyData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<HistryDetail>? detail = snapshot.data as List<HistryDetail>?;
          return StickyGroupedListView<HistryDetail, String>(
            elements: detail!,
            groupBy: (element) {
              return element.full_date!;
            },
            groupSeparatorBuilder: (dynamic element) {
              return Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Text(
                  "${element.add_day} ${element.add_month},${element.add_year}",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
                ),
              );
            },
            itemBuilder: (context, dynamic element) {
              if (historyScreenController.hisrypositionbutton == 2) {
                if (element.category_class == 'expence') {
                  return GetBuilder<SettingScreenController>(
                    init: SettingScreenController(),
                    builder: (controller) => GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Menu',
                            content: Column(
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            historyScreenController
                                                .onHistryTapChange(true);
                                            historyScreenController.onSetid(
                                                HistryDetail(
                                                    id: element.id,
                                                    category_name: element
                                                        .category_name,
                                                    category_symbole: element
                                                        .category_symbole,
                                                    time: element.time,
                                                    date: element.date,
                                                    price: element.price,
                                                    add_day: element.add_day,
                                                    add_month:
                                                        element.add_month,
                                                    add_year: element.add_year,
                                                    full_date:
                                                        element.full_date,
                                                    icon_color:
                                                        element.icon_color,
                                                    category_class:
                                                        element.category_class,
                                                    main_id: element.main_id));
                                            Get.to(AddScreen())!.then(
                                                (value) => setState(() {}));
                                            dbHelper.getHistrtyData().then(
                                                (value) => setState(() {}));
                                          },
                                          child: Text("Edit")),
                                      TextButton(
                                          onPressed: () {
                                            dbHelper
                                                .deleteHistryData(element.id)
                                                .then(
                                                    (value) => setState(() {}));
                                            dbHelper.getHistrtyData().then(
                                                (value) => setState(() {}));
                                            Get.back();
                                          },
                                          child: Text("Delete")),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (element.category_symbole!
                                        .split('.')
                                        .last
                                        .toString() ==
                                    "svg") ...[
                                  SvgPicture.asset(
                                    'asset/${element.category_symbole}',
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ] else ...[
                                  Icon(
                                    IconData(
                                      int.parse(element.category_symbole!),
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    size: 30,
                                    color:
                                        Color(int.parse(element.icon_color!)),
                                  )
                                ],
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${element.category_name!}",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        Text(element.date!,
                                            style: TextStyle(
                                                color: Color(0XFF747474),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(width: 10.w),
                                        Text(element.time!,
                                            style: TextStyle(
                                                color: Color(0XFF747474),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text("${controller.select}${element.price}",
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else if (historyScreenController.hisrypositionbutton == 3) {
                if (element.category_class == 'income') {
                  return GetBuilder<SettingScreenController>(
                    init: SettingScreenController(),
                    builder: (controller) => GestureDetector(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Menu',
                            content: Column(
                              children: [
                                Center(
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            historyScreenController
                                                .onHistryTapChange(true);
                                            historyScreenController.onSetid(
                                                HistryDetail(
                                                    id: element.id,
                                                    category_name: element
                                                        .category_name,
                                                    category_symbole: element
                                                        .category_symbole,
                                                    time: element.time,
                                                    date: element.date,
                                                    price: element.price,
                                                    add_day: element.add_day,
                                                    add_month:
                                                    element.add_month,
                                                    add_year: element.add_year,
                                                    full_date:
                                                    element.full_date,
                                                    icon_color:
                                                    element.icon_color,
                                                    category_class:
                                                    element.category_class,
                                                    main_id: element.main_id));
                                            Get.to(AddScreen())!.then(
                                                    (value) => setState(() {}));
                                            dbHelper.getHistrtyData().then(
                                                    (value) => setState(() {}));
                                          },
                                          child: Text("Edit")),
                                      TextButton(
                                          onPressed: () {
                                            dbHelper
                                                .deleteHistryData(element.id)
                                                .then(
                                                    (value) => setState(() {}));
                                            dbHelper.getHistrtyData().then(
                                                    (value) => setState(() {}));
                                            Get.back();
                                          },
                                          child: Text("Delete")),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                if (element.category_symbole!
                                        .split('.')
                                        .last
                                        .toString() ==
                                    "svg") ...[
                                  SvgPicture.asset(
                                    'asset/${element.category_symbole}',
                                    height: 20.h,
                                    width: 20.w,
                                  )
                                ] else ...[
                                  Icon(
                                      IconData(
                                          int.parse(element.category_symbole!),
                                          fontFamily: 'MaterialIcons'),
                                      size: 30,
                                      color:
                                          Color(int.parse(element.icon_color!)))
                                ],
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${element.category_name!}",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Row(
                                      children: [
                                        Text(element.date!,
                                            style: TextStyle(
                                                color: Color(0XFF747474),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(width: 10.w),
                                        Text(element.time!,
                                            style: TextStyle(
                                                color: Color(0XFF747474),
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text("${controller.select}${element.price}",
                                style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return GetBuilder<SettingScreenController>(
                  init: SettingScreenController(),
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: 'Menu',
                          content: Column(
                            children: [
                              Center(
                                child: Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          historyScreenController
                                              .onHistryTapChange(true);
                                          historyScreenController.onSetid(
                                              HistryDetail(
                                                  id: element.id,
                                                  category_name: element
                                                      .category_name,
                                                  category_symbole: element
                                                      .category_symbole,
                                                  time: element.time,
                                                  date: element.date,
                                                  price: element.price,
                                                  add_day: element.add_day,
                                                  add_month:
                                                  element.add_month,
                                                  add_year: element.add_year,
                                                  full_date:
                                                  element.full_date,
                                                  icon_color:
                                                  element.icon_color,
                                                  category_class:
                                                  element.category_class,
                                                  main_id: element.main_id));
                                          Get.to(AddScreen())!.then(
                                                  (value) => setState(() {}));
                                          dbHelper.getHistrtyData().then(
                                                  (value) => setState(() {}));
                                        },
                                        child: Text("Edit")),
                                    TextButton(
                                        onPressed: () {
                                          dbHelper
                                              .deleteHistryData(element.id)
                                              .then(
                                                  (value) => setState(() {}));
                                          dbHelper.getHistrtyData().then(
                                                  (value) => setState(() {}));
                                          Get.back();
                                        },
                                        child: Text("Delete")),
                                  ],
                                ),
                              )
                            ],
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              if (element.category_symbole!
                                      .split('.')
                                      .last
                                      .toString() ==
                                  "svg") ...[
                                SvgPicture.asset(
                                  'asset/${element.category_symbole}',
                                  height: 20.h,
                                  width: 20.w,
                                )
                              ] else ...[
                                Icon(
                                  IconData(
                                    int.parse(element.category_symbole!),
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  size: 30,
                                  color: Color(int.parse(element.icon_color!)),
                                )
                              ],
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${element.category_name!}",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Row(
                                    children: [
                                      Text(element.date!,
                                          style: TextStyle(
                                              color: Color(0XFF747474),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(width: 10.w),
                                      Text(element.time!,
                                          style: TextStyle(
                                              color: Color(0XFF747474),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text("${controller.select}${element.price}",
                              style: TextStyle(
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            },
            itemScrollController: itemScrollController,
            order: StickyGroupedListOrder.ASC,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
