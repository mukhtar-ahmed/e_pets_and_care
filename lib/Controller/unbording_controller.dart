import 'package:e_pets_and_care/model/unbording_model.dart';
import 'package:e_pets_and_care/view/screens/registration_fb_google_screen.dart';
import 'package:e_pets_and_care/view/screens/user_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UnbordingController extends GetxController {
  var currentIndex = 0.obs;
  bool get isLastPage => currentIndex.value == contents.length - 1;
  var controller = PageController();

  forwardAct() {
    // ignore: curly_braces_in_flow_control_structures
    if (isLastPage) {
      Get.toNamed(UserSelectionScreen.id);
    } else {
      controller.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
  //UnbordingModel unbordingContent = UnbordingModel();

  void setIndex(int index) {
    currentIndex.value = index;
    update();
  }

  List<UnbordingModel> contents = [
    UnbordingModel(
        title: Text(
          'E-Pets & Care',
          style: TextStyle(
            fontSize: 30.sp,
            fontFamily: 'Pacifico Regular',
            fontWeight: FontWeight.w900,
          ),
        ),
        image: 'images/WelcomeScreen1.png',
        discription:
            "All types of services for your pet in one place, instantly searchable.",
        buttonText: 'Next',
        onPressed: () {}),
    UnbordingModel(
        title: Text(
          'High-quality Products',
          style: TextStyle(
            fontSize: 30.sp,
            fontFamily: 'Pacifico Regular',
            fontWeight: FontWeight.w900,
          ),
        ),
        image: 'images/WelcomeScreen2.png',
        discription: "Here you can find the best products for your pet.",
        buttonText: 'Next'),
    UnbordingModel(
        // ignore: prefer_const_constructors
        title: Text(
          'Reliable reviews',
          style: TextStyle(
            fontSize: 30.sp,
            fontFamily: 'Pacifico Regular',
            fontWeight: FontWeight.w900,
          ),
        ),
        image: 'images/WelcomeScreen3.png',
        discription:
            "A review can be left only by a user who used the service. ",
        buttonText: 'Get started'),
  ];
}
