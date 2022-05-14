import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Get.snackbar(
        'Password Reset',
        'Password Reset Email Send',
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Password Reset',
        e.message.toString(),
      );
    }
  }
}
