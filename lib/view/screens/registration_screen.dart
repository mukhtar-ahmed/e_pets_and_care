import 'package:e_pets_and_care/Controller/registration_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/signin_screen.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = '/registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------------------------------------------------- */
      /*                                AppBar Start                                */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: kWhiteColor,
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
      body: GetBuilder<RegistrationScreenController>(
          //Wrap with Controller
          init: RegistrationScreenController(),
          builder: (registrationScreenController) {
            /* --------------------- CircularProgressIndicator Start -------------------- */
            return registrationScreenController.loading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                /* ---------------------- CircularProgressIndicator End --------------------- */
                : SafeArea(
                    /* -------------------------------------------------------------------------- */
                    /*                                Background Start                            */
                    /* -------------------------------------------------------------------------- */
                    child: Stack(
                      children: [
                        //background start
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
                        /* -------------------------------------------------------------------------- */
                        /*                               Background end                               */
                        /* -------------------------------------------------------------------------- */
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
                                /* ------------------------------ Heading Text ------------------------------ */
                                const Text(
                                  'Registration',
                                  style: TextStyle(
                                      fontSize: 34.0,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 24.h,
                                ),
                                /* -------------------------------------------------------------------------- */
                                /*                           Registration Form Start                          */
                                /* -------------------------------------------------------------------------- */
                                Form(
                                  key: registrationScreenController.formKey,
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                      height: 406.h,
                                      width: 335.w,
                                      /* ------------------------------- Card Start ------------------------------- */
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
                                                  /* ----------------------------- Full Name Start ---------------------------- */
                                                  SizedBox(
                                                    height: 60.h,
                                                    child: Column(
                                                      children: [
                                                        CustomeTextFieldLabel(
                                                          labelText:
                                                              'Full Name',
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontSized: 14.sp,
                                                          color: kGreyColor,
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
                                                              registrationScreenController
                                                                  .nameController,
                                                          isObscure: false,
                                                          validate: (value) {
                                                            if (value != null &&
                                                                value
                                                                    .isNotEmpty) {
                                                              if (value.length <
                                                                  3) {
                                                                return "Name should be atleast 3 Character";
                                                              }
                                                            } else {
                                                              return 'Name cannot be empty';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  /* ------------------------------ Full Name End ----------------------------- */
                                                  /* ------------------------------- Email Start ------------------------------ */
                                                  SizedBox(
                                                    height: 60.h,
                                                    child: Column(
                                                      children: [
                                                        CustomeTextFieldLabel(
                                                          labelText: 'Email',
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontSized: 14.sp,
                                                          color: kGreyColor,
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
                                                              registrationScreenController
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
                                                          textAlign:
                                                              TextAlign.start,
                                                          fontSized: 14.sp,
                                                          color: kGreyColor,
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
                                                              registrationScreenController
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
                                                  /* ------------------------- Confirm Password Start ------------------------- */
                                                  SizedBox(
                                                    height: 60.h,
                                                    child: Column(
                                                      children: [
                                                        CustomeTextFieldLabel(
                                                          labelText:
                                                              'Confirm Password',
                                                          fontSized: 14.sp,
                                                          textAlign:
                                                              TextAlign.start,
                                                          color: kGreyColor,
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
                                                              registrationScreenController
                                                                  .confirmPasswordController,
                                                          isObscure: true,
                                                          validate: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Password is required';
                                                            }
                                                            if (registrationScreenController
                                                                    .passwordController
                                                                    .text !=
                                                                value) {
                                                              return 'Password not match';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  /* -------------------------- Confirm Password End -------------------------- */
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                  /* -------------------------- Register Button Start ------------------------- */
                                                  CustomeButton(
                                                    buttonColor: kPrimaryColor,
                                                    fontColor: kWhiteColor,
                                                    buttonText: 'Register',
                                                    horPadding: 5,
                                                    onPressed: () {
                                                      registrationScreenController.signUp(
                                                          email:
                                                              registrationScreenController
                                                                  .emailController
                                                                  .text,
                                                          password:
                                                              registrationScreenController
                                                                  .passwordController
                                                                  .text);
                                                    },
                                                  ),
                                                  /* --------------------------- Register Button End -------------------------- */
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      /* -------------------------------- Card End -------------------------------- */
                                    ),
                                  ),
                                ),
                                /* -------------------------------------------------------------------------- */
                                /*                            Registration Form End                           */
                                /* -------------------------------------------------------------------------- */
                                SizedBox(
                                  height: 50.h,
                                ),
                                /* ------------------------------ Sign In Start ----------------------------- */
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        fontFamily: 'EncodeSans Light',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
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
                                            color: Colors.orange),
                                      ),
                                    )
                                  ],
                                )
                                /* ------------------------------- Sign In End ------------------------------ */
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
