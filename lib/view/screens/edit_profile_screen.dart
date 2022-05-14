import 'package:e_pets_and_care/view/screens/bottom_navigation_bar.dart';
import 'package:e_pets_and_care/view/widget/custome_button.dart';
import 'package:e_pets_and_care/view/widget/custome_gender_container.dart';
import 'package:e_pets_and_care/view/widget/custome_text_field_label.dart';
import 'package:e_pets_and_care/view/widget/custome_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = '/edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* -------------------------------------------------------------------------- */
      /*                                AppBar Start                                */
      /* -------------------------------------------------------------------------- */
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
      ),
      /* -------------------------------------------------------------------------- */
      /*                                 App Bar End                                */
      /* -------------------------------------------------------------------------- */
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          height: 670.h,
          width: 335.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                /* ----------------------------- Profile Picture ---------------------------- */
                CircleAvatar(
                  radius: 70.r,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: Stack(children: [
                    // ignore: prefer_const_constructors
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.orange,
                        child: const Icon(
                          CupertinoIcons.camera,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 32.h,
                ),
                /* ----------------------------- Full Name Start ---------------------------- */
                SizedBox(
                  height: 60.h,
                  child: Column(
                    children: [
                      CustomeTextFieldLabel(
                        labelText: 'Full Name',
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomeTextFormField(
                        defaultControllerText: '',
                        isObscure: false,
                        validate: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (value.length < 3) {
                              return "Name should be atleast 3 Character";
                            }
                          } else {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                /* ------------------------------ Full Name End ----------------------------- */
                SizedBox(
                  height: 16.h,
                ),
                /* ------------------------------ Gender Start ------------------------------ */
                SizedBox(
                  height: 60.h,
                  child: Column(
                    children: [
                      CustomeTextFieldLabel(
                        labelText: 'Gender',
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const CustomeGenderContainer(
                            text: 'Male',
                            icon: Icons.male,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 17.w,
                          ),
                          const CustomeGenderContainer(
                              text: 'Female',
                              icon: Icons.female,
                              color: Colors.orange),
                        ],
                      ),
                    ],
                  ),
                ),
                /* ------------------------------- Gender End ------------------------------- */
                SizedBox(
                  height: 16.h,
                ),
                /* ------------------------------- Email Start ------------------------------ */
                SizedBox(
                  height: 60.h,
                  child: Column(
                    children: [
                      CustomeTextFieldLabel(
                        labelText: 'Email',
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomeTextFormField(
                        defaultControllerText: '',
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
                /* -------------------------------- Email End ------------------------------- */
                SizedBox(
                  height: 16.h,
                ),
                /* --------------------------- Phone Number Start --------------------------- */
                SizedBox(
                  height: 60.h,
                  child: Column(
                    children: [
                      CustomeTextFieldLabel(
                        labelText: 'Phone',
                        textAlign: TextAlign.start,
                        fontSized: 14.sp,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomeTextFormField(
                        defaultControllerText: '',
                        isObscure: false,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your Phone Number";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                /* ---------------------------- Phone Number End ---------------------------- */
                SizedBox(
                  height: 24.h,
                ),
                /* ----------------------------- About Seaction ----------------------------- */
                CustomeTextFieldLabel(
                  labelText: 'About',
                  textAlign: TextAlign.start,
                  fontSized: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
                TextFormField(
                  maxLines: 3,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 17.h,
                ),
                /* --------------------------- Get Started Button --------------------------- */
                CustomeButton(
                  buttonColor: Colors.orange,
                  fontColor: Colors.white,
                  buttonText: 'Sava',
                  horPadding: 15,
                  onPressed: () {
                    Get.toNamed(BottomNavigationBars.id);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
