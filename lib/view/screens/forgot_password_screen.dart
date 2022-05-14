import 'package:e_pets_and_care/Controller/forgot_password_controller.dart';
import 'package:e_pets_and_care/Controller/signin_screen_controller.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String id = '/forgot_password_screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* ------------------------------ AppBar Start ------------------------------ */
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      /* ------------------------------- AppBar End ------------------------------- */
      /* -------------------------------------------------------------------------- */
      /*                                 Body Start                                 */
      /* -------------------------------------------------------------------------- */
      body: GetBuilder<ForgotPasswordController>(
          init: ForgotPasswordController(),
          builder: (forgotPasswordController) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* ---------------------------------- Text ---------------------------------- */
                Text(
                  'Receive an email to reset your password',
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                /* ------------------------------- Email Start ------------------------------ */
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
                  child: SizedBox(
                    height: 60.h,
                    child: Column(
                      children: [
                        CustomeTextFieldLabel(
                          labelText: 'Email',
                          color: Colors.grey,
                          textAlign: TextAlign.start,
                          fontSized: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        CustomeTextFormField(
                          defaultControllerText: '',
                          textController:
                              forgotPasswordController.emailController,
                          isObscure: false,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Invalid Email';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                /* -------------------------------- Email End ------------------------------- */
                /* -------------------------- Sign In button Start -------------------------- */
                CustomeButton(
                    buttonColor: Colors.orange,
                    fontColor: Colors.white,
                    buttonText: 'Reset Password',
                    horPadding: 20,
                    onPressed: forgotPasswordController.verifyEmail),
                /* --------------------------- Sign In Button End --------------------------- */
              ],
            ));
          }),
      /* -------------------------------------------------------------------------- */
      /*                                  Body End                                  */
      /* -------------------------------------------------------------------------- */
    );
  }
}
