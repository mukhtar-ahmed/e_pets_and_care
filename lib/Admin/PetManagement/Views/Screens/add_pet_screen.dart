import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Controller/add_pet_screen_controller.dart';
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
    return GetBuilder<AddPetScreenCotroller>(
        init: AddPetScreenCotroller(),
        builder: (addPetScreenCotroller) {
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
                    key: addPetScreenCotroller.formKey,
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
                              Text(
                                addPetScreenCotroller.isActive
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
                                value: addPetScreenCotroller.isActive,
                                onToggle: (val) {
                                  addPetScreenCotroller.updateActive(val);
                                },
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
                            backgroundImage: addPetScreenCotroller.image != null
                                ? FileImage(addPetScreenCotroller.image!)
                                : const NetworkImage("null") as ImageProvider,
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Stack(children: [
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: addPetScreenCotroller.selectFile,
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
                                addPetScreenCotroller.petNameController.text,
                            textController:
                                addPetScreenCotroller.petNameController,
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
                                addPetScreenCotroller.petPriceController.text,
                            textController:
                                addPetScreenCotroller.petPriceController,
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
                            stream: addPetScreenCotroller.readCategory(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                addPetScreenCotroller.categoryIten!.clear();
                                for (int i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  addPetScreenCotroller.index =
                                      snapshot.data![i];

                                  addPetScreenCotroller.categoryIten!.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        addPetScreenCotroller.index.petName
                                            .toString(),
                                      ),
                                      value: addPetScreenCotroller.index.petName
                                          .toString(),
                                    ),
                                  );
                                }
                              }
                              return DropdownButtonFormField<dynamic>(
                                items: addPetScreenCotroller.categoryIten,
                                onChanged: (categoryValue) {
                                  Get.snackbar('Error', categoryValue);
                                  addPetScreenCotroller
                                      .updateMenuValue(categoryValue);
                                },
                                value: addPetScreenCotroller.selectedCategory,
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
                                addPetScreenCotroller.petDescriptionController,
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
                              addPetScreenCotroller.sendData();
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
    AddPetScreenCotroller addPetScreenCotroller =
        Get.put(AddPetScreenCotroller());
    return List.generate(
        addPetScreenCotroller.item.length,
        (final index) => DropdownMenuItem(
              child: Text(addPetScreenCotroller.item[index]),
              value: addPetScreenCotroller.item[index],
            ));
  }
}
