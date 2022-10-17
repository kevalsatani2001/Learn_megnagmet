import 'package:dashboard_app/home/manage_category.dart';
import 'package:dashboard_app/home/setting_screen.dart';
import 'package:dashboard_app/models/income_data.dart';
import 'package:dashboard_app/total_expence/statistics.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:string_2_icon/string_2_icon.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../controller/controller.dart';
import '../helpers/icons_helper.dart';
import '../models/icon_data.dart';
import '../utils/screen_size.dart';
import 'add_screen.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({Key? key}) : super(key: key);

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  MainHomeScreenController mainHomeScreenController =
      Get.put(MainHomeScreenController());
  double total = 0;
  var dbHelper = DataBase();
  final controller = IconController();
  List<IconDetail>? detail;
  List<IncomeDetail>? incomedetail;

  String? icon1st;

  void initState() {
    super.initState();
    dbHelper.getData().then((value) {
      setState(() {});
    });
    check();
    if (iconPackModes != null)
      controller.addAll(IconManager.getSelectedPack(IconPack.lineAwesomeIcons));
  }

  check() async {
    var dbHelper = DataBase();

    double? i = await dbHelper.calculateTotal();
    print("i ========================$i");
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder(
            init: MainHomeScreenController(),
            builder: (MainHomeScreenController) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  SizedBox(height: 45.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FDottedLine(
                          corner: FDottedLineCorner.all(15.h),
                          color: Colors.blue,
                          height: 200.0.h,
                          width: 100.w,
                          strokeWidth: 1.5.w,
                          dottedLength: 7.0,
                          space: 5.0,
                          child: SizedBox(
                            height: 40.h,
                            width: 140.w,
                            child: Center(
                              child: Text(
                                "Dashboard",
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(settingScreen());
                            },
                            child: Icon(Icons.settings)),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView(
                        shrinkWrap: true,
                        primary: false,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: 20.h),
                          hello_desk(),
                          SizedBox(height: 20.h),
                          Container(
                            width: double.infinity,
                            height: 170.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.h),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0XFFDCDCDC),
                                    offset: const Offset(0, 1.5),
                                  ),
                                ],
                                color: Colors.white),
                            child: today_expence_meter(),
                          ),
                          SizedBox(height: 40.h),
                          Text(
                            "Total Expense",
                            style: TextStyle(
                                fontSize: 23.sp, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 20.h),
                          total_expence_graph(),
                          SizedBox(height: 35.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Quick Add",
                                style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(ManageCategory())!.then((value) {
                                    setState(() {});
                                  });
                                },
                                child: Text(
                                  "Manage Category",
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0XFF289AF3)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          category_list(),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget hello_desk() {
    return RichText(
        text: TextSpan(
            text: 'Hello,',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
            ),
            children: [
          TextSpan(
            text: ' desk',
            style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.w300),
          )
        ]));
  }

  Widget today_expence_meter() {
    return GetBuilder(
      init: SettingScreenController(),
      builder: (setcontroller) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(width: 10.w),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TODAY'S EXPENSE",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),

                FutureBuilder<double?>(
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("snaoshot is ----------------${snapshot.data}");


                        total = snapshot.data!;
                        var m=total/12;
                       // mainHomeScreenController.onTotal(total);

                      }

                      return Text("${setcontroller.select}$total",
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.w500));
                    },
                    future: dbHelper.calculateTotal())
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: SizedBox(
                  height: 200.h,
                  width: 200.w,
                  child: SfRadialGauge(
                      enableLoadingAnimation: true,
                      axes: <RadialAxis>[
                        RadialAxis(
                            radiusFactor: 1.4.h,
                            minimum: 0,
                            maximum: 100,
                            endAngle: 360,
                            startAngle: 180,
                            ranges: <GaugeRange>[
                              GaugeRange(
                                  startValue: 0,
                                  endValue: 33.33,
                                  color: Color(0XFFA2EC50),
                                  endWidth: 40.w,
                                  startWidth: 40.w),
                              GaugeRange(
                                  startValue: 33.33,
                                  endValue: 66.66,
                                  color: Color(0XFFFFC833),
                                  endWidth: 40.w,
                                  startWidth: 40.w),
                              GaugeRange(
                                  startValue: 66.66,
                                  endValue: 100,
                                  color: Color(0XFFFF6733),
                                  endWidth: 40.w,
                                  startWidth: 40.w)
                            ],
                            pointers: <GaugePointer>[
                              NeedlePointer(
                                value: ((100*total)/10000),
                                needleStartWidth: 1.1.w,
                                needleEndWidth: 4.w,
                                needleLength: 0.7.h,
                              )
                            ],
                            showLabels: false,
                            annotations: [
                              GaugeAnnotation(
                                  widget: Padding(
                                    padding: EdgeInsets.only(bottom: 30.h),
                                    child: Text('Monthly Expense Meter',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  angle: 90,
                                  positionFactor: 0.5)
                            ])
                      ]),
                ),
              ),
            )
          ]),
    );
  }

  Widget total_expence_graph() {
    return GetBuilder(
      init: SettingScreenController(),
      builder: (setcontroller) => GestureDetector(onTap:(){
Get.to(Statistics());
      },child: Container(
        height: 300.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.h),
            boxShadow: [
              BoxShadow(
                color: const Color(0XFFDCDCDC),
                offset: const Offset(0, 1.5),
              ),
            ],
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 55.h, left: 20.w),
                  child: Container(
                    height: 175.h,
                    width: 175.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0XFFBDCDE0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 76.h, left: 40.w),
                  child: Container(
                    height: 135.h,
                    width: 135.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFF7BB14),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 108.h, left: 73.w),
                  child: Container(
                    height: 70.h,
                    width: 70.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFBDCDE0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 128.h, left: 82.w),
                  child: Column(
                    children: [
                      Text(
                        "Monthly",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.5.sp),
                      ),
                      Text(
                        "${setcontroller.select}${(total/30).toStringAsFixed(0)}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18.sp),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(width: 15.w),
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Row(
                children: [
                  Icon(Icons.circle_rounded,
                      color: Color(0XFFFDBE0D), size: 13.h),
                  SizedBox(width: 5.w),
                  Text(
                    "Shopping",
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0XFF3B3B3B)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),)

    );
  }

  Widget category_list() {
    return FutureBuilder(
      future: dbHelper.getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          detail = snapshot.data as List<IconDetail>?;

          return GridView.count(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: detail!.map((e) {
                print(e.category_symbole);

                return GestureDetector(
                  onTap: () {
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.h),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0XFFDCDCDC),
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (e.category_symbole!.split('.').last.toString() ==
                              "svg") ...[
                            SvgPicture.asset(
                              'asset/${e.category_symbole}',
                              height: 20.h,
                              width: 20.w,
                            )
                          ] else ...[
                            Icon(
                              IconData(
                                int.parse(e.category_symbole!),
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Color(int.parse(e.symbole_color!)),
                            )
                          ],
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(e.category_name!,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                )),
                          ),
                        ],
                      )),
                );
              }).toList());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  List<IconPack> iconPackModes = const <IconPack>[IconPack.lineAwesomeIcons];
}
