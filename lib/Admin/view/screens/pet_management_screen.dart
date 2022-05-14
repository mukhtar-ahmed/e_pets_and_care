import 'package:e_pets_and_care/Admin/view/screens/add_pet_screen.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/widget/custome_user_selection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PetManagementScreen extends StatefulWidget {
  const PetManagementScreen({Key? key}) : super(key: key);

  @override
  State<PetManagementScreen> createState() => _PetManagementScreenState();
}

class _PetManagementScreenState extends State<PetManagementScreen> {
  var sub_pet_module = ['Add Pet', 'Update Pet', 'Search Pet', 'Delete Pet'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(bottom: 10.h, top: 30.h, left: 10.w, right: 10.w),
        child: Center(
          child: Container(
            height: 812.h,
            width: 375.w,
            child: Column(
              children: [
                Text(
                  'Pet Management',
                  style: TextStyle(
                      fontSize: 40.sp,
                      fontFamily: 'Pacifico Regular',
                      fontWeight: FontWeight.w900,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Image.asset(
                  'images/pet-cat1.png',
                  height: 150.h,
                ),
                SizedBox(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      // ignore: prefer_const_constructors
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 50.h,
                          crossAxisSpacing: 20.w,
                          crossAxisCount: 2,
                          mainAxisExtent: 150),
                      itemBuilder: (context, index) {
                        return CustomeUserSelectionContainer(
                          icon: Icon(
                            Icons.pets,
                            size: 100.r,
                          ),
                          text: sub_pet_module[index],
                          onPressed: () => Get.toNamed(AddPetScreen.id),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
