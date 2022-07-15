import 'package:e_pets_and_care/Admin/PetSupplierManagement/Controller/supplier_controller.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Model/supplier_%20model.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/add_supplier_screen.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupplierController>(
        init: SupplierController(),
        builder: (supplierController) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kWhiteColor,
              /* ---------------------------- Pet Supplier Text --------------------------- */
              title: Text(
                'Pet Supplier Management',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
              ),
              // ignore: prefer_const_literals_to_create_immutables
              actions: [
                /* ---------------------------- App Pet Supplier ---------------------------- */
                const AddSupplierScreen(),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      /* --------------------- Pet Supplier Display Container --------------------- */
                      StreamBuilder<List<SupplierModel>>(
                          stream: supplierController.readSupplier(),
                          builder: (context, snapShort) {
                            if (snapShort.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapShort.hasData) {
                              final supplier = snapShort.data!;

                              return Column(
                                children: [
                                  /* -------------------------------------------------------------------------- */
                                  /*                                Search Field                                */
                                  /* -------------------------------------------------------------------------- */
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 10),
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 3, 0, 3),
                                    decoration: const BoxDecoration(
                                      color: Color(0xffEDF0F4),
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller:
                                          supplierController.searchController,
                                      decoration: InputDecoration(
                                        // contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                                        hintText: 'Search',
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                            icon: const Icon(
                                                FontAwesomeIcons.xmark),
                                            onPressed: () {}),
                                      ),
                                      onChanged: (String query) {
                                        var textfieldtext = supplierController
                                            .searchController.text
                                            .trim();
                                        final suggestions = snapShort.data!
                                            .where((supplierfilter) {
                                          final supplierTitle = supplierfilter
                                              .supplierName!
                                              .toLowerCase();
                                          final input = query.toLowerCase();
                                          return supplierTitle.contains(input);
                                        }).toList();
                                        supplierController.addFill(suggestions);
                                      },
                                    ),
                                  ),

                                  /* -------------------------------------------------------------------------- */
                                  /*                              Search Field End                              */
                                  /* -------------------------------------------------------------------------- */

                                  GridView.builder(
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 20,
                                              crossAxisSpacing: 10,
                                              crossAxisCount: 1,
                                              mainAxisExtent: 151),
                                      itemCount: supplierController
                                                  .searchController.text
                                                  .trim() !=
                                              ''
                                          ? supplierController.fil.length
                                          : snapShort.data!.length,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return buildSupplier(
                                            index1: supplierController
                                                        .searchController.text
                                                        .trim() !=
                                                    ''
                                                ? supplierController.fil[index]
                                                : snapShort.data![index]);
                                      }),
                                ],
                              );
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

  Widget buildSupplier({SupplierModel? index1}) {
    return GetBuilder<SupplierController>(
        init: SupplierController(),
        builder: (supplierController) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: kPrimaryColor)),
            width: double.infinity,
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /* -------------------------------------------------------------------------- */
                  /*                                    Image                                   */
                  /* -------------------------------------------------------------------------- */
                  Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(index1!.imageUrl.toString()),
                      ),
                    ),
                  ),
                  /* ------------------------------------ . ----------------------------------- */
                  Expanded(
                    child: Column(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                Suppiler Name                               */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Flexible(
                                child: Text(
                                  index1.supplierName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                              Supplier Company                              */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          child: Row(
                            children: [
                              Text(
                                'Company : ',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Flexible(
                                child: Text(
                                  index1.supplierCompany.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              )
                            ],
                          ),
                        ),

                        /* ------------------------------ Edit & Delete ----------------------------- */
                        SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                /* ---------------------------------- Edit ---------------------------------- */
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      /* ------------------------------------ . ----------------------------------- */
                                      Get.bottomSheet(
                                        GetBuilder<SupplierController>(
                                            init: SupplierController(),
                                            builder: (supplierController) {
                                              return SingleChildScrollView(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20.r),
                                                      topRight:
                                                          Radius.circular(20.r),
                                                    ),
                                                  ),
                                                  height: 600.h,
                                                  child: Form(
                                                    key: supplierController
                                                        .formKey,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25.w),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Text(
                                                            'Edit Supplier',
                                                            style: TextStyle(
                                                                fontSize: 20.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900),
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),

                                                          /* ---------------------------- Categeory Picture --------------------------- */
                                                          CircleAvatar(
                                                            radius: 100.r,
                                                            backgroundImage: supplierController
                                                                        .image !=
                                                                    null
                                                                ? FileImage(supplierController
                                                                        .image!)
                                                                    as ImageProvider
                                                                : NetworkImage(
                                                                    index1
                                                                        .imageUrl!,
                                                                  ),
                                                            // ignore: prefer_const_literals_to_create_immutables
                                                            child: Stack(
                                                                children: [
                                                                  // ignore: prefer_const_constructors
                                                                  GestureDetector(
                                                                    onTap: supplierController
                                                                        .selectFile,
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomRight,
                                                                      child:
                                                                          CircleAvatar(
                                                                        radius:
                                                                            28.r,
                                                                        backgroundColor:
                                                                            Colors.orange,
                                                                        child:
                                                                            const Icon(
                                                                          CupertinoIcons
                                                                              .camera,
                                                                          color:
                                                                              Colors.white,
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
                                                          SizedBox(
                                                            height: 60.h,
                                                            child: Column(
                                                              children: [
                                                                CustomeTextFieldLabel(
                                                                  labelText:
                                                                      "Supplier Name",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  fontSized:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                SizedBox(
                                                                  height: 6.h,
                                                                ),
                                                                CustomeTextFormField(
                                                                  //labelText: index1.title,
                                                                  defaultControllerText:
                                                                      index1
                                                                          .supplierName!,
                                                                  textController:
                                                                      supplierController
                                                                          .supplierNameController,
                                                                  isObscure:
                                                                      false,
                                                                  validate:
                                                                      (value) {
                                                                    if (value !=
                                                                            null &&
                                                                        value
                                                                            .isNotEmpty) {
                                                                      if (value
                                                                              .length <
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
                                                          /* -------------------------------------------------------------------------- */
                                                          /*                            Supplier Company Name                           */
                                                          /* -------------------------------------------------------------------------- */
                                                          SizedBox(
                                                            height: 60.h,
                                                            child: Column(
                                                              children: [
                                                                CustomeTextFieldLabel(
                                                                  labelText:
                                                                      "Supplier Company Name",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  fontSized:
                                                                      14.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                                SizedBox(
                                                                  height: 6.h,
                                                                ),
                                                                CustomeTextFormField(
                                                                  //labelText: index1.title,
                                                                  defaultControllerText:
                                                                      index1
                                                                          .supplierCompany!,
                                                                  textController:
                                                                      supplierController
                                                                          .supplierCompanyController,
                                                                  isObscure:
                                                                      false,
                                                                  validate:
                                                                      (value) {
                                                                    if (value !=
                                                                            null &&
                                                                        value
                                                                            .isNotEmpty) {
                                                                      if (value
                                                                              .length <
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
                                                            buttonColor:
                                                                Colors.orange,
                                                            fontColor:
                                                                Colors.white,
                                                            buttonText:
                                                                'Update',
                                                            horPadding: 50,
                                                            onPressed: () {
                                                              supplierController
                                                                  .updateSupplier(
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
                                    child: Container(
                                      color: Colors.orangeAccent,
                                      child: Icon(
                                        Icons.edit,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      supplierController.deleteSupplier(index1);
                                    },
                                    child: Container(
                                      color: Colors.orange[200],
                                      child: Icon(
                                        Icons.delete,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
