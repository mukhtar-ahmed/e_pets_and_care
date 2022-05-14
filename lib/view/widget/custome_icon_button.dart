import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeIconButton extends StatelessWidget {
  const CustomeIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.borderColor,
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color borderColor;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: buttonColor,
          border: Border.all(color: borderColor)),
      child: TextButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Continue with',
              style: TextStyle(
                color: textColor,
                fontFamily: 'EncodeSans Medium',
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              width: 4.sp,
            ),
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontFamily: 'EncodeSans Medium',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
