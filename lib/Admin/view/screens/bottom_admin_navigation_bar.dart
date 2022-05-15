import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_pets_and_care/Admin/Controller/bottom_admin_navigation_bar_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomAdminNavigationBar extends StatelessWidget {
  static const String id = '/bottom_admin_navigation_bar';
  const BottomAdminNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomAdminNavigationBarController>(
        init: BottomAdminNavigationBarController(),
        builder: (bottomAdminNavigationBarController) {
          return ClipRect(
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar: CurvedNavigationBar(
                buttonBackgroundColor: Colors.purple,
                color: kPrimaryColor,
                backgroundColor: Colors.transparent,
                key: bottomAdminNavigationBarController.bottomNavigationKey,
                height: 50.h,
                items: bottomAdminNavigationBarController.item,
                index: bottomAdminNavigationBarController.index,
                onTap: (index) {
                  bottomAdminNavigationBarController.updateindex(index);
                },
              ),
              body: Container(
                child: bottomAdminNavigationBarController
                    .screens[bottomAdminNavigationBarController.index],
              ),
            ),
          );
        });
  }
}
