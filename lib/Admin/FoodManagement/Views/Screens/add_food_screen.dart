import 'package:e_pets_and_care/Admin/FoodManagement/Controller/add_food_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddFoodScreen extends StatelessWidget {
  static const String id = '/add_food_screen';
  const AddFoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFoodScreenController>(
        init: AddFoodScreenController(),
        builder: (addFoodScreenController) {
          return Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_constructors
                title: Text(
                  'Add Food',
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
                    key: addFoodScreenController.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          /* ---------------------------- Add Food & Active --------------------------- */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              Text(
                                addFoodScreenController.isActive
                                    ? 'Active'
                                    : 'Inactive',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              FlutterSwitch(
                                width: 100.w,
                                height: 35.h,
                                valueFontSize: 25.0,
                                toggleSize: 45.0,
                                value: addFoodScreenController.isActive,
                                onToggle: (val) {
                                  addFoodScreenController.updateActive(val);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          /* ---------------------------- Food Picture --------------------------- */
                          CircleAvatar(
                            radius: 80.r,
                            // ignore: unnecessary_cast
                            backgroundImage: addFoodScreenController.image !=
                                    null
                                ? FileImage(addFoodScreenController.image!)
                                : const NetworkImage("null") as ImageProvider,
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Stack(children: [
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: addFoodScreenController.selectFile,
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
                          /*                                Food Name                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Food Name",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            defaultControllerText:
                                addFoodScreenController.foodNameController.text,
                            textController:
                                addFoodScreenController.foodNameController,
                            isObscure: false,
                            validate: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 3) {
                                  return "Food Name should be atleast 3 Character";
                                }
                              } else {
                                return 'Food Name cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                               Food Price                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Food Price",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            keyboardType: TextInputType.number,
                            defaultControllerText: addFoodScreenController
                                .foodPriceController.text,
                            textController:
                                addFoodScreenController.foodPriceController,
                            isObscure: false,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Price';
                              } else if (int.parse(value) < 0) {
                                return 'Price must be Greater than 0';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                           Pet Category Drop Down                           */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Select Pet",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          StreamBuilder<List<PetCategoryScreenModel>>(
                            stream: addFoodScreenController.readCategory(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                addFoodScreenController.categoryIten!.clear();
                                for (int i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  addFoodScreenController.index =
                                      snapshot.data![i];

                                  addFoodScreenController.categoryIten!.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        addFoodScreenController.index.petName
                                            .toString(),
                                      ),
                                      value: addFoodScreenController
                                          .index.petName
                                          .toString(),
                                    ),
                                  );
                                }
                              }
                              return DropdownButtonFormField<dynamic>(
                                items: addFoodScreenController.categoryIten,
                                onChanged: (categoryValue) {
                                  addFoodScreenController
                                      .updateMenuValue(categoryValue);
                                },
                                value: addFoodScreenController.selectedCategory,
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                isExpanded: true,
                                hint: const Text('Select Pet Category'),
                              );
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          /* ---------------------------- Descrition of Food --------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Food Description",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          TextFormField(
                            controller: addFoodScreenController
                                .foodDescriptionController,
                            maxLines: 3,
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 15) {
                                  return "Description should be atleast 15 Character";
                                }
                              } else {
                                return 'Description cannot be empty';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          /* ------------------------------- Save Button ------------------------------ */
                          CustomeButton(
                            buttonColor: Colors.orange,
                            fontColor: Colors.white,
                            buttonText: 'Save',
                            horPadding: 50,
                            onPressed: () {
                              addFoodScreenController.sendData();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
