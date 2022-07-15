import 'package:e_pets_and_care/Admin/PetSupplierManagement/Controller/supplier_controller.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({
    Key? key,
    required this.headingText,
    required this.buttonText,
    this.bgImgae,
    required this.defaultControllerText,
    required this.textController,
    required this.onPress,
    required this.defaultCompanyControllerText,
    required this.textCompanyController,
  }) : super(key: key);
  final String headingText;
  final String buttonText;
  final ImageProvider? bgImgae;
  final String defaultControllerText;
  final TextEditingController textController;
  final String defaultCompanyControllerText;
  final TextEditingController textCompanyController;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierController>(
        init: SupplierController(),
        builder: (supplierController) {
          return Scaffold(
            appBar: AppBar(
              // ignore: prefer_const_constructors
              title: Text(
                headingText,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                height: 812.h,
                child: Form(
                  key: supplierController.formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),

                        /* ---------------------------- Categeory Picture --------------------------- */
                        CircleAvatar(
                          radius: 200.r,
                          backgroundImage: bgImgae,
                          // ignore: prefer_const_literals_to_create_immutables
                          child: Stack(children: [
                            // ignore: prefer_const_constructors
                            GestureDetector(
                              onTap: supplierController.selectFile,
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
                        /* -------------------------------------------------------------------------- */
                        /*                                Supplier Name                               */
                        /* -------------------------------------------------------------------------- */
                        CustomeTextFieldLabel(
                          labelText: "Supplier Name",
                          textAlign: TextAlign.start,
                          fontSized: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomeTextFormField(
                          defaultControllerText: defaultControllerText,
                          textController: textController,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                            Supplier Company Name                           */
                        /* -------------------------------------------------------------------------- */
                        CustomeTextFieldLabel(
                          labelText: "Supplier Company Name",
                          textAlign: TextAlign.start,
                          fontSized: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomeTextFormField(
                          defaultControllerText: defaultCompanyControllerText,
                          textController: textCompanyController,
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
                        SizedBox(
                          height: 20.h,
                        ),
                        /* ------------------------------- Save Button ------------------------------ */
                        CustomeButton(
                          buttonColor: Colors.orange,
                          fontColor: Colors.white,
                          buttonText: buttonText,
                          horPadding: 50,
                          onPressed: onPress,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
