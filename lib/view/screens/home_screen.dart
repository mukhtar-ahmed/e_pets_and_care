import 'package:e_pets_and_care/Controller/home_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/product_display_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeScreenController = Get.put(HomeScreenController());
    // ignore: prefer_const_constructors
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text('Location'),
                  const CircleAvatar(
                    child: Text('k'),
                  )
                ],
              ),
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            /* -------------------------------------------------------------------------- */
            /*                                Main Category                               */
            /* -------------------------------------------------------------------------- */
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: SizedBox(
                height: 60.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeScreenController.categoryName.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Text(homeScreenController.categoryName[index]
                                ['name'])),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            /* ------------------------------ Category Text ----------------------------- */
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.sp),
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
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeScreenController.petsCategory.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            /* ------------------------------ Category Icon ----------------------------- */
                            child: Image.asset(
                              homeScreenController.petsCategory[index]
                                  ['IconPath'],
                              height: 50,
                              width: 50,
                            ),
                          ),
                          /* ------------------------------ Category Name ----------------------------- */
                          Text(homeScreenController.petsCategory[index]['name'])
                        ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            /* ------------------------------------ . ----------------------------------- */

            SizedBox(
              child: GridView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      mainAxisExtent: 265),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: SizedBox(
                        height: 265.h,
                        width: 166.w,
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
                                      image: AssetImage('images/cat1.png')),
                                ),
                                Container(
                                  // ignore: prefer_const_constructors
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                  ),
                                  height: 80.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 5.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /* ----------------------------- Name Of Product ---------------------------- */
                                      CustomeTextFieldLabel(
                                        labelText: 'WHITW',
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
                                          Text(
                                            '4.0',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'RS: 50',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Container(
                                            width: 50.w,
                                            height: 28.h,
                                            child:
                                                const Icon(Icons.shopping_cart),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
