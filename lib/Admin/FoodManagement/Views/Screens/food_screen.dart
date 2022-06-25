import 'package:e_pets_and_care/Admin/FoodManagement/Controller/add_food_screen_controller.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Controller/food_screen_controller.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/add_food_screen.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FoodScreen extends StatelessWidget {
  static const String id = '/food_screen';
  FoodScreen({Key? key}) : super(key: key);
  FoodScreenController foodScreenController = Get.put(FoodScreenController());

  @override
  Widget build(BuildContext context) {
    var textfieldtext;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Food'),
          backgroundColor: kWhiteColor,
          actions: [
            GestureDetector(
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
                      'Add Food',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              onTap: () async {
                Get.toNamed(AddFoodScreen.id);
              },
            ),
          ]),
      body: GetBuilder<FoodScreenController>(
          init: FoodScreenController(),
          builder: (foodScreenController) {
            var streamBuilder = StreamBuilder<List<StockModel>>(
                stream: foodScreenController.readFoodCategory(),
                builder: (context, snapShort) {
                  if (snapShort.hasError) {
                    return const Text('Some Thing Wrong');
                  } else if (snapShort.hasData) {
                    final pet = snapShort.data!;

                    return Column(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                Search Field                                */
                        /* -------------------------------------------------------------------------- */
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                          padding: const EdgeInsets.fromLTRB(15, 3, 0, 3),
                          decoration: const BoxDecoration(
                            color: Color(0xffEDF0F4),
                            // color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: TextFormField(
                            controller: foodScreenController.searchController,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                              hintText: 'Search',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  icon: const Icon(FontAwesomeIcons.xmark),
                                  onPressed: () {}),
                            ),
                            onChanged: (String query) {
                              textfieldtext = foodScreenController
                                  .searchController.text
                                  .trim();
                              final suggestions =
                                  snapShort.data!.where((categoryfilter) {
                                final categoryTitle =
                                    categoryfilter.itemName!.toLowerCase();
                                final input = query.toLowerCase();
                                return categoryTitle.contains(input);
                              }).toList();
                              foodScreenController.addFill(suggestions);
                              // setState(() {
                              //   addMedicineScreenController.fil =
                              //       suggestions;
                              // });
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
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 0,
                                    crossAxisCount: 2,
                                    mainAxisExtent: 296),
                            itemCount: foodScreenController
                                        .searchController.text
                                        .trim() !=
                                    ''
                                ? foodScreenController.fil.length
                                : snapShort.data!.length,
                            itemBuilder: (BuildContext context, index) {
                              return buildFoodContainer(
                                  index1: foodScreenController
                                              .searchController.text
                                              .trim() !=
                                          ''
                                      ? foodScreenController.fil[index]
                                      : snapShort.data![index]);
                            }),
                      ],
                    );
                  } else {
                    return const Center(child: CircleAvatar());
                  }
                });
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 360.w,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      /* -------------------------------------------------------------------------- */
                      /*                         Food Display Container                         */
                      /* -------------------------------------------------------------------------- */
                      streamBuilder,
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildFoodContainer({StockModel? index1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
        ),
        height: 317.h,
        width: 167.w,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 180.h,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      index1!.itemImageUrl.toString(),
                    ),
                  ),
                ),
                Container(
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  height: 81.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* ----------------------------- Name Of Food ---------------------------- */
                      CustomeTextFieldLabel(
                        labelText: index1.itemName.toString(),
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* -------------------------- Food Description -------------------------- */
                      // ignore: prefer_const_constructors
                      Flexible(
                        child: Text(
                          index1.itemDescription.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ----------------------------- Price and Cart ----------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RS: ${index1.itemPrice}',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w900),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 50.w,
                            height: 28.h,
                            child: Text(
                              index1.itemQuantity.toString(),
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                /* ------------------------------ Edit & Delete ----------------------------- */
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          foodScreenController.deleteFood(index1);
                        },
                        child: SizedBox(
                          width: 73.w,
                          child: Icon(
                            Icons.delete,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 60.h,
                        width: 2.w,
                        color: kPrimaryColor,
                      ),
                      /* -------------------------------------------------------------------------- */
                      /*                                 Edit Start                                 */
                      /* -------------------------------------------------------------------------- */
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            GetBuilder<FoodScreenController>(
                                init: FoodScreenController(),
                                builder: (foodScreenController) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          topRight: Radius.circular(20.r),
                                        ),
                                      ),
                                      height: 780.h,
                                      child: Form(
                                        key: foodScreenController.formKey,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              /* ------------------------- Edit Food & Active ------------------------- */
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'Edit Food',
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),

                                              /* ---------------------------- Food Picture --------------------------- */
                                              CircleAvatar(
                                                radius: 100.r,
                                                backgroundImage:
                                                    foodScreenController
                                                                .image !=
                                                            null
                                                        ? FileImage(
                                                                foodScreenController
                                                                    .image!)
                                                            as ImageProvider
                                                        : NetworkImage(
                                                            index1
                                                                .itemImageUrl!,
                                                          ),
                                                // ignore: prefer_const_literals_to_create_immutables
                                                child: Stack(children: [
                                                  // ignore: prefer_const_constructors
                                                  GestureDetector(
                                                    onTap: foodScreenController
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
                                              /* -------------------------- Title / Food Name ------------------------- */
                                              SizedBox(
                                                height: 60.h,
                                                child: Column(
                                                  children: [
                                                    CustomeTextFieldLabel(
                                                      labelText: "Food Name",
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
                                                          index1.itemName!,
                                                      textController:
                                                          foodScreenController
                                                              .foodNameController,
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
                                                keyboardType:
                                                    TextInputType.number,
                                                defaultControllerText:
                                                    index1.itemPrice.toString(),
                                                textController:
                                                    foodScreenController
                                                        .foodPriceController,
                                                isObscure: false,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter the Price';
                                                  } else if (int.parse(value) <
                                                      0) {
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
                                                labelText: "Food Quantity",
                                                textAlign: TextAlign.start,
                                                fontSized: 14.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              CustomeTextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                defaultControllerText: index1
                                                    .itemQuantity
                                                    .toString(),
                                                textController:
                                                    foodScreenController
                                                        .foodQuantityController,
                                                isObscure: false,
                                                validate: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter the Quantity';
                                                  } else if (int.parse(value) <
                                                      0) {
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
                                              StreamBuilder<
                                                  List<PetCategoryScreenModel>>(
                                                stream: foodScreenController
                                                    .readCategory(),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return const Center(
                                                      child:
                                                          CupertinoActivityIndicator(),
                                                    );
                                                  } else if (snapshot.hasData) {
                                                    foodScreenController
                                                        .categoryIten!
                                                        .clear();
                                                    for (int i = 0;
                                                        i <
                                                            snapshot
                                                                .data!.length;
                                                        i++) {
                                                      foodScreenController
                                                              .index =
                                                          snapshot.data![i];

                                                      foodScreenController
                                                          .categoryIten!
                                                          .add(
                                                        DropdownMenuItem(
                                                          child: Text(
                                                            foodScreenController
                                                                .index.petName
                                                                .toString(),
                                                          ),
                                                          value:
                                                              foodScreenController
                                                                  .index.petName
                                                                  .toString(),
                                                        ),
                                                      );
                                                    }
                                                  }
                                                  return DropdownButtonFormField<
                                                      dynamic>(
                                                    items: foodScreenController
                                                        .categoryIten,
                                                    onChanged: (categoryValue) {
                                                      Get.snackbar('Error',
                                                          categoryValue);
                                                      foodScreenController
                                                          .updateMenuValue(
                                                              categoryValue);
                                                    },
                                                    value: index1.petCategory,
                                                    validator: (value) =>
                                                        value == null
                                                            ? 'field required'
                                                            : null,
                                                    isExpanded: true,
                                                    hint: const Text(
                                                        'Select Pet Category'),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              /* ---------------------------- Descrition of FOOD --------------------------- */
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
                                                controller: foodScreenController
                                                    .foodDescriptionController
                                                  ..text =
                                                      index1.itemDescription!,
                                                maxLines: 3,
                                                validator: (value) {
                                                  if (value != null &&
                                                      value.isNotEmpty) {
                                                    if (value.length < 15) {
                                                      return "Description should be atleast 15 Character";
                                                    }
                                                  } else {
                                                    return 'Description cannot be empty';
                                                  }
                                                  return null;
                                                },
                                                decoration: const InputDecoration(
                                                    border:
                                                        OutlineInputBorder()),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              /* ------------------------------- Update Button ------------------------------ */
                                              CustomeButton(
                                                buttonColor: Colors.orange,
                                                fontColor: Colors.white,
                                                buttonText: 'Update',
                                                horPadding: 50,
                                                onPressed: () {
                                                  Get.back();
                                                  foodScreenController
                                                      .updateCategory(index1);
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
                          width: 73.w,
                          child: Icon(
                            Icons.edit,
                            size: 20.sp,
                          ),
                        ),
                      )
                      /* -------------------------------------------------------------------------- */
                      /*                                  Edit End                                  */
                      /* -------------------------------------------------------------------------- */
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
