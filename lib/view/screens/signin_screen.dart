import 'package:e_pets_and_care/Controller/signin_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/forgot_password_screen.dart';
import 'package:e_pets_and_care/view/screens/registration_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  static const String id = '/signin_screen';
  // ignore: prefer_const_constructors_in_immutables
  SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------------------------------------------------- */
      /*                                AppBar Start                                */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      /* -------------------------------------------------------------------------- */
      /*                                 AppBar End                                 */
      /* -------------------------------------------------------------------------- */
      /* -------------------------------------------------------------------------- */
      /*                                 Body Start                                 */
      /* -------------------------------------------------------------------------- */
      body: GetBuilder<SigninScreenController>(
          init: SigninScreenController(),
          builder: (signinScreenController) {
            return signinScreenController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  )
                : SafeArea(
                    child: Stack(
                      children: [
                        /* ---------------------------- Background start ---------------------------- */
                        Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                color: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                                flex: 2, child: Container(color: kWhiteColor)),
                          ],
                        ),
                        /* ----------------------------- Background end ----------------------------- */
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                SizedBox(
                                  height: 12.h,
                                ),
                                /* --------------------------- Heading Text Start --------------------------- */
                                const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      fontSize: 34.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                /* ---------------------------- Heading Text End ---------------------------- */
                                SizedBox(
                                  height: 24.h,
                                ),
                                /* -------------------------------------------------------------------------- */
                                /*                              SignIn Form Start                             */
                                /* -------------------------------------------------------------------------- */
                                Form(
                                  key: signinScreenController.formKey,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      height: 280.h,
                                      width: 335.w,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        color: Colors.white,
                                        elevation: 4.0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 24.h, horizontal: 20.w),
                                          child: Column(
                                            children: [
                                              Column(
                                                children: [
                                                  /* ------------------------------- Email Start ------------------------------ */
                                                  SizedBox(
                                                    height: 60.h,
                                                    child: Column(
                                                      children: [
                                                        CustomeTextFieldLabel(
                                                          labelText: 'Email',
                                                          textAlign:
                                                              TextAlign.start,
                                                          color: kGreyColor,
                                                          fontSized: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          height: 6.h,
                                                        ),
                                                        CustomeTextFormField(
                                                          defaultControllerText:
                                                              '',
                                                          textController:
                                                              signinScreenController
                                                                  .emailController,
                                                          isObscure: false,
                                                          validate: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return "Please enter your email";
                                                            }
                                                            if (!RegExp(
                                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                .hasMatch(
                                                                    value)) {
                                                              return 'Invalid Email';
                                                            }

                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /* -------------------------------- Email End ------------------------------- */
                                                  /* ----------------------------- Password Start ----------------------------- */
                                                  SizedBox(
                                                    height: 60.h,
                                                    child: Column(
                                                      children: [
                                                        CustomeTextFieldLabel(
                                                          labelText: 'Password',
                                                          color: kGreyColor,
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontSized: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          height: 6.h,
                                                        ),
                                                        CustomeTextFormField(
                                                          defaultControllerText:
                                                              '',
                                                          textController:
                                                              signinScreenController
                                                                  .passwordController,
                                                          isObscure: true,
                                                          validate: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Password is required';
                                                            }
                                                            if (value.length <
                                                                6) {
                                                              return 'Password Must be atleast 6 Character';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /* ------------------------------ Password End ------------------------------ */
                                                  SizedBox(
                                                    height: 12.h,
                                                  ),
                                                  /* -------------------------- Forget Password Start ------------------------- */
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            ForgotPasswordScreen
                                                                .id);
                                                      },
                                                      child: Text(
                                                        'Do not remember the password?',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                kPrimaryColor),
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ),
                                                  ),
                                                  /* --------------------------- Forget Password End -------------------------- */
                                                  SizedBox(
                                                    height: 24.h,
                                                  ),
                                                  /* -------------------------- Sign In button Start -------------------------- */
                                                  CustomeButton(
                                                    buttonColor: kPrimaryColor,
                                                    fontColor: kWhiteColor,
                                                    buttonText: 'Sign In',
                                                    horPadding: 5,
                                                    onPressed: () {
                                                      signinScreenController.signIn(
                                                          email:
                                                              signinScreenController
                                                                  .emailController
                                                                  .text,
                                                          password:
                                                              signinScreenController
                                                                  .passwordController
                                                                  .text);
                                                    },
                                                  ),
                                                  /* --------------------------- Sign In Button End --------------------------- */
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /* -------------------------------------------------------------------------- */
                                /*                               SignIn Form End                              */
                                /* -------------------------------------------------------------------------- */
                                SizedBox(
                                  height: 61.h,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    'or continue with',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                // ignore: prefer_const_literals_to_create_immutables
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    /* ----------------------- FaceBook Logo Button Start ----------------------- */
                                    const Image(
                                      image: AssetImage('images/fb.png'),
                                    ),
                                    /* ------------------------ FaceBook Logo Button End ------------------------ */
                                    SizedBox(
                                      width: 55.w,
                                    ),
                                    /* ------------------------- Gmail Logo Button Start ------------------------ */
                                    const Image(
                                      image: AssetImage('images/gmail.png'),
                                    ),
                                    /* -------------------------- Gmail Logo Button End ------------------------- */
                                  ],
                                ),
                                SizedBox(
                                  height: 104.h,
                                ),
                                /* --------------------------- Registration Start --------------------------- */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have account yet? ",
                                      style: TextStyle(
                                        fontFamily: 'EncodeSans Light',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RegistrationScreen.id);
                                      },
                                      child: Text(
                                        "Registration ",
                                        style: TextStyle(
                                            fontFamily: 'EncodeSans Bold',
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700,
                                            color: kPrimaryColor),
                                      ),
                                    )
                                  ],
                                )
                                /* ---------------------------- Registration End ---------------------------- */
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
      /* -------------------------------------------------------------------------- */
      /*                                  Body End                                  */
      /* -------------------------------------------------------------------------- */
    );
  }
}
