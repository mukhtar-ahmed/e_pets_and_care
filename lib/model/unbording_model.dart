import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnbordingModel {
  String? image;
  Widget? title;
  String? discription;
  String? buttonText;
  VoidCallback? onPressed;

  UnbordingModel(
      {this.image,
      this.title,
      this.discription,
      this.buttonText,
      this.onPressed});
}
