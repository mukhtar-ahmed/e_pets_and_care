import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Container(
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
                'Add Category',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
