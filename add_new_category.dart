import 'package:dashboard_app/models/icon_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/IconPicker/icons.dart';
import 'package:flutter_iconpicker/controllers/icon_controller.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../helpers/icons_helper.dart';
import '../utils/constant_widget.dart';
import '../utils/screen_size.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  List<IconDetail>? detail;
  AddNewCategoryController addNewCategoryController =
      Get.put(AddNewCategoryController());
  TextEditingController categoryNameController = TextEditingController();
  var dbHelper = DataBase();
  final controller = IconController();
  List<Color> defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  List<IconPack> iconPackModes = const <IconPack>[IconPack.material];
  void initState() {
    super.initState();
    if (iconPackModes!= null)
      controller.addAll(IconManager.getSelectedPack(IconPack.material));
  }

  @override
  Widget build(BuildContext context) {
    initializeScreenSize(context);
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: GetBuilder<AddNewCategoryController>(
          init: AddNewCategoryController(),
          builder: (addcontroller) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GetBuilder(
                    init: AddExpenceController(),
                    builder:(setcontroller) =>Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          GetBuilder<AddScreenController>(
                            init: AddScreenController(),
                            builder: (addScreencontroller) =>
                                getAppbar("New Category", "Save", () {}, () {
                                   if(setcontroller.selection==true) {
                                     if(addScreencontroller.expence_button==true){
                                       addNewCategoryController.onIconStringSplite(
                                           addNewCategoryController.icon
                                               .toString());
                                       addNewCategoryController
                                           .onColorStringSplite(
                                           addNewCategoryController.mycolor
                                               .toString());

                                       dbHelper.insertData(
                                           categoryNameController.text,
                                           "0x${addNewCategoryController.icon2nd}",
                                           "${addNewCategoryController.color2nd}","expence")
                                           .then((value) {
                                         categoryNameController.clear();
                                         Get.back();
                                       });
                                     }
                                     else{
                                       addNewCategoryController.onIconStringSplite(
                                           addNewCategoryController.icon
                                               .toString());
                                       addNewCategoryController
                                           .onColorStringSplite(
                                           addNewCategoryController.mycolor
                                               .toString());

                                       dbHelper.insertData(
                                           categoryNameController.text,
                                           "0x${addNewCategoryController.icon2nd}",
                                           "${addNewCategoryController.color2nd}","income")
                                           .then((value) {
                                         categoryNameController.clear();
                                         Get.back();
                                       });
                                     }
                                   }
                                  // else if(){}
                                   else{
                                     if(addScreencontroller.expence_button==true){ addNewCategoryController.onIconStringSplite(
                                         addNewCategoryController.icon
                                             .toString());
                                     addNewCategoryController
                                         .onColorStringSplite(
                                         addNewCategoryController.mycolor
                                             .toString());
                                     if(addNewCategoryController.icon2nd != "null"&& categoryNameController.text.isNotEmpty){
                                       dbHelper.updateData(
                                           categoryNameController.text,
                                           "0x${addNewCategoryController.icon2nd}",
                                           "${addNewCategoryController.color2nd}",
                                           setcontroller.selectionid!).then((value) {
                                         categoryNameController.clear();
                                         Get.back();
                                       });
                                     }
                                     else{
                                       Get.snackbar("ERROR", 'Please enter the Category name and Symbol both compulsory', snackPosition: SnackPosition.BOTTOM,  borderRadius: 20  ,margin: EdgeInsets.all(15),duration: Duration(seconds: 2),backgroundColor: Colors.red,colorText: Colors.white,dismissDirection: DismissDirection.horizontal);
                                     }}
                                     else{
                                       addNewCategoryController.onIconStringSplite(
                                           addNewCategoryController.icon
                                               .toString());
                                       addNewCategoryController
                                           .onColorStringSplite(
                                           addNewCategoryController.mycolor
                                               .toString());
                                       if(addNewCategoryController.icon2nd != "null"&& categoryNameController.text.isNotEmpty){
                                         dbHelper.updateData(
                                             categoryNameController.text,
                                             "0x${addNewCategoryController.icon2nd}",
                                             "${addNewCategoryController.color2nd}",
                                             setcontroller.selectionid!).then((value) {
                                           categoryNameController.clear();
                                           Get.back();
                                         });
                                       }
                                       else{
                                         Get.snackbar("ERROR", 'Please enter the Category name and Symbol both compulsory', snackPosition: SnackPosition.BOTTOM,  borderRadius: 20  ,margin: EdgeInsets.all(15),duration: Duration(seconds: 2),backgroundColor: Colors.red,colorText: Colors.white,dismissDirection: DismissDirection.horizontal);
                                       }
                                     }

                                   }

                                }),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.h),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0XFFE6E6E6).withOpacity(0.14),
                                      offset: const Offset(-4, 5),
                                      blurRadius: 16.h),
                                ],
                                color: Colors.white),
                            child: setcontroller.selection?TextFormField(
                              controller: categoryNameController,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF666666)),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(top: 100.h, bottom: 40.h),
                                  prefixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.w, right: 20.w),
                                    child: Icon(
                                      addNewCategoryController.icon,
                                      color: addcontroller.mycolor,
                                      size: 40.h,
                                    ),
                                  )),
                            ):TextFormField(
                             controller: categoryNameController,
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0XFF666666)),
                              decoration: InputDecoration(
                                hintText: 'Category name',
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(top: 100.h, bottom: 40.h),
                                  prefixIcon: Padding(
                                    padding:
                                    EdgeInsets.only(left: 20.w, right: 20.w),
                                    child: "${addNewCategoryController.icon}".split('.').last.toString()=="svg"? SvgPicture.asset('asset/${
                                       addNewCategoryController.icon}',
                                      height: 20.h,
                                      width: 20.w,
                                    ):Icon(
                                      addNewCategoryController.icon,
                                      color: addcontroller.mycolor,
                                      size: 40.h,
                                    )
                                  )),
                            )
                          ),
                          SizedBox(height: 20.h),
                          Text("Icon",
                              style: TextStyle(
                                  fontSize: 25.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 250.h,
                            child: GridView.builder(
                                primary: true,
                                shrinkWrap: false,
                                itemCount: controller.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 25,
                                  maxCrossAxisExtent: 30.h,
                                ),
                                itemBuilder: (context, index) {
                                  var item = controller.entries.elementAt(index);

                                  return GestureDetector(
                                    onTap: () {
                                      addNewCategoryController
                                          .iconChange(item.value);
                                    },
                                    child: Icon(
                                      item.value,
                                      size: 40.h,
                                      color: Colors.black,
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(height: 20.h),
                          Text("Color",
                              style: TextStyle(
                                  fontSize: 25.sp, fontWeight: FontWeight.w700)),
                          SizedBox(height: 10.h),
                          SizedBox(
                            height: 200.h,
                            child: GridView.count(
                              crossAxisCount: 6,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              children: [
                                for (Color color in defaultColors)
                                  GestureDetector(
                                    onTap: () {
                                      addNewCategoryController
                                          .onChange(color);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 7.h, vertical: 7.h),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color,
                                        boxShadow: [
                                          BoxShadow(
                                              color: color.withOpacity(0.8),
                                              offset: const Offset(1, 2),
                                              blurRadius: 5)
                                        ],
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ]),
                  )),
            ),
          ),
        ));
  }


  @override
  void dispose() {
    categoryNameController.dispose();
    addNewCategoryController.dispose();
    super.dispose();
  }
}
