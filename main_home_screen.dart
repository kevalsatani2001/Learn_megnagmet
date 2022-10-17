import 'package:dashboard_app/controller/controller.dart';
import 'package:dashboard_app/home/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/screen_size.dart';
import 'add_screen.dart';
import 'dashboard_screen.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  int drawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return GetBuilder(init: HistoryScreenController(),builder: (controller) => Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          controller.onHistryTapChange(false);
          Get.to(const AddScreen())!.then((value) => setState((){}));
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.black,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 70.h,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            //children inside bottom appbar
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                child: Row(
                  children: [
                    drawerIndex == 0
                        ? const Icon(
                      Icons.dashboard,
                      color: Colors.blue,
                    )
                        : const Icon(Icons.dashboard),
                    SizedBox(width: 7.w),
                    Text(
                      "Dashboard",
                      style: drawerIndex == 0
                          ? const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)
                          : const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    drawerIndex = 0;
                  });
                },
              ),
              GestureDetector(
                child: Row(
                  children: [
                    drawerIndex == 1
                        ? const Icon(
                      Icons.history,
                      color: Colors.blue,
                    )
                        : Icon(Icons.history),
                    SizedBox(width: 7.w),
                    Text(
                      "History",
                      style: drawerIndex == 1
                          ? const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)
                          : const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    drawerIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(child: buildbody(drawerIndex)),
    ));
  }

  buildbody(int drawerIndex) {
    switch (drawerIndex) {
      case 0:
        return const HomeMain();
      case 1:
        return const HistoryScreen();
    }
    return const SizedBox();
  }
}
