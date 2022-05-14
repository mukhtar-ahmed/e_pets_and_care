import 'dart:async';

import 'package:e_pets_and_care/Controller/registration_screen_controller.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  bool isEmailVarified = false;
  // ignore: prefer_typing_uninitialized_variables
  var timer;
  bool canResendEmail = false;
  late RegistrationScreenController registrationScreenController;

  @override
  void onInit() {
    isEmailVarified = FirebaseAuth.instance.currentUser!.emailVerified;

    super.onInit();
    if (!isEmailVarified) {
      sendVerificationEmail();
    }
    timer = Timer.periodic(
        const Duration(seconds: 3), (_) => checkedEmailVerified());
  }

  @override
  void onClose() {
    timer?.cancle();
    super.onClose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      canResendEmail = false;
      update();
      await Future.delayed(const Duration(seconds: 5));
      canResendEmail = true;
      update();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future checkedEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isEmailVarified = FirebaseAuth.instance.currentUser!.emailVerified;
    update();
    if (isEmailVarified) {
      Get.toNamed(HomeScreen.id);
      timer?.cancle();
      
    }
  }

  void cancelButton() {
    FirebaseAuth.instance.signOut();
    Get.back();
  }
}
