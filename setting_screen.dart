import 'package:dashboard_app/helpers/currency_helper.dart';
import 'package:dashboard_app/utils/screen_size.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';
import 'package:numberpicker/numberpicker.dart';

import '../controller/controller.dart';
import '../models/currency_data.dart';

class settingScreen extends StatefulWidget {
  const settingScreen({Key? key}) : super(key: key);

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {
  bool ischeaked = false;
  var dbHelper = CurrencyDataBase();
  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SettingScreenController>(
            init: SettingScreenController(),
            builder: (settingScreenController) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
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
                              corner: FDottedLineCorner.all(18.h),
                              color: Colors.blue,
                              height: 200.0.h,
                              width: 100.w,
                              strokeWidth: 1.5.w,
                              dottedLength: 7.0,
                              space: 5.0,
                              child: SizedBox(
                                height: 45.h,
                                width: 108.w,
                                child: Center(
                                  child: Text(
                                    'Settings',
                                    style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF2296F3)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      Text(
                        "Appearance",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Choose your light or dark theme preference",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF7C7C7C)),
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'Month Start Date',
                                content: Column(
                                  children: [
                                    Divider(color: Color(0XFFDBDBDB)),
                                    GetBuilder<SettingScreenController>(
                                      builder: (controller) => NumberPicker(
                                        value: controller.currentIntValue.value,
                                        minValue: 1,
                                        maxValue: 31,
                                        onChanged: (value) {
                                          controller.updateDate(value);
                                        },
                                      ),
                                      init: SettingScreenController(),
                                    )
                                  ],
                                ));
                          },
                          child: Text(
                            "Month Start Date",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700),
                          )),
                      Text(
                        '${settingScreenController.currentIntValue}',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF7C7C7C)),
                      ),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        child: Text("Language",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700)),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => LanguagePickerDialog(
                                titlePadding: EdgeInsets.all(8.0),
                                searchCursorColor: Colors.pinkAccent,
                                searchInputDecoration:
                                    InputDecoration(hintText: 'Search...'),
                                isSearchable: true,
                                title: Text('Select your language'),
                                onValuePicked: (Language language) =>
                                    settingScreenController
                                        .updateLanguage(language),
                                itemBuilder: buildDialogItem),
                          );
                        },
                      ),
                      Text(
                          "${settingScreenController.selectedDialogLanguage.name}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF7C7C7C))),
                      SizedBox(height: 30.h),
                      GestureDetector(
                        child: Text("Currency",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w700)),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 23.h,
                                      ),
                                      Text(
                                        "Currency",
                                        style: TextStyle(
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0XFF6A6A6A)),
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      Divider(color: Colors.black),
                                      GetBuilder<SettingScreenController>(
                                          builder: (controller) =>
                                              FutureBuilder(
                                                future: dbHelper.getData(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<CurrencyDetail>?
                                                        detail =
                                                        snapshot.data as List<
                                                            CurrencyDetail>?;

                                                    return Container(
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            detail!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return
                                                           Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15.w),
                                                            child: Row(
                                                              children: [
                                                                Radio(

                                                                    activeColor: const Color(0XFF1E88E5),
                                                                    value: settingScreenController.choice[index],
                                                                    groupValue: settingScreenController.select,
                                                                    onChanged: (value) {
                                                                      print("value is------------${settingScreenController.select}");
                                                                      settingScreenController.onClickPaymentRadioButton(value);
                                                                      ischeaked = true;
                                                                    }),
                                                                SizedBox(width: 10.w),
                                                                Text(detail[index].currencyname!,
                                                                  style: TextStyle(
                                                                      color: const Color(
                                                                          0XFF2D2D2D),
                                                                      fontSize:
                                                                          17.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        "${snapshot.error}");
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                },
                                              )),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      Text(
                          "${settingScreenController.select}",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF7C7C7C)))
                    ],
                  ),
                )),
      ),
    );
  }
}

Widget buildDialogItem(Language language) => Row(
      children: <Widget>[
        Text(language.name),
        SizedBox(width: 8.0),
        Flexible(child: Text("(${language.isoCode})"))
      ],
    );
