import 'package:e_pets_and_care/Admin/Dashboard/Controller/dashboard_controller.dart';
import 'package:e_pets_and_care/Admin/Dashboard/Views/Widget/custome_dashboard_container.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (dashboardController) {
          return Scaffold(
            backgroundColor: kWhiteColor,
            body: SizedBox(
              width: 375.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child: Column(
                  children: [
                    /* -------------------------------------------------------------------------- */
                    /*                                 Total User                                 */
                    /* -------------------------------------------------------------------------- */
                    const CustomeDashboardContainer(
                      width: 375,
                      icon: Icons.person,
                      iconSize: 150,
                      childContainerWidth: 150,
                      countText: '19',
                      counTextSize: 50,
                      countName: 'Total User',
                      countNameSize: 20,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    /* ------------------------- Category & Pet Category ------------------------ */
                    Row(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                  Category                                  */
                        /* -------------------------------------------------------------------------- */
                        CustomeDashboardContainer(
                          width: 160,
                          icon: Icons.menu,
                          iconSize: 50,
                          childContainerWidth: 80,
                          countText:
                              dashboardController.categoryLength.toString(),
                          counTextSize: 25,
                          countName: 'Category',
                          countNameSize: 16,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                                Pet Category                                */
                        /* -------------------------------------------------------------------------- */
                        const CustomeDashboardContainer(
                          width: 160,
                          icon: Icons.pets,
                          iconSize: 50,
                          childContainerWidth: 80,
                          countText: '19',
                          counTextSize: 25,
                          countName: 'Pet Category',
                          countNameSize: 16,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    /* ---------------------------- Food and Medicine --------------------------- */
                    Row(
                      children: [
                        /* -------------------------------------------------------------------------- */
                        /*                                    Food                                    */
                        /* -------------------------------------------------------------------------- */
                        const CustomeDashboardContainer(
                          width: 160,
                          icon: Icons.food_bank,
                          iconSize: 50,
                          childContainerWidth: 80,
                          countText: '19',
                          counTextSize: 25,
                          countName: 'Food',
                          countNameSize: 16,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        /* -------------------------------------------------------------------------- */
                        /*                                  Medicine                                  */
                        /* -------------------------------------------------------------------------- */
                        const CustomeDashboardContainer(
                          width: 160,
                          icon: Icons.medication,
                          iconSize: 50,
                          childContainerWidth: 80,
                          countText: '19',
                          counTextSize: 25,
                          countName: 'Medicine',
                          countNameSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
