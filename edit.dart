import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/models/income_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../helpers/icons_helper.dart';
import '../models/icon_data.dart';
import '../utils/constant_widget.dart';
import '../utils/screen_size.dart';
import 'add_new_category.dart';

class AddExpence extends StatefulWidget {
  const AddExpence({Key? key}) : super(key: key);

  @override
  State<AddExpence> createState() => _AddExpenceState();
}

class _AddExpenceState extends State<AddExpence> {
  AddExpenceController addExpenceController = Get.put(AddExpenceController());
  var dbHelper = DataBase();

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: GetBuilder(
        init: AddExpenceController(),
        builder: (AddExpenceController) => Scaffold(
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                getAppbar("Category list", "Add New", () {}, () {
                  addExpenceController.selectionChange(true);
                  addExpenceController.selection?Get.to(AddNewCategory())!.then((value) {
                    setState(() {});
                  }):SizedBox();
                }),
                SizedBox(height: 20.h),
                types(),
                SizedBox(height: 20.h),
                Expanded(
                    child: GetBuilder<AddScreenController>(
                      init: AddScreenController(),
                      builder:(controller) => ListView(
                  children: [
                    controller.expence_button?
                      category_list():income_category_list(),
                  ],
                ),
                    ))
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget types() {
    return GetBuilder<AddScreenController>(
      init: AddScreenController(),
    builder:(controller) =>  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
             controller.onChange_button_value();
            },
            child: Container(
              height: 55.h, width: 170.w,
              //color: Colors.red,
              decoration: controller.expence_button?BoxDecoration(
                  border: Border.all(color: Color(0XFF67B7F6),),
                  borderRadius: BorderRadius.circular(10.h),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0XFFD8D8D8).withOpacity(0.14),
                        offset: const Offset(-4, 5),
                        blurRadius: 16.h),
                  ],
                  color: Colors.white):BoxDecoration(
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
          SizedBox(width: 15.w),
          GestureDetector(
            onTap: (){ controller.onChange_button_value();},
            child: Container(
              height: 55.h, width: 170.w,
              decoration:controller.income_button?BoxDecoration(
    border: Border.all(color: Color(0XFF67B7F6),),
    borderRadius: BorderRadius.circular(10.h),
    boxShadow: [
    BoxShadow(
    color: const Color(0XFFD8D8D8).withOpacity(0.14),
    offset: const Offset(-4, 5),
    blurRadius: 16.h),
    ],
    color: Colors.white):BoxDecoration(
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
      ),
    );
  }
  Widget category_list() {
    return FutureBuilder(
      future: dbHelper.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<IconDetail>? detail = snapshot.data as List<IconDetail>?;
          print("lidstgy${detail!.length}");
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detail.length,
            itemBuilder: (context, index) {
              return detail[index].category_class=='expence'?GestureDetector(
                onTap: () {
                  addExpenceController.oncategoryData("${detail[index].symbole_color}", "${detail[index].category_name}", "${detail[index].category_symbole}");
                  addExpenceController.onSelectionid(detail[index].id);
                  addExpenceController.selectionChange(false);
                  addExpenceController.selection?SizedBox():Get.to(AddNewCategory())!.then((value) {
                    setState(() {});
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      if (detail[index]
                              .category_symbole!
                              .split('.')
                              .last
                              .toString() ==
                          "svg") ...[
                        SvgPicture.asset(
                          'asset/${detail[index].category_symbole}',
                          height: 20.h,
                          width: 20.w,
                        )
                      ] else ...[
                        Icon(
                         IconData(
                            int.parse(detail[index].category_symbole!),
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Color(int.parse(detail[index].symbole_color!)),
                        )
                      ],
                      SizedBox(width: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(detail[index].category_name!,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            )),
                      ),
                    ],
                  ),
                ),
              ):SizedBox();
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
  Widget income_category_list() {
    return FutureBuilder(
      future: dbHelper.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<IconDetail>? detail = snapshot.data as List<IconDetail>?;
          print("lidstgy${detail!.length}");
          return ListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detail.length,
            itemBuilder: (context, index) {
              return detail[index].category_class=='income'?GestureDetector(
                onTap: () {
                  addExpenceController.oncategoryData("${detail[index].symbole_color}", "${detail[index].category_name}", "${detail[index].category_symbole}");
                  addExpenceController.onSelectionid(detail[index].id);
                  addExpenceController.selectionChange(false);
                  addExpenceController.selection?SizedBox():Get.to(AddNewCategory())!.then((value) {
                    setState(() {});
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    children: [
                      if (detail[index]
                          .category_symbole!
                          .split('.')
                          .last
                          .toString() ==
                          "svg") ...[
                        SvgPicture.asset(
                          'asset/${detail[index].category_symbole}',
                          height: 20.h,
                          width: 20.w,
                        )
                      ] else ...[
                        Icon(
                          IconData(
                            int.parse(detail[index].category_symbole!),
                            fontFamily: 'MaterialIcons',
                          ),
                          color: Color(int.parse(detail[index].symbole_color!)),
                        )
                      ],
                      SizedBox(width: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(detail[index].category_name!,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                            )),
                      ),
                    ],
                  ),
                ),
              ):SizedBox();
            },
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
