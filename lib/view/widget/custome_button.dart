import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeButton extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomeButton({
    Key? key,
    required this.buttonColor,
    required this.fontColor,
    required this.buttonText,
    required this.onPressed,
    required this.horPadding,
  }) : super(key: key);
  final Color buttonColor;
  final Color fontColor;
  final String buttonText;
  final VoidCallback onPressed;
  final int horPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horPadding.w),
      child: Container(
        width: double.infinity,
        height: 46.h,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
                color: fontColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'EncodeSans Bold'),
          ),
        ),
      ),
    );
  }
}
