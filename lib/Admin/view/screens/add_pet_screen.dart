import 'package:e_pets_and_care/Admin/Controller/add_pet_screen_controller.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AddPetScreen extends StatelessWidget {
  static const String id = '/add_pet_screen';
  AddPetScreen({Key? key}) : super(key: key);

  AddPetScreenController addPetScreenController =
      Get.put(AddPetScreenController());
  @override
  Widget build(BuildContext context) {
    final fileName = addPetScreenController.file != null
        ? basename(addPetScreenController.file!.path)
        : 'No File Selected';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
            child: GestureDetector(
              onTap: addPetScreenController.uploadFile,
              child: Text(
                'Save',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: const Text('Add Pet details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SizedBox(
            width: 335.w,
            child: SingleChildScrollView(
              child: Form(
                key: addPetScreenController.petFormKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 32.h,
                    ),
                    /* ----------------------------- Profile Picture ---------------------------- */
                    CircleAvatar(
                      radius: 70.r,
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Stack(children: [
                        // ignore: prefer_const_constructors
                        GestureDetector(
                          onTap: addPetScreenController.selectFile,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              radius: 18.r,
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
                    Text(fileName),
                    SizedBox(
                      height: 32.h,
                    ),
                    Column(
                      children: [
                        CustomeTextFieldLabel(
                          labelText: 'General',
                          textAlign: TextAlign.start,
                          fontSized: 18.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                        CustomeTextFieldLabel(
                          labelText: 'Information',
                          textAlign: TextAlign.start,
                          fontSized: 18.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                              Pet  Name  Field                              */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          CustomeTextFieldLabel(
                            labelText: "Pet Name",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            defaultControllerText: '',
                            textController:
                                addPetScreenController.petNameController,
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
                      height: 16.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets Category                               */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      height: 80.h,
                      child: Column(
                        children: [
                          CustomeTextFieldLabel(
                            labelText: "Select Pet Category",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          DropdownButtonFormField(
                            hint: const Text('Choose species of your pet'),
                            decoration: dropdowndecoration(),
                            value: addPetScreenController.petsCategory,
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            onChanged: (String? value1) {
                              addPetScreenController
                                  .onChangedPetCatagory(value1);
                            },
                            items: addPetScreenController.petsName
                                .map((consItem) => DropdownMenuItem(
                                    value: consItem, child: Text(consItem)))
                                .toList(),
                            icon: const Icon(FontAwesomeIcons.angleDown),
                            iconSize: 22,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                    Price                                   */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          CustomeTextFieldLabel(
                            labelText: "Product Price",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            defaultControllerText: '',
                            textController:
                                addPetScreenController.petPriceController,
                            isObscure: false,
                            validate: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value is int) {
                                  return "Incorrect Price";
                                }
                              } else {
                                return 'Price cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                  Pet Color                                 */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      height: 60.h,
                      child: Column(
                        children: [
                          CustomeTextFieldLabel(
                            labelText: "Pet Color",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            defaultControllerText: '',
                            textController:
                                addPetScreenController.petColorController,
                            isObscure: false,
                            validate: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 3) {
                                  return "Color should be atleast 3 Character";
                                }
                              } else {
                                return 'Color cannot be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                 Description                                */
                    /* -------------------------------------------------------------------------- */
                    CustomeTextFieldLabel(
                      labelText: 'Description',
                      textAlign: TextAlign.start,
                      fontSized: 14.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                    TextFormField(
                      controller:
                          addPetScreenController.petDescriptionController,
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          if (value.length < 30) {
                            return "Description should be atleast 30 Character";
                          }
                        } else {
                          return 'Description cannot be empty';
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    CustomeButton(
                        buttonColor: Colors.orange,
                        fontColor: Colors.white,
                        buttonText: 'Save',
                        horPadding: 5,
                        onPressed: addPetScreenController.addPetDetails),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration dropdowndecoration() {
    return const InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10, 16, 15, 16),
      errorStyle: TextStyle(),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Color(0xFFD5D5D5),
          )),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Color(0xFFD5D5D5),
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          borderSide: BorderSide(
            color: Color(0xFFD5D5D5),
          )),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFD5D5D5),
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      fillColor: Colors.white,
      filled: true,
    );
  }
}
