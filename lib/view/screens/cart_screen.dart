import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:e_pets_and_care/Controller/cart_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:e_pets_and_care/view/screens/checkout_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  static const String id = '/cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------------------------------------------------- */
      /*                                   AppBar                                   */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        shadowColor: kPrimaryColor,
        backgroundColor: kWhiteColor,
        title: Text(
          'Shopping Bag',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      /* -------------------------------------------------------------------------- */
      /*                                    Body                                    */
      /* -------------------------------------------------------------------------- */
      body: GetBuilder<CartScreenController>(
          init: CartScreenController(),
          builder: (cartScreenController) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SizedBox(
                    child: StreamBuilder<List<CartModel>>(
                        stream: cartScreenController.readCart(),
                        builder: (context, snapShort) {
                          if (snapShort.hasError) {
                            return const Text('Some Thing Wrong');
                          } else if (snapShort.hasData) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 15.h,
                                ),
                                snapShort.data!.isEmpty
                                    ? SizedBox(
                                        height: 700.h,
                                        child: Center(
                                          child: Text(
                                            'Cart is Empty',
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        '${snapShort.data!.length} Items in cart',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w900),
                                      ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                GridView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 0,
                                            crossAxisCount: 1,
                                            mainAxisExtent: 150),
                                    itemCount: snapShort.data!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      cartScreenController.quantity.add(
                                          snapShort.data![index].quantity!);

                                      cartScreenController.productTotalPrice
                                          .add(snapShort
                                                  .data![index].productPrice! *
                                              snapShort.data![index].quantity!);

                                      /* --------------------------- each product price --------------------------- */
                                      // int totalCountPrice = snapShort
                                      //             .data![index].quantity! !=
                                      //         0
                                      //     ? snapShort.data![index].productPrice! *
                                      //         snapShort.data![index].quantity!
                                      //     : snapShort.data![index].productPrice!;

                                      // cartScreenController.price
                                      //     .add(totalCountPrice);
                                      // cartScreenController.updateBill;
                                      // cartScreenController.updateQuantity(
                                      //     snapShort.data![index].quantity!);
                                      return Column(
                                        children: [
                                          Dismissible(
                                            key: UniqueKey(),
                                            onDismissed: (direction) {
                                              cartScreenController
                                                  .deleteContainer(
                                                      snapShort.data![index]);
                                            },
                                            direction:
                                                DismissDirection.endToStart,
                                            background: Container(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 100.sp,
                                              ),
                                            ),
                                            /* -------------------------------------------------------------------------- */
                                            /*                            Cart Container Start                            */
                                            /* -------------------------------------------------------------------------- */
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                  border: Border.all()),
                                              height: 150.h,
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  /* ------------------------------ Product Image ----------------------------- */
                                                  ClipRRect(
                                                    child: Container(
                                                      width: 100.w,
                                                      height: 150.h,
                                                      child: Image(
                                                        image: NetworkImage(
                                                            snapShort
                                                                .data![index]
                                                                .imageUrl!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(10.r),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      /* ------------------------------ Product Name ------------------------------ */
                                                      SizedBox(
                                                        width: 180.w,
                                                        child: Text(
                                                          snapShort.data![index]
                                                              .productName!,
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      /* ------------------------------ Product Price ----------------------------- */
                                                      Text(
                                                        'RS ${snapShort.data![index].productPrice!}',
                                                        style: TextStyle(
                                                            fontSize: 20.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      /* ------------------------------- Swipe Text ------------------------------- */
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.notifications,
                                                            size: 10.sp,
                                                            color: Colors.red,
                                                          ),
                                                          Text(
                                                            'Swipe to remove',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize:
                                                                    10.sp),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  /* -------------------------------------------------------------------------- */
                                                  /*                                  Quantity                                  */
                                                  /* -------------------------------------------------------------------------- */
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartScreenController
                                                              .updateonPressedCart(
                                                                  snapShort
                                                                          .data![
                                                                      index]);
                                                          cartScreenController
                                                              .increaseQuantity(
                                                                  index,
                                                                  snapShort
                                                                      .data![
                                                                          index]
                                                                      .productId!);
                                                        },
                                                        child: Container(
                                                          height: 40.h,
                                                          width: 40.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: cartScreenController
                                                                        .increasePressed &&
                                                                    cartScreenController
                                                                            .onPressedCart ==
                                                                        snapShort
                                                                            .data![index]
                                                                            .productName
                                                                ? kPrimaryColor
                                                                : kWhiteColor,
                                                            border:
                                                                Border.all(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 30.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        cartScreenController
                                                            .quantity[index]
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 30.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartScreenController
                                                              .updateonPressedCart(
                                                                  snapShort
                                                                          .data![
                                                                      index]);
                                                          cartScreenController
                                                              .decreaseQuantity(
                                                                  index,
                                                                  snapShort
                                                                      .data![
                                                                          index]
                                                                      .productId!);
                                                        },
                                                        child: Container(
                                                          height: 40.h,
                                                          width: 40.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            border:
                                                                Border.all(),
                                                            color: cartScreenController
                                                                        .decreasePressed &&
                                                                    cartScreenController
                                                                            .onPressedCart ==
                                                                        snapShort
                                                                            .data![index]
                                                                            .productName
                                                                ? kPrimaryColor
                                                                : kWhiteColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                          child: Icon(
                                                            Icons.remove,
                                                            size: 30.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                /* --------------------------- Proceed To Checkout -------------------------- */
                                CustomeButton(
                                  buttonColor: kPrimaryColor,
                                  fontColor: kWhiteColor,
                                  buttonText: 'Proceed To Checkout',
                                  horPadding: 5,
                                  onPressed: () {
                                    // print(
                                    //     cartScreenController.productTotalPrice);
                                    int a =
                                        cartScreenController.totalBagPrice();
                                    print("mukhatr ${a}");
                                    Get.toNamed(CheckoutScreen.id,
                                        arguments: a);
                                  },
                                ),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            );
                          } else {
                            return const Center(child: CircleAvatar());
                          }
                        }),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
