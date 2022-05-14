import 'package:e_pets_and_care/view/screens/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninScreenController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false;

  /* -------------------------------------------------------------------------- */
  /*                                SignIn Method                               */
  /* -------------------------------------------------------------------------- */
  void signIn({required String email, required String password}) async {
    SigninScreenController signinScreenController =
        Get.put(SigninScreenController());
    if (signinScreenController.formKey.currentState!.validate()) {
      signinScreenController.isLoading = true;
      update();

      await signinScreenController.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Get.snackbar('SignIn', 'SignIn Successfully'),
                Get.toNamed(BottomNavigationBars.id)
              })
          .catchError((e) {
        Get.snackbar('SignIn', 'SignIn UnSuccessfully',
            snackPosition: SnackPosition.BOTTOM);

        signinScreenController.isLoading = false;
        update();
      });
      signinScreenController.isLoading = false;
      update();
    }
  }
}
