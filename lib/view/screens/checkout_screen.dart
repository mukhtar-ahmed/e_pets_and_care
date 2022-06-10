import 'package:e_pets_and_care/Controller/checkout_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  static const String id = '/checkout_screen';
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = Get.arguments;
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
                            stream: checkoutController.readCart(),
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
                ],
              ),
            ),
          );
        });
  }
}
