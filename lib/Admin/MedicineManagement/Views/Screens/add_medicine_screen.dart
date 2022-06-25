import 'package:e_pets_and_care/Admin/MedicineManagement/Controller/add_medicine_screen_controller.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Controller/medicine_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddMedicineScreen extends StatelessWidget {
  static const String id = '/add_medicine_screen';
  const AddMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicineScreenController>(
        init: MedicineScreenController(),
        builder: (medicineScreenController) {
          return Scaffold(
              appBar: AppBar(
                // ignore: prefer_const_constructors
                title: Text(
                  'Add Medicine',
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
                    key: medicineScreenController.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          /* ---------------------------- Add Medicine & Active --------------------------- */
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

                          /* ---------------------------- Medicine Picture --------------------------- */
                          CircleAvatar(
                            radius: 80.r,
                            // ignore: unnecessary_cast
                            backgroundImage: medicineScreenController.image !=
                                    null
                                ? FileImage(medicineScreenController.image!)
                                : const NetworkImage("null") as ImageProvider,
                            // ignore: prefer_const_literals_to_create_immutables
                            child: Stack(children: [
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: medicineScreenController.selectFile,
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
                          /*                                Medicine Name                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Medicine Name",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          CustomeTextFormField(
                            defaultControllerText: medicineScreenController
                                .medicineNameController.text,
                            textController:
                                medicineScreenController.medicineNameController,
                            isObscure: false,
                            validate: (value) {
                              if (value != null && value.isNotEmpty) {
                                if (value.length < 3) {
                                  return "Medicine Name should be atleast 3 Character";
                                }
                              } else {
                                return 'Medicine Name cannot be empty';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                               Medicine Price                               */
                          /* -------------------------------------------------------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Medicine Price",
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
                            defaultControllerText: medicineScreenController
                                .medicinePriceController.text,
                            textController: medicineScreenController
                                .medicinePriceController,
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
                            labelText: "Medicine Quantity",
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
                            defaultControllerText: medicineScreenController
                                .medicineQuantityController.text,
                            textController: medicineScreenController
                                .medicineQuantityController,
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
                            stream: medicineScreenController.readCategory(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                medicineScreenController.categoryIten!.clear();
                                for (int i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  medicineScreenController.index =
                                      snapshot.data![i];

                                  medicineScreenController.categoryIten!.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        medicineScreenController.index.petName
                                            .toString(),
                                      ),
                                      value: medicineScreenController
                                          .index.petName
                                          .toString(),
                                    ),
                                  );
                                }
                              }
                              return DropdownButtonFormField<dynamic>(
                                items: medicineScreenController.categoryIten,
                                onChanged: (categoryValue) {
                                  medicineScreenController
                                      .updateMenuValue(categoryValue);
                                },
                                value:
                                    medicineScreenController.selectedCategory,
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
                          /* ---------------------------- Descrition of Medicine --------------------------- */
                          CustomeTextFieldLabel(
                            labelText: "Medicine Description",
                            textAlign: TextAlign.start,
                            fontSized: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          TextFormField(
                            controller: medicineScreenController
                                .medicineDescriptionController,
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
                              medicineScreenController.sendData();
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
    MedicineScreenController medicineScreenController =
        Get.put(MedicineScreenController());
    return List.generate(
        medicineScreenController.item.length,
        (final index) => DropdownMenuItem(
              child: Text(medicineScreenController.item[index]),
              value: medicineScreenController.item[index],
            ));
  }
}
