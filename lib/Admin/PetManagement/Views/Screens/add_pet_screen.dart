import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Controller/add_pet_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Controller/pet_screen_controller.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddPetScreen extends StatelessWidget {
  static const String id = '/add_pet_screen';
  const AddPetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetScreenCotroller>(
        init: PetScreenCotroller(),
        builder: (petScreenCotroller) {
          return Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_constructors
                title: Text(
                  'Add Pet',
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
                    key: petScreenCotroller.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          /* ---------------------------- Add pet & Active --------------------------- */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          /* ---------------------------- Pet Picture --------------------------- */
                          CircleAvatar(
                            radius: 80.r,
                            // ignore: unnecessary_cast
                            backgroundImage: petScreenCotroller.image != null
                                ? FileImage(petScreenCotroller.image!)
                                : const NetworkImage("null") as ImageProvider,
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Stack(children: [
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: petScreenCotroller.selectFile,
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
                          /*                                Pet Name                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Pet Name",
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
                                petScreenCotroller.petNameController.text,
                            textController:
                                petScreenCotroller.petNameController,
                            isObscure: false,
                            validate: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 3) {
                                  return "Pet Name should be atleast 3 Character";
                                }
                              } else {
                                return 'Pet Name cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                               Pet Price                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Pet Price",
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
                            defaultControllerText:
                                petScreenCotroller.petPriceController.text,
                            textController:
                                petScreenCotroller.petPriceController,
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
                          /*                               Total Quantity                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Pet Quantity",
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
                            defaultControllerText:
                                petScreenCotroller.petQuantityController.text,
                            textController:
                                petScreenCotroller.petQuantityController,
                            isObscure: false,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Quantity';
                              } else if (int.parse(value) < 0) {
                                return 'Quantity must be Greater than 0';
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
                            stream: petScreenCotroller.readCategory(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                petScreenCotroller.categoryIten!.clear();
                                for (int i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  petScreenCotroller.index = snapshot.data![i];

                                  petScreenCotroller.categoryIten!.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        petScreenCotroller.index.petName
                                            .toString(),
                                      ),
                                      value: petScreenCotroller.index.petName
                                          .toString(),
                                    ),
                                  );
                                }
                              }
                              return DropdownButtonFormField<dynamic>(
                                items: petScreenCotroller.categoryIten,
                                onChanged: (categoryValue) {
                                  Get.snackbar('Error', categoryValue);
                                  petScreenCotroller
                                      .updateMenuValue(categoryValue);
                                },
                                value: petScreenCotroller.selectedCategory,
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
                          /* ---------------------------- Descrition of Pet --------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Pet Description",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          TextFormField(
                            controller:
                                petScreenCotroller.petDescriptionController,
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
                              petScreenCotroller.sendData();
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

  // List<String> _categories = [];
  List<DropdownMenuItem<String>> getDropDownCategories() {
    PetScreenCotroller petScreenCotroller = Get.put(PetScreenCotroller());
    return List.generate(
        petScreenCotroller.item.length,
        (final index) => DropdownMenuItem(
              child: Text(petScreenCotroller.item[index]),
              value: petScreenCotroller.item[index],
            ));
  }
}
