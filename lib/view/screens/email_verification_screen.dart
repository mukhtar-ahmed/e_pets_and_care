import 'package:e_pets_and_care/Controller/email_verification_controller.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EmailVerificationScreen extends StatelessWidget {
  static const String id = '/email_verification_screen';
  EmailVerificationController emailVerificationController =
      Get.put(EmailVerificationController());
  // ignore: prefer_const_constructors_in_immutables
  EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (emailVerificationController.isEmailVarified) {
      return const HomeScreen();
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("Varify Email Page")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'A varification Email has been sent to your email.',
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              /* -------------------------------------------------------------------------- */
              /*                             Resent Email Button                            */
              /* -------------------------------------------------------------------------- */
              CustomeButton(
                buttonColor: Colors.orange,
                fontColor: Colors.white,
                buttonText: 'Resent Email',
                horPadding: 50,
                onPressed: emailVerificationController.sendVerificationEmail,
              ),
              SizedBox(
                height: 20.h,
              ),
              /* -------------------------------------------------------------------------- */
              /*                                Cancel Button                               */
              /* -------------------------------------------------------------------------- */
              CustomeButton(
                buttonColor: Colors.orange,
                fontColor: Colors.white,
                buttonText: 'Cancel',
                horPadding: 50,
                onPressed: emailVerificationController.cancelButton,
              ),
            ],
          ),
        ),
      );
    }
  }
}
