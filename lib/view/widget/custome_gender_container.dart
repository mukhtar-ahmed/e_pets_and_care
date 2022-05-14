import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeGenderContainer extends StatelessWidget {
  const CustomeGenderContainer({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.h,
      width: 158.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: color,
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(
            width: 4.w,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
