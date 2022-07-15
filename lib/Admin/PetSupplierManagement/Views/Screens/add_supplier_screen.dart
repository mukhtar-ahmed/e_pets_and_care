import 'package:e_pets_and_care/Admin/PetSupplierManagement/Controller/supplier_controller.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/supplier.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddSupplierScreen extends StatelessWidget {
  static const String id = '/add_supplier_screen';
  const AddSupplierScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GetBuilder<SupplierController>(
          init: SupplierController(),
          builder: (supplierController) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(Supplier.id);
                
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
                      'Add Pet Supplier',
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
