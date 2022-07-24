import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Controller/custome_product_details_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../Controller/registration_screen_controller.dart';

class CustomeProductDetails extends StatelessWidget {
  const CustomeProductDetails(
      {Key? key,
      required this.petCategoy,
      required this.stock,
      required this.imageUrl,
      required this.productName,
      required this.productPrice,
      required this.productDescription,
      required this.id})
      : super(key: key);
  final String imageUrl;
  final int stock;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String petCategoy;
  final String id;

  @override
  Widget build(BuildContext context) {
    RegistrationScreenController registrationScreenController =
        Get.put(RegistrationScreenController());
    User? user = registrationScreenController.auth.currentUser;
    return GetBuilder<CustomeProductDetailsController>(
        init: CustomeProductDetailsController(),
        builder: (customeProductDetailsController) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                color: kPrimaryColor,
                height: 812.h,
                width: 375.w,
                child: Column(
                  children: [
                    ClipRRect(
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        child: Image(
                          image: NetworkImage(
                            imageUrl,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100.r),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryColor.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        color: kWhiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(100.r),
                        ),
                      ),
                      height: 380,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                productName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              SizedBox(
                                height: 70.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    /* -------------------------------------------------------------------------- */
                                    /*                                    Price                                   */
                                    /* -------------------------------------------------------------------------- */
                                    Container(
                                      width: 150.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'RS : ',
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Text(
                                            productPrice.toString(),
                                            style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ],
                                      ),
                                    ),
                                    /* -------------------------------------------------------------------------- */
                                    /*                                  Quantity                                  */
                                    /* -------------------------------------------------------------------------- */
                                    Container(
                                      width: 150.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: kPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap:
                                                customeProductDetailsController
                                                    .decreaseQuantity,
                                            child: Container(
                                              height: 40.h,
                                              width: 40.w,
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                                color:
                                                    customeProductDetailsController
                                                            .decreasePressed
                                                        ? kPrimaryColor
                                                        : kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 30.sp,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            customeProductDetailsController
                                                .quantity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          if (customeProductDetailsController
                                                  .quantity <
                                              stock)
                                            GestureDetector(
                                              onTap:
                                                  customeProductDetailsController
                                                      .increaseQuantity,
                                              child: Container(
                                                height: 40.h,
                                                width: 40.w,
                                                decoration: BoxDecoration(
                                                  color:
                                                      customeProductDetailsController
                                                              .increasePressed
                                                          ? kPrimaryColor
                                                          : kWhiteColor,
                                                  border: Border.all(),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  size: 30.sp,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReadMoreText(
                                productDescription,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                                trimLines: 7,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Stock: ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    stock >= 1
                                        ? stock.toString()
                                        : "Out of Stock",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: stock >= 1
                                          ? Colors.black
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /* -------------------------------------------------------------------------- */
                              /*                                 Cart Button                                */
                              /* -------------------------------------------------------------------------- */

                              stock >= 1
                                  ? Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: kPrimaryColor,
                                      ),
                                      child: customeProductDetailsController
                                                  .cartPressed ==
                                              false
                                          ? TextButton(
                                              child: const Icon(
                                                Icons.shopping_cart,
                                                color: kWhiteColor,
                                              ),
                                              onPressed: () {
                                                customeProductDetailsController
                                                    .sendData(
                                                  productName,
                                                  imageUrl,
                                                  productPrice,
                                                  petCategoy,
                                                  id,
                                                  stock,
                                                  user!.uid,
                                                );
                                              },
                                            )
                                          : SpinKitDoubleBounce(
                                              color: kWhiteColor,
                                              size: 40.sp,
                                            ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.orange),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.warning),
                                                Text(
                                                  "Sorry! this item is no longer available",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
