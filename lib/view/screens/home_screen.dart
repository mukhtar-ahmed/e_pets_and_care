// ignore_for_file: unrelated_type_equality_checks

import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Controller/add_food_screen_controller.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Controller/add_medicine_screen_controller.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Controller/add_pet_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:e_pets_and_care/Controller/home_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AddMedicineScreenController addMedicineScreenController =
        Get.put(AddMedicineScreenController());
    AddPetScreenCotroller addPetScreenCotroller =
        Get.put(AddPetScreenCotroller());
    AddFoodScreenController addFoodScreenController =
        Get.put(AddFoodScreenController());

    // ignore: prefer_const_constructors
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (homeScreenController) {
          return Scaffold(
            backgroundColor: Colors.grey[300],
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                            Search Field And Cart                           */
                    /* -------------------------------------------------------------------------- */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        children: [
                          Container(
                            width: 280.w,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              decoration: InputDecoration(
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  hintText: "Search here"),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 50.w,
                            child: IconButton(
                              onPressed: () {
                                //homeScreenController.updateOnPressed();
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: homeScreenController.a
                                    ? Colors.blue
                                    : Colors.red,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                Main Category                               */
                    /* -------------------------------------------------------------------------- */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        'Main Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SizedBox(
                        height: 90.h,
                        child: StreamBuilder<List<CategoryScreenModel>>(
                            stream: homeScreenController.readCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const SpinKitDoubleBounce(
                                  color: Colors.red,
                                  size: 30.0,
                                );
                              } else if (snapshot.hasData) {
                                homeScreenController.categoryData =
                                    snapshot.data!;
                                return ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        width: 8.w,
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          homeScreenController
                                              .updateMainCategoryOnPressed(
                                                  snapshot.data![index]);
                                          homeScreenController
                                              .updateMainCategoryIndex(index);

                                          print(homeScreenController
                                              .mainCategoryIndex);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: snapshot
                                                        .data![index].title ==
                                                    homeScreenController
                                                        .mainCategoryOnPressed
                                                ? kPrimaryColor
                                                : kWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3.w,
                                                    vertical: 3.h),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 10.h),
                                                /* ------------------------------ Category Icon ----------------------------- */
                                                child: Image.network(
                                                  homeScreenController
                                                      .categoryData[index]
                                                      .imageUrl
                                                      .toString(),
                                                  // snapshot.data![index].imageUrl
                                                  //     .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                height: 40,
                                                width: 50,
                                              ),
                                              /* ------------------------------ Category Name ----------------------------- */
                                              Text(
                                                homeScreenController
                                                    .categoryData[index].title!,
                                                //snapshot.data![index].title!,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                    child: SpinKitRing(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ));
                              }
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    /* ------------------------------ Category Text ----------------------------- */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        'Pets Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.sp),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                Pet Category                                */
                    /* -------------------------------------------------------------------------- */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SizedBox(
                        height: 105.h,
                        child: StreamBuilder<List<PetCategoryScreenModel>>(
                          stream: homeScreenController.readPetCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapshot.hasData) {
                              homeScreenController.petCategoryData =
                                  snapshot.data!;
                              return ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 8.w,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: homeScreenController
                                      .petCategoryData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        homeScreenController
                                            .updatePetCategoryOnPressed(
                                                snapshot.data![index]);
                                        homeScreenController
                                            .updatePetCategoryIndex(index);

                                        print(homeScreenController
                                            .petCategoryIndex);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              snapshot.data![index].petName ==
                                                      homeScreenController
                                                          .petCategoryOnPressed
                                                  ? kPrimaryColor
                                                  : kWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 3.h),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 10.h),
                                              /* ------------------------------ Category Icon ----------------------------- */
                                              child: Image.network(
                                                homeScreenController
                                                    .petCategoryData[index]
                                                    .imageUrl
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                              height: 50,
                                              width: 50,
                                            ),
                                            /* ------------------------------ Category Name ----------------------------- */
                                            Text(homeScreenController
                                                .petCategoryData[index]
                                                .petName!)
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return const Center(
                                child: SpinKitRing(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                             Pets Medicine Text                             */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 0 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? Text(
                            'Pets Medicine',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w900),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets Medicine                               */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 0 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? StreamBuilder<List<MedicineModel>>(
                            stream: addMedicineScreenController
                                .readMedicineCategory(),
                            builder: (context, snapShort) {
                              if (snapShort.hasError) {
                                return const Text('Some Thing Wrong');
                              } else if (snapShort.hasData) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 200),
                                  itemCount: snapShort.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return buildMedicineContainer(
                                        index1: snapShort.data![index]);
                                  },
                                );
                              } else {
                                return const Center(
                                    child: SpinKitRing(
                                  color: kPrimaryColor,
                                  size: 50.0,
                                ));
                              }
                            },
                          )
                        : Container(),
                    /* -------------------------------------------------------------------------- */
                    /*                                  Pet Food    Text                          */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 1 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? Text(
                            'Pets Food',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w900),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets     Food                               */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 1 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? StreamBuilder<List<FoodModel>>(
                            stream:
                                addFoodScreenController.readMedicineCategory(),
                            builder: (context, snapShort) {
                              if (snapShort.hasError) {
                                return const Text('Some Thing Wrong');
                              } else if (snapShort.hasData) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 200),
                                  itemCount: snapShort.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    if (snapShort.data![index].petCategory ==
                                        homeScreenController
                                            .petCategoryOnPressed) {
                                      return buildFoodContainer(
                                          index1: snapShort.data![index]);
                                    } else if (snapShort
                                            .data![index].petCategory ==
                                        'cat') {
                                      return Container();
                                    } else {
                                      return Container();
                                    }
                                  },
                                );
                              } else {
                                return const Center(
                                  child: SpinKitRing(
                                    color: kPrimaryColor,
                                    size: 50.0,
                                  ),
                                );
                              }
                            })
                        : Container(),
                    /* -------------------------------------------------------------------------- */
                    /*                                  Pet Text                                  */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 2 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? Text(
                            'Pets',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.w900),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets                                        */
                    /* -------------------------------------------------------------------------- */
                    homeScreenController.mainCategoryIndex == 2 ||
                            homeScreenController.mainCategoryIndex == -1
                        ? StreamBuilder<List<PetModel>>(
                            stream: addPetScreenCotroller.readPetCategory(),
                            builder: (context, snapShort) {
                              if (snapShort.hasError) {
                                return const Text('Some Thing Wrong');
                              } else if (snapShort.hasData) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 2,
                                          mainAxisExtent: 200),
                                  itemCount: snapShort.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return buildPetContainer(
                                        index1: snapShort.data![index]);
                                  },
                                );
                              } else {
                                return const Center(
                                  child: SpinKitRing(
                                    color: kPrimaryColor,
                                    size: 50.0,
                                  ),
                                );
                              }
                            })
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        });
  }

