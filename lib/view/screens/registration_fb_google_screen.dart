import 'package:e_pets_and_care/Controller/registration_fb_google_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/registration_screen.dart';
import 'package:e_pets_and_care/view/screens/signin_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RegistrationFbGoogleScreen extends StatelessWidget {
  static const String id = '/registration_fb_google_screen';
  // ignore: prefer_const_constructors_in_immutables
  RegistrationFbGoogleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kPrimaryColor,
      /* -------------------------------------------------------------------------- */
      /*                                 BODY START                                 */
      /* -------------------------------------------------------------------------- */
      body: GetBuilder<RegistrationFbGoogleScreenController>(
          init: RegistrationFbGoogleScreenController(),
          builder: (registrationFbGoogleScreenController) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 128.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                             HEADING TEXT START                             */
                    /* -------------------------------------------------------------------------- */
                    Text(
                      'Welcome to',
                      style: TextStyle(
                          fontFamily: 'EncodeSans Bold',
                          color: Colors.white,
                          fontSize: 44.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        Text(
                          'to',
                          style: TextStyle(
                              fontFamily: 'EncodeSans Bold',
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'E-Pets & Care',
                          style: TextStyle(
                              color: const Color(0xFF8a2be2),
                              fontFamily: 'Pacifico Regular',
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                              HEADING TEXT END                              */
                    /* -------------------------------------------------------------------------- */

                    SizedBox(
                      height: 48.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                                    Text                                    */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Caring for your pets has ',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: kWhiteColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'never been so easy!',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: kWhiteColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            'With E-Pets & Care you can buy ',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: kWhiteColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            'Pets , Food and Medicine',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: kWhiteColor),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 48.h,
                          ),
                        ],
                      ),
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                             EMAIL BUTTON START                             */
                    /* -------------------------------------------------------------------------- */
                    CustomeIconButton(
                      icon: FontAwesomeIcons.at,
                      text: 'Email',
                      borderColor: kWhiteColor,
                      buttonColor: kPrimaryColor,
                      textColor: kWhiteColor,
                      onPressed: () {
                        Get.toNamed(RegistrationScreen.id);
                      },
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                              EMAIL BUTTON END                              */
                    /* -------------------------------------------------------------------------- */
                    SizedBox(
                      height: 80.h,
                    ),
                    /* -------------------------------------------------------------------------- */
                    /*                             FOR SIGN IN (START)                            */
                    /* -------------------------------------------------------------------------- */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                              fontFamily: 'EncodeSans Light',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        /* -------------------------- SIGN IN GESTUREDECTOR ------------------------- */
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(SignInScreen.id);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontFamily: 'EncodeSans Bold',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF8a2be2)),
                          ),
                        )
                      ],
                    )
                    /* -------------------------------------------------------------------------- */
                    /*                              FOR SIGN IN (END)                             */
                    /* -------------------------------------------------------------------------- */
                  ],
                ),
              ),
            );
          }),
    )
        /* -------------------------------------------------------------------------- */
        /*                                  BODY END                                  */
        /* -------------------------------------------------------------------------- */
        );
  }
}
