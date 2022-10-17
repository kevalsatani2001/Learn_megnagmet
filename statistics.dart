import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:dashboard_app/models/histry_data.dart';
import 'package:dashboard_app/utils/constant_widget.dart';
import 'package:dashboard_app/utils/income_expence_garph.dart';
import 'package:dashboard_app/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

double totalIncome = 0.0;
double totalExpence = 0.0;
double groupTotal = 0.0;

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  StatisticsScreenController statisticsScreenController =
      Get.put(StatisticsScreenController());

  var dbHelper = DataBase();
  List<HistryDetail>? detail;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder<StatisticsScreenController>(
        init: StatisticsScreenController(),
        builder: (controller) => Scaffold(
                body: SafeArea(
                    child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  getAppbarWithActionIcon(
                    () {},
                    Icon(Icons.filter_list),
                    name: 'Statistics',
                  ),
                  SizedBox(height: 30.h),
                  Container(
                      height: 250.h,
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
                      child: Column(
                        children: [
                          Graph(totalIncome, totalIncome,
                              incomeprice: totalIncome,
                              expenceprice: totalExpence),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: Color(0XFF4CB04F),
                              ),
                              Text("Income"),
                              SizedBox(width: 5.w),
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: Color(0XFFF34334),
                              ),
                              Text("Expence"),
                            ],
                          )
                        ],
                      )),
                  SizedBox(height: 40.h),
                  month_name(),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "Income",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        income_category_list(),
                        Text(
                          "Expence",
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w600),
                        ),
                        category_list(),
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }

  Widget month_name() {
    return Row(
      children: [
        getMonth(DateFormat.MMM().format(DateTime.now()),
            containercolor: Colors.blue,
            color: Colors.white,
            fontsize: 18.sp,
            fontwidth: FontWeight.w500),
        SizedBox(width: 15.w),
        getMonth(
            DateFormat.MMM()
                .format(DateTime.now().subtract(Duration(days: 30))),
            containercolor: Colors.grey.withOpacity(0.14),
            color: Colors.blue,
            fontsize: 18.sp,
            fontwidth: FontWeight.w500),
        SizedBox(width: 15.w),
        getMonth(
            DateFormat.MMM()
                .format(DateTime.now().subtract(Duration(days: 60))),
            containercolor: Colors.grey.withOpacity(0.14),
            color: Colors.blue,
            fontsize: 18.sp,
            fontwidth: FontWeight.w500),
      ],
    );
  }

  Widget category_list() {
    return FutureBuilder(
      future: dbHelper.calculateHistryGroup(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          detail = snapshot.data as List<HistryDetail>?;
          return ListView.builder(
              physics: BouncingScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              itemCount: detail!.length,
              itemBuilder: (context, index) =>
                  GetBuilder<SettingScreenController>(
                    init: SettingScreenController(),
                    builder: (controller) =>
                        GetBuilder<MainHomeScreenController>(
                      init: MainHomeScreenController(),
                      builder: (maincontroller) => GestureDetector(
                        onTap: () {
                          print("${detail![index].price}");
                          print(detail![index].category_name);
                          print(detail![index].main_id);
                          print(detail![index].category_symbole);
                          print(detail![index].icon_color);
                          print(detail![index].category_class);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: Row(
                            children: [
                              if (detail![index].category_class ==
                                  'expence') ...[
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
                                          detail![index].category_symbole!),
                                      fontFamily: 'MaterialIcons',
                                    ),
                                    size: 30,
                                    color: Color(
                                        int.parse(detail![index].icon_color!)),
                                  ),
                                ],
                                SizedBox(width: 20.w),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${detail![index].category_name!}",
                                                  style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20.0),
                                                ),
                                                Text(
                                                  "${controller.select}${detail![index].price}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 19.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            LinearPercentIndicator(
                                                barRadius: Radius.circular(22),
                                                padding: EdgeInsets.zero,
                                                width: 301.w,
                                                lineHeight: 8,
                                                percent: ((double.parse(
                                                            detail![index]
                                                                .price!) *
                                                        100) /
                                                    100000),
                                                backgroundColor:
                                                    Color(0XFFEEEEEE),
                                                progressColor: Color(int.parse(
                                                    detail![index]
                                                        .icon_color!))),
                                          ],
                                        ),
                                        FutureBuilder<double?>(
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              print(
                                                  "snaoshot is ----------------${snapshot.data}");

                                              totalExpence = snapshot.data!;
                                            }

                                            return SizedBox();
                                          },
                                          future:
                                              dbHelper.calculateIExpenceTotal(),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
        return SizedBox();
      },
    );
  }

  @override
  void initState() {
    dbHelper.calculateHistryGroup();
    super.initState();
  }
Widget income_category_list() {
  return FutureBuilder(
    future: dbHelper.calculateHistryGroup(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        detail = snapshot.data as List<HistryDetail>?;
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            primary: true,
            shrinkWrap: true,
            itemCount: detail!.length,
            itemBuilder: (context, index) =>
                GetBuilder<SettingScreenController>(
                  init: SettingScreenController(),
                  builder: (controller) =>
                      GetBuilder<MainHomeScreenController>(
                        init: MainHomeScreenController(),
                        builder: (maincontroller) => GestureDetector(
                          onTap: () {
                            print("${detail![index].price}");
                            print(detail![index].category_name);
                            print(detail![index].main_id);
                            print(detail![index].category_symbole);
                            print(detail![index].icon_color);
                            print(detail![index].category_class);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: Row(
                              children: [
                                if (detail![index].category_class ==
                                    'income') ...[
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
                                            detail![index].category_symbole!),
                                        fontFamily: 'MaterialIcons',
                                      ),
                                      size: 30,
                                      color: Color(
                                          int.parse(detail![index].icon_color!)),
                                    ),
                                  ],
                                  SizedBox(width: 20.w),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${detail![index].category_name!}",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                  ),
                                                  Text(
                                                    "${controller.select}${detail![index].price}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 19.sp,
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              LinearPercentIndicator(
                                                  barRadius: Radius.circular(22),
                                                  padding: EdgeInsets.zero,
                                                  width: 301.w,
                                                  lineHeight: 8,
                                                  percent: ((double.parse(
                                                      detail![index]
                                                          .price!) *
                                                      100) /
                                                      100000),
                                                  backgroundColor:
                                                  Color(0XFFEEEEEE),
                                                  progressColor: Color(int.parse(
                                                      detail![index]
                                                          .icon_color!))),
                                            ],
                                          ),
                                          FutureBuilder<double?>(
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                print(
                                                    "snaoshot is ----------------${snapshot.data}");

                                                totalIncome = snapshot.data!;
                                              }

                                              return SizedBox();
                                            },
                                            future:
                                            dbHelper.calculateIncomeTotal(),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                ));
      } else if (snapshot.hasError) {
        return Text("${snapshot.error}");
      } else {
        return CircularProgressIndicator();
      }
      return SizedBox();
    },
  );

}
}
//   percent: ((double.parse(detail![index].price!)*100)/10000),
