// ignore_for_file: unrelated_type_equality_checks

import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/Controller/home_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/item_details_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (homeController) {
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
                    /*                                Main Category                               */
                    /* -------------------------------------------------------------------------- */
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 180.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          'Main Category',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SizedBox(
                        height: 90.h,
                        child: StreamBuilder<List<CategoryScreenModel>>(
                            stream: homeController.readCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const SpinKitDoubleBounce(
                                  color: Colors.red,
                                  size: 30.0,
                                );
                              } else if (snapshot.hasData) {
                                homeController.categoryData = snapshot.data!;
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
                                          homeController
                                              .updateMainCategoryOnPressed(
                                                  snapshot.data![index]);
                                          homeController
                                              .updateMainCategoryIndex(index);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: snapshot
                                                        .data![index].title ==
                                                    homeController
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
                                                  homeController
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
                                                homeController
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
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 180.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(60.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          'Pets Category',
                          style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w900),
                        ),
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
                          stream: homeController.readPetCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapshot.hasData) {
                              homeController.petCategoryData = snapshot.data!;
                              return ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 8.w,
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount:
                                      homeController.petCategoryData.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        homeController
                                            .updatePetCategoryOnPressed(
                                                snapshot.data![index]);
                                        homeController
                                            .updatePetCategoryIndex(index);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              snapshot.data![index].petName ==
                                                      homeController
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
                                                homeController
                                                    .petCategoryData[index]
                                                    .imageUrl
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                              height: 50,
                                              width: 50,
                                            ),
                                            /* ------------------------------ Category Name ----------------------------- */
                                            Text(homeController
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
                    homeController.mainCategoryIndex == 0 ||
                            homeController.mainCategoryIndex == -1
                        ? Container(
                            alignment: Alignment.centerLeft,
                            width: 180.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Text(
                                'Pets Medicine',
                                style: TextStyle(
                                    color: kWhiteColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets Medicine                               */
                    /* -------------------------------------------------------------------------- */
                    homeController.mainCategoryIndex == 0 ||
                            homeController.mainCategoryIndex == -1
                        ? StreamBuilder<List<StockModel>>(
                            stream: homeController.readMedicineCategory(),
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
                    homeController.mainCategoryIndex == 1 ||
                            homeController.mainCategoryIndex == -1
                        ? Column(
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 180.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60.r),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: Text(
                                    'Pets Food',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets     Food                               */
                    /* -------------------------------------------------------------------------- */
                    homeController.mainCategoryIndex == 1 ||
                            homeController.mainCategoryIndex == -1
                        ? StreamBuilder<List<StockModel>>(
                            stream: homeController.readFoodCategory(),
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
                                    return buildFoodContainer(
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
                    /* -------------------------------------------------------------------------- */
                    /*                                  Pet Text                                  */
                    /* -------------------------------------------------------------------------- */
                    homeController.mainCategoryIndex == 2 ||
                            homeController.mainCategoryIndex == -1
                        ? Column(
                            children: [
                              SizedBox(
                                height: 8.h,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 180.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(60.r),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: Text(
                                    'Pets',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 10.h,
                    ),

                    /* -------------------------------------------------------------------------- */
                    /*                                Pets                                        */
                    /* -------------------------------------------------------------------------- */
                    homeController.mainCategoryIndex == 2 ||
                            homeController.mainCategoryIndex == -1
                        ? StreamBuilder<List<StockModel>>(
                            stream: homeController.readPet(),
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
  Widget buildMedicineContainer({StockModel? index1}) {
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ItemDetailsScreen.id, arguments: index1);
                  },
                  child: SizedBox(
                    height: 126.h,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        index1!.itemImageUrl.toString(),
                      ),
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
                  height: 86.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* ----------------------------- Name Of Product ---------------------------- */
                      CustomeTextFieldLabel(
                        labelText: index1.itemName!,
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        maxLine: 2,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      /* ------------------------- Review and total order ------------------------- */
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.yellow,
                      //       size: 14.sp,
                      //     ),
                      //     SizedBox(
                      //       width: 4.w,
                      //     ),
                      //     const Text(
                      //       '4.0',
                      //       style: TextStyle(fontWeight: FontWeight.w800),
                      //     ),
                      //     SizedBox(
                      //       width: 10.w,
                      //     ),
                      //     Text('12'),
                      //     SizedBox(
                      //       width: 4.w,
                      //     ),
                      //     Text(
                      //       'Reviews',
                      //       style: TextStyle(fontSize: 12.sp),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 4.h,
                      // ),
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
  Widget buildPetContainer({StockModel? index1}) {
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed(ItemDetailsScreen.id, arguments: index1);
                  },
                  child: SizedBox(
                    height: 126.h,
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        index1!.itemImageUrl.toString(),
                      ),
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
                  height: 86.h,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* ----------------------------- Name Of Product ---------------------------- */
                      CustomeTextFieldLabel(
                        labelText: index1.itemName!,
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
                            'RS: ${index1.itemPrice}',
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
  Widget buildFoodContainer({StockModel? index1}) {
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(ItemDetailsScreen.id, arguments: index1);
                        },
                        child: SizedBox(
                          height: 126.h,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              index1.itemImageUrl.toString(),
                            ),
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
                        height: 86.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* ----------------------------- Name Of Product ---------------------------- */
                            CustomeTextFieldLabel(
                              labelText: index1.itemName!,
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
                                  'RS: ${index1.itemPrice}',
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
