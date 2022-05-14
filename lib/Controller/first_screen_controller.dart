import 'dart:async';

import 'package:e_pets_and_care/view/screens/unbording_screen.dart';
import 'package:get/get.dart';

class FirstScreenController extends GetxController {
  @override
  void onInit() {
    Timer(const Duration(seconds: 5), () {
      Get.toNamed(UnbordingScreen.id);
    });
    super.onInit();
  }
}
