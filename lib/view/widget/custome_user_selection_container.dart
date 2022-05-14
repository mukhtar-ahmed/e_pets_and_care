import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomeUserSelectionContainer extends StatelessWidget {
  const CustomeUserSelectionContainer({
    Key? key,
    required this.text,
    required this.onPressed, required this.icon,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r)),
        height: 135.h,
        width: 135.w,
        child: Column(
          children: [
            icon,
            Text(
              text,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}
