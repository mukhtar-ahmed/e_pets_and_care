import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    Key? key,
    required this.validate,
    this.labelText,
    this.textController,
    required this.isObscure,
    required this.defaultControllerText,
  }) : super(key: key);
  final String? Function(String?) validate;
  final TextEditingController? textController;
  final bool isObscure;
  final String? labelText;
  final String defaultControllerText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: TextFormField(
        controller: textController?..text = defaultControllerText,

        obscureText: isObscure,

        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          labelText: labelText,
          errorStyle: const TextStyle(fontSize: 9, height: 0.3),
        ),
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        validator: validate,
      ),
    );
  }
}
