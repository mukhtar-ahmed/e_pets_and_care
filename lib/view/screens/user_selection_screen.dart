import 'package:e_pets_and_care/Admin/view/screens/bottom_admin_navigation_bar.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/registration_fb_google_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_user_selection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserSelectionScreen extends StatelessWidget {
  static const String id = '/user_selection_screen';
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomeUserSelectionContainer(
                text: 'Admin',
                icon: Icon(
                  Icons.person,
                  size: 100.r,
                ),
                onPressed: () => Get.toNamed(BottomAdminNavigationBar.id),
              ),
              SizedBox(
                height: 50.h,
              ),
              CustomeUserSelectionContainer(
                text: 'User',
                icon: Icon(
                  Icons.person,
                  size: 100.r,
                ),
                onPressed: () => Get.toNamed(RegistrationFbGoogleScreen.id),
              ),
            ],
          ),
        ));
  }
}
