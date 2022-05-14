import 'package:e_pets_and_care/view/screens/bottom_navigation_bar.dart';
import 'package:e_pets_and_care/view/screens/edit_profile_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_gender_container.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------------------------------------------------- */
      /*                                AppBar Start                                */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w),
            child: GestureDetector(
              onTap: () => Get.toNamed(EditProfileScreen.id),
              child: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      /* -------------------------------------------------------------------------- */
      /*                                 App Bar End                                */
      /* -------------------------------------------------------------------------- */
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          height: 670.h,
          width: 335.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                /* ----------------------------- Profile Picture ---------------------------- */
                CircleAvatar(
                  radius: 70.r,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Stack(children: [
                    // ignore: prefer_const_constructors
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.orange,
                        child: const Icon(
                          CupertinoIcons.camera,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 28.h,
                ),
                /* ---------------------------------- Name ---------------------------------- */
                CustomeTextFieldLabel(
                  labelText: 'Mukhtar Ahmed',
                  textAlign: TextAlign.center,
                  fontSized: 30.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
                SizedBox(
                  height: 10.h,
                ),
                /* ---------------------------------- Email --------------------------------- */
                CustomeTextFieldLabel(
                  labelText: 'mukhtar@gmail.com',
                  textAlign: TextAlign.center,
                  fontSized: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                /* ---------------------------------- Phone --------------------------------- */
                CustomeTextFieldLabel(
                  labelText: '+923357708041',
                  textAlign: TextAlign.center,
                  fontSized: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: 10.h,
                ),
                /* --------------------------------- Gender --------------------------------- */
                const CustomeGenderContainer(
                  text: 'Male',
                  icon: Icons.male,
                  color: Colors.orange,
                ),
                SizedBox(
                  height: 20.h,
                ),
                /* -------------------------------- About me -------------------------------- */
                CustomeTextFieldLabel(
                  labelText: 'About',
                  textAlign: TextAlign.start,
                  fontSized: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.r),
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r)),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: CustomeTextFieldLabel(
                      labelText:
                          'Software Engineer with a demonstrated history of working in the information technology and passionate about problem-solving using Data and Programming Language.. Skilled in Flutter and Python.',
                      textAlign: TextAlign.start,
                      fontSized: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
