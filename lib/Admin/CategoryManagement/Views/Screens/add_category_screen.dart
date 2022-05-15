import 'package:e_pets_and_care/Admin/CategoryManagement/Controller/category_screen_controller.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<CategoryScreenController>(
          init: CategoryScreenController(),
          builder: (categoryScreenController) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Category.id);
                /* ------------------------------------ . ----------------------------------- */
                /* --------------------------------- double --------------------------------- */
                // categoryBottomSheet(
                //     onPressed: () {
                //       Get.back();
                //       categoryScreenController.sendData();
                //     },
                //     buttonText: 'Save1',
                //     heading: 'Category',
                //     isActive: categoryScreenController.isActive,
                //     pic: categoryScreenController.image != null
                //         ? FileImage(categoryScreenController.image!)
                //         : const NetworkImage("null") as ImageProvider);
                /* --------------------------------- double --------------------------------- */
              },
              child: Container(
                width: 150.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16.sp,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'Add Category',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Future<dynamic> categoryBottomSheet(
      {required String heading,
      required String buttonText,
      String? labelText,
      required VoidCallback onPressed,
      required bool isActive,
      required ImageProvider pic}) {
    return Get.bottomSheet(
      GetBuilder<CategoryScreenController>(
          init: CategoryScreenController(),
          builder: (categoryScreenController) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                height: 600.h,
                child: Form(
                  key: categoryScreenController.formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        /* ---------------------------- Category & Active --------------------------- */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              heading,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            FlutterSwitch(
                              width: 100.w,
                              height: 35.h,
                              valueFontSize: 25.0,
                              toggleSize: 45.0,
                              value: isActive,
                              onToggle: (val) {
                                categoryScreenController.updateActive(val);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        /* ---------------------------- Categeory Picture --------------------------- */
                        CircleAvatar(
                          radius: 100.r,
                          backgroundImage: pic,
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Stack(children: [
                            // ignore: prefer_const_constructors
                            GestureDetector(
                              onTap: categoryScreenController.selectFile,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 28.r,
                                  backgroundColor: Colors.orange,
                                  child: const Icon(
                                    CupertinoIcons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        /* -------------------------- Title / Category Name ------------------------- */
                        SizedBox(
                          height: 60.h,
                          child: Column(
                            children: [
                              CustomeTextFieldLabel(
                                labelText: "Title",
                                textAlign: TextAlign.start,
                                fontSized: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: 6.h,
                              ),
                              CustomeTextFormField(
                                labelText: labelText,
                                defaultControllerText: '',
                                textController:
                                    categoryScreenController.titleController,
                                isObscure: false,
                                validate: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length < 3) {
                                      return "Name should be atleast 3 Character";
                                    }
                                  } else {
                                    return 'Name cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        /* ------------------------------- Save Button ------------------------------ */
                        CustomeButton(
                          buttonColor: Colors.orange,
                          fontColor: Colors.white,
                          buttonText: buttonText,
                          horPadding: 50,
                          onPressed: onPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