/* -------------------------------------------------------------------------- */
/*                             Medicine Container                             */
/* -------------------------------------------------------------------------- */
  Widget buildMedicineContainer({MedicineModel? index1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
        ),
        height: 210.h,
        width: 167.w,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 126.h,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      index1!.imageUrl.toString(),
                    ),
                  ),
                ),

                /* -------------------------------------------------------------------------- */
                /*                              Bottom Container                              */
                /* -------------------------------------------------------------------------- */
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
                      /* ----------------------------- Name Of Product ---------------------------- */
                      CustomeTextFieldLabel(
                        labelText: index1.medicineName!,
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ------------------------- Review and total order ------------------------- */
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.sp,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Text(
                            '4.0',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('12'),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(fontSize: 12.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ----------------------------- Price and Cart ----------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RS: ${index1.medicinePrice}',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w900),
                          ),
                          Container(
                            width: 50.w,
                            height: 28.h,
                            child: const Icon(Icons.shopping_cart),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

/* -------------------------------------------------------------------------- */
/*                                Pet Container                               */
/* -------------------------------------------------------------------------- */
  Widget buildPetContainer({PetModel? index1}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor),
        ),
        height: 210.h,
        width: 167.w,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: 126.h,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      index1!.imageUrl.toString(),
                    ),
                  ),
                ),

                /* -------------------------------------------------------------------------- */
                /*                              Bottom Container                              */
                /* -------------------------------------------------------------------------- */
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
                      /* ----------------------------- Name Of Product ---------------------------- */
                      CustomeTextFieldLabel(
                        labelText: index1.petName!,
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ------------------------- Review and total order ------------------------- */
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 14.sp,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          const Text(
                            '4.0',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text('12'),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            'Reviews',
                            style: TextStyle(fontSize: 12.sp),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ----------------------------- Price and Cart ----------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'RS: ${index1.petPrice}',
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w900),
                          ),
                          Container(
                            width: 50.w,
                            height: 28.h,
                            child: const Icon(Icons.shopping_cart),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

/* -------------------------------------------------------------------------- */
/*                               Food Container                               */
/* -------------------------------------------------------------------------- */
  Widget buildFoodContainer({FoodModel? index1}) {
    return index1 == null
        ? SizedBox()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: kPrimaryColor),
              ),
              height: 210.h,
              width: 167.w,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: 126.h,
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            index1!.imageUrl.toString(),
                          ),
                        ),
                      ),

                      /* -------------------------------------------------------------------------- */
                      /*                              Bottom Container                              */
                      /* -------------------------------------------------------------------------- */
                      Container(
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        height: 81.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* ----------------------------- Name Of Product ---------------------------- */
                            CustomeTextFieldLabel(
                              labelText: index1.foodName!,
                              textAlign: TextAlign.start,
                              fontSized: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            /* ------------------------- Review and total order ------------------------- */
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                const Text(
                                  '4.0',
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text('12'),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Text(
                                  'Reviews',
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            /* ----------------------------- Price and Cart ----------------------------- */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'RS: ${index1.foodPrice}',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  width: 50.w,
                                  height: 28.h,
                                  child: const Icon(Icons.shopping_cart),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
