import 'package:e_pets_and_care/Admin/PetCategoryManagement/Controller/pet_category_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/add_pet_category_screen.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class PetCategoryScreen extends StatelessWidget {
  static const String id = '/pet_category_screen';
  const PetCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetCategoryScreenController>(
        init: PetCategoryScreenController(),
        builder: (petScreenController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kWhiteColor,
              /* --------------------------- Pet Management Text -------------------------- */
              title: Text(
                'Pets Category',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
              ),
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                /* ------------------------------ Add Category ------------------------------ */
                const AddPetCategoryScreen(),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 360.w,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      /* -------------------------------------------------------------------------- */
                      /*                            Pet Display Container                           */
                      /* -------------------------------------------------------------------------- */
                      StreamBuilder<List<PetCategoryScreenModel>>(
                          stream: petScreenController.readCategory(),
                          builder: (context, snapShort) {
                            if (snapShort.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapShort.hasData) {
                              final pet = snapShort.data!;

                              return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 20,
                                          crossAxisSpacing: 10,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 191),
                                  itemCount: snapShort.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return buildPetContainer(
                                        index1: snapShort.data![index]);
                                  });
                            } else {
                              return const Center(child: CircleAvatar());
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildPetContainer({PetCategoryScreenModel? index1}) {
    return GetBuilder<PetCategoryScreenController>(
        init: PetCategoryScreenController(),
        builder: (petScreenController) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
            ),
            height: 200.h,
            width: 180.w,
            child: Column(
              children: [
                /* --------------------------------- Active --------------------------------- */

                SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 20.sp,
                        color: index1!.active! ? Colors.green : Colors.red,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        index1.active! ? 'Active' : 'Inactive',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: kPrimaryColor,
                  height: 1,
                ),
                /* ------------------------------ Title & Image ----------------------------- */
                SizedBox(
                  height: 100.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 72.w,
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage:
                              NetworkImage(index1.imageUrl.toString()),
                        ),
                      ),
                      SizedBox(
                          width: 72.w,
                          child: Text(
                            index1.petName.toString(),
                            style: TextStyle(fontSize: 14.sp),
                          ))
                    ],
                  ),
                ),
                const Divider(
                  color: kPrimaryColor,
                  height: 1,
                ),
                /* ------------------------------ Edit & Delete ----------------------------- */
                SizedBox(
                  height: 50.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /* ---------------------------------- Edit ---------------------------------- */
                      GestureDetector(
                        onTap: () {
                          /* ------------------------------------ . ----------------------------------- */
                          Get.bottomSheet(
                            GetBuilder<PetCategoryScreenController>(
                                init: PetCategoryScreenController(),
                                builder: (petCategoryScreenController) {
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
                                        key: petScreenController.formKey,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              /* ---------------------------- Category & Active --------------------------- */
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Edit Pet Category',
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  FlutterSwitch(
                                                    width: 100.w,
                                                    height: 35.h,
                                                    valueFontSize: 25.0,
                                                    toggleSize: 45.0,
                                                    value: index1.active!,
                                                    onToggle: (val) {
                                                      index1.active =
                                                          petScreenController
                                                              .updateActive(
                                                                  val);
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              /* -------------------------------------------------------------------------- */
                                              /*                                 Pet Picture                                */
                                              /* -------------------------------------------------------------------------- */

                                              CircleAvatar(
                                                radius: 100.r,
                                                backgroundImage:
                                                    petScreenController.image !=
                                                            null
                                                        ? FileImage(
                                                                petScreenController
                                                                    .image!)
                                                            as ImageProvider
                                                        : NetworkImage(
                                                            index1.imageUrl!,
                                                          ),
                                                // ignore: prefer_const_literals_to_create_immutables
                                                child: Stack(children: [
                                                  // ignore: prefer_const_constructors
                                                  GestureDetector(
                                                    onTap: petScreenController
                                                        .selectFile,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: CircleAvatar(
                                                        radius: 28.r,
                                                        backgroundColor:
                                                            Colors.orange,
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
                                              /* -------------------------- Title / Pet Name ------------------------- */
                                              SizedBox(
                                                height: 60.h,
                                                child: Column(
                                                  children: [
                                                    CustomeTextFieldLabel(
                                                      labelText: "Pet Name",
                                                      textAlign:
                                                          TextAlign.start,
                                                      fontSized: 14.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    SizedBox(
                                                      height: 6.h,
                                                    ),
                                                    CustomeTextFormField(
                                                      //labelText: index1.title,
                                                      defaultControllerText:
                                                          index1.petName!,
                                                      textController:
                                                          petScreenController
                                                              .titleController,
                                                      isObscure: false,
                                                      validate: (value) {
                                                        if (value != null &&
                                                            value.isNotEmpty) {
                                                          if (value.length <
                                                              3) {
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
                                                buttonText: 'Update',
                                                horPadding: 50,
                                                onPressed: () {
                                                  petScreenController
                                                      .updatePetCategory(
                                                          index1);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        },
                        child: SizedBox(
                          width: 72.w,
                          child: Icon(
                            Icons.edit,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 60.h,
                        width: 2.w,
                        color: kPrimaryColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          petScreenController.deletePetCategory(index1);
                        },
                        child: SizedBox(
                          width: 72.w,
                          child: Icon(
                            Icons.delete,
                            size: 20.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
