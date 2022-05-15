import 'package:e_pets_and_care/Admin/PetCategoryManagement/Controller/pet_category_screen_controller.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/pet_category.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddPetCategoryScreen extends StatelessWidget {
  const AddPetCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<PetCategoryScreenController>(
          init: PetCategoryScreenController(),
          builder: (petScreenController) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(PetCategory.id);
              },
              child: Container(
                width: 150.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16.sp,
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'Add Pet Category',
                      style: TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
