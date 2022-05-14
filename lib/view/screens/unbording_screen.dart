import 'package:e_pets_and_care/Controller/unbording_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/signin_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class UnbordingScreen extends StatelessWidget {
  static const String id = '/unbording_screen';

  // ignore: prefer_const_constructors_in_immutables
  UnbordingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SizeXGet().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: 812.h,
            width: 375.w,
            child: GetBuilder<UnbordingController>(
                init: UnbordingController(),
                builder: (unbordingController) {
                  return PageView.builder(
                      itemCount: unbordingController.contents.length,
                      controller: unbordingController.controller,
                      onPageChanged: unbordingController.currentIndex,
                      itemBuilder: (_, i) {
                        return Column(
                          children: [
                            /* --------------------------------- SignIn --------------------------------- */
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(SignInScreen.id);
                                  },
                                  child: Text(
                                    'Sign In',
                                    style: kSignInTextStyle,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                            ),
                            /* ---------------------------------- Image --------------------------------- */
                            SizedBox(
                              width: 378.w,
                              height: 375.h,
                              child: Image(
                                  image: AssetImage(
                                      unbordingController.contents[i].image!)),
                            ),
                            /* -------------------------------- Indicator ------------------------------- */
                            AnimatedSmoothIndicator(
                              activeIndex: i,
                              count: 3,
                              effect: const ExpandingDotsEffect(
                                  activeDotColor: Colors.orange,
                                  dotHeight: 10,
                                  dotWidth: 20),
                            ),
                            SizedBox(
                              height: 52.h,
                            ),
                            unbordingController.contents[i].title!,
                            SizedBox(
                              height: 12.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 19.w),
                              child: SizedBox(
                                height: 50.h,
                                child: Text(
                                  unbordingController.contents[i].discription!,
                                  style: TextStyle(fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            /* --------------------------------- Button --------------------------------- */
                            CustomeButton(
                              buttonColor: kPrimaryColor,
                              fontColor: Colors.white,
                              buttonText:
                                  unbordingController.contents[i].buttonText!,
                              horPadding: 57,
                              onPressed: unbordingController.forwardAct,
                            ),
                            SizedBox(
                              height: 60.h,
                            ),
                            Row(
                              children: [
                                SizedBox(width: 93.w),
                                const Expanded(
                                  child: Divider(
                                    thickness: 1,
                                  ),
                                ),
                                SizedBox(width: 93.w),
                              ],
                            ),
                          ],
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }
}
