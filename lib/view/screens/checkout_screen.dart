import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Controller/pet_screen_controller.dart';
import 'package:e_pets_and_care/Controller/checkout_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:e_pets_and_care/view/screens/bottom_navigation_bar.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/registration_screen_controller.dart';

class CheckoutScreen extends StatelessWidget {
  static const String id = '/checkout_screen';
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List args = Get.arguments!;
    int total = args[0];
    int stock = args[1];
    int quantity = args[2];
    String itemid = args[3];
    int finalstock = stock - quantity;
    String? productName;
    String? productPrice;
    String? adress;
    String? productQuantity;
    String? productImage;
    RegistrationScreenController registrationScreenController =
        Get.put(RegistrationScreenController());
    User? user = registrationScreenController.auth.currentUser;
    String? orderStatus = 'Processing';
    return GetBuilder<CheckoutController>(
        init: CheckoutController(),
        builder: (checkoutController) {
          return Scaffold(
            /* --------------------------------- AppBar --------------------------------- */
            appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                backgroundColor: kPrimaryColor,
                centerTitle: true,
                title: Text(
                  'Check out',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
                )),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: kPrimaryColor,
                              ),
                              const Text('Shipping Address'),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20.r),
                                            topLeft: Radius.circular(20.r)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.w),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 30.h,
                                            ),
                                            Text(
                                              'Address',
                                              style: TextStyle(
                                                  fontSize: 25.sp,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            CustomeTextFieldLabel(
                                              labelText: 'Enter Address',
                                              textAlign: TextAlign.start,
                                              fontSized: 14.sp,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            TextFormField(
                                              controller: checkoutController
                                                  .addressController,
                                              maxLines: 3,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder()),
                                            ),
                                            SizedBox(
                                              height: 17.h,
                                            ),
                                            CustomeButton(
                                              buttonColor: Colors.orange,
                                              fontColor: Colors.white,
                                              buttonText: 'Sava',
                                              horPadding: 15,
                                              onPressed: () {
                                                checkoutController
                                                    .firebaseFirestore
                                                    .collection('address')
                                                    .doc('uid')
                                                    .update({
                                                  'location': checkoutController
                                                      .addressController.text
                                                      .trim()
                                                });
                                                Get.back();
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: kPrimaryColor,
                                  padding: EdgeInsets.all(4.0),
                                  width: 120.w,
                                  child: Text(
                                    'New Address',
                                    style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: FutureBuilder<DocumentSnapshot>(
                                future: checkoutController.firebaseFirestore
                                    .collection('address')
                                    .doc('uid')
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("Loading...");
                                  }
                                  adress = snapshot.data!['location'];
                                  return Text(snapshot.data!['location']);
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                              Bag Summary Start                             */
                  /* -------------------------------------------------------------------------- */
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /* ------------------------ Bag Summary Text and Icon ----------------------- */
                        Row(
                          children: [
                            SizedBox(
                              width: 25.w,
                            ),
                            Icon(
                              Icons.shopping_bag,
                              color: kPrimaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Bag Summary',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w900),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        /* -------------------------------- Cart Data ------------------------------- */
                        StreamBuilder<List<CartModel>>(
                            stream: checkoutController.readCart(user!.uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Some Thing Wrong');
                              } else if (snapshot.hasData) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 0,
                                          crossAxisSpacing: 0,
                                          crossAxisCount: 1,
                                          mainAxisExtent: 30),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    var index1 = snapshot.data![index];
                                    productName = index1.productName!;
                                    productImage = index1.imageUrl;
                                    productPrice =
                                        index1.productPrice.toString();
                                    productQuantity =
                                        index1.quantity.toString();
                                    checkoutController.productTotalPrice.add(
                                        index1.productPrice! *
                                            index1.quantity!);
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 58.sp),
                                          child: Text(
                                            index1.productName.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(right: 20.sp),
                                          child: Text(
                                            '${checkoutController.productTotalPrice[index]}',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                return const Center(child: CircleAvatar());
                              }
                            }),
                        SizedBox(
                          height: 6.h,
                        ),
                        /* ------------------------------- Total Price ------------------------------ */

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 58.sp),
                              child: Text(
                                'Total',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.sp),
                              child: Text(
                                total.toString(),
                                //'${checkoutController.total}',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w900),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                               Bag Summary End                              */
                  /* -------------------------------------------------------------------------- */
                  SizedBox(
                    height: 20.h,
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                            Buy Now Button Start                            */
                  /* -------------------------------------------------------------------------- */
                  CustomeButton(
                    buttonColor: kPrimaryColor,
                    fontColor: kWhiteColor,
                    buttonText: 'Buy Now',
                    horPadding: 25,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Order PLace'),
                                content: Text('Your Order Place Successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      checkoutController.updatequantity(
                                          itemid, finalstock);

                                      checkoutController.deleteitem(itemid);
                                      await checkoutController.sendData(
                                          productName,
                                          productPrice,
                                          adress,
                                          productQuantity,
                                          itemid,
                                          user.uid,
                                          orderStatus,
                                          productImage);
                                      /* -------------------------------------------------------------------------- */
                                      /*                                      .                                     */
                                      /* -------------------------------------------------------------------------- */
                                      Get.toNamed(BottomNavigationBars.id);
                                    },
                                    child: Text('Ok'),
                                  )
                                ],
                              ));
                    },
                  ),
                  /* -------------------------------------------------------------------------- */
                  /*                             Buy Now Button End                             */
                  /* -------------------------------------------------------------------------- */
                ],
              ),
            ),
          );
        });
  }
}
