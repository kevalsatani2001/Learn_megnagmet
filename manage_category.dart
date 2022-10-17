import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:dashboard_app/models/icon_data.dart';
import 'package:dashboard_app/models/income_data.dart';
import 'package:dashboard_app/utils/constant_widget.dart';
import 'package:dashboard_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ManageCategory extends StatefulWidget {
  const ManageCategory({Key? key}) : super(key: key);

  @override
  State<ManageCategory> createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  ManageCategoryScreenController manageCategoryScreenController =
      Get.put(ManageCategoryScreenController());
  var dbHelper = DataBase();
  List<IconDetail>? detail;
  List<IncomeDetail>? incomedetail;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        body: SafeArea(
      child: GetBuilder(
          init: AddScreenController(),
          builder: (manageCategoryScreenController) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    getAppbar("Manage Category", "Delete", () {}, () {
                      dbHelper.deleteData(
                          detail![manageCategoryScreenController.category!].id);
                      dbHelper.getData().then((value) {
                        setState(() {});
                      });
                    }, width: 185),
                    SizedBox(height: 20.h),
                    Expanded(
                        child: ListView(children: [
                      SizedBox(height: 20.h),
                      category_list(),
                    ])),
                  ],
                ),
              )),
    ));
  }

  Widget category_list() {
    return FutureBuilder(
      future: dbHelper.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          detail = snapshot.data as List<IconDetail>?;
          print("lidstgy${detail!.length}");
          return GridView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: detail!.length,
            itemBuilder: (context, index) {
              return GetBuilder<AddScreenController>(
                init: AddScreenController(),
                builder: (manageCategoryScreenController) => GestureDetector(
                  onTap: () {
                    manageCategoryScreenController
                        .onchange_category_position(index,detail![index].id);
                  },
                  child: Container(
                      decoration: manageCategoryScreenController.category ==
                              index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              border: Border.all(
                                color: Color(0XFF67B7F6),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFD5D5D5).withOpacity(0.10),
                                    offset: const Offset(-4, 5),
                                    blurRadius: 16.h),
                              ],
                              color: Colors.white)
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0XFFD5D5D5).withOpacity(0.10),
                                    offset: const Offset(-4, 5),
                                    blurRadius: 16.h),
                              ],
                              color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  int.parse(
                                    detail![index].category_symbole!,
                                  ),
                                  fontFamily: 'MaterialIcons'),
                              color: Color(
                                  int.parse(detail![index].symbole_color!)),
                            )
                          ],
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(detail![index].category_name!,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                )),
                          ),
                        ],
                      )),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 100,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10.h),
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
