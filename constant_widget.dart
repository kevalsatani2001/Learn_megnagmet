import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/helpers/icons_helper.dart';
import 'package:dashboard_app/home/add_screen.dart';
import 'package:dashboard_app/models/histry_data.dart';
import 'package:dashboard_app/models/icon_data.dart';
import 'package:dashboard_app/models/income_data.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


Widget getAppbar(String title, String buttontext, VoidCallback function,
    VoidCallback buttonfunction,
    {double? textsize,
    double? height,
    double? width,
    Color? textColor,
    Color? buttoncolor,
    double? buttontextSize}) {
  return Row(
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
              SizedBox(
                width: 35.w,
              ),
              GestureDetector(
                onTap: () {
                  function();
                },
                child: FDottedLine(
                  corner: FDottedLineCorner.all(15.h),
                  color: Colors.blue,
                  height: 200.0.h,
                  width: 100.w,
                  strokeWidth: 1.5.w,
                  dottedLength: 7.0,
                  space: 5.0,
                  child: SizedBox(
                    height: height ?? 40.h,
                    width: width ?? 150.w,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: textsize ?? 22.sp,
                            fontWeight: FontWeight.w600,
                            color: textColor ?? Color(0XFF2296F3)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      Column(
        children: [
          GestureDetector(
            onTap: () {
              buttonfunction();
            },
            child: Text(
              buttontext,
              style: TextStyle(
                  fontSize: buttontextSize ?? 20.sp,
                  fontWeight: FontWeight.w600,
                  color: buttoncolor ?? Color(0XFF2296F3)),
            ),
          ),
        ],
      )
    ],
  );
}

Widget getMonth(String monthname,{FontWeight? fontwidth,Color? color,double? fontsize,String? fontfamily,Color? containercolor,Function? function}){
  return  GestureDetector(
    child: Container(
      height: 50.h,
      width: 75.w,
      child: Center(child: Text(monthname,style: TextStyle(fontWeight: fontwidth,color: color,fontFamily: fontfamily,fontSize: fontsize),)),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.h),
          color: containercolor,),
    ),
    onTap: (){
      function;
    },
  );
}

Widget getHistryDetail(IconData? icon,Color? color,String? title,String? date,String? time,String? price){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
         Icon(icon,size: 30,color:color),
          SizedBox(
              width: 10.w
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w700),),
              Row(
                children: [
                  Text(date!,style: TextStyle(color: Color(0XFF747474),fontSize: 15.sp,fontWeight: FontWeight.w600),),
                  SizedBox(width: 10),
                  Text(time!,style: TextStyle(color: Color(0XFF747474),fontSize: 15.sp,fontWeight: FontWeight.w600))
                ],
              ),
            ],
          )
        ],
      ),
      Text("\$${price}",style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700))
    ],
  );
}

Widget getHistryFilterDialogueButton(Function function,String buttontext){
  return  Expanded(child: GestureDetector(
    onTap:(){function;},
    child: Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          boxShadow: [
            BoxShadow(
                color: const Color(0XFFDCDCDC),
                offset: const Offset(0, 1.5),
                //blurRadius: 16.h
        ),
          ],
          color: Colors.white),
      child: Center(child: Text(buttontext,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black))),
    ),
  ));

}
Widget getAppbarWithActionIcon(Function function,Icon? actionicon,{required String name}){
  return  Row(
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
              SizedBox(
                  width: 35.w
              ),
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
                      name,
                      style: TextStyle(
                          fontSize:  22.sp,
                          fontWeight: FontWeight.w600,
                          color:  Color(0XFF2296F3)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      Column(
        children: [
          GestureDetector(
              onTap: () {
function();
              },
              child: actionicon??Icon(Icons.filter_list)
          ),
        ],
      )
    ],
  );
}







