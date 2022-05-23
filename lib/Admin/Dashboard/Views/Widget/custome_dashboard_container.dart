import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeDashboardContainer extends StatelessWidget {
  const CustomeDashboardContainer({
    Key? key,
    required this.width,
    required this.icon,
    required this.iconSize,
    required this.childContainerWidth,
    this.countText,
    required this.counTextSize,
    required this.countName,
    required this.countNameSize,
  }) : super(key: key);
  final double width;
  final IconData icon;
  final double iconSize;
  final double childContainerWidth;
  final String? countText;
  final double counTextSize;
  final String countName;
  final double countNameSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Center(
            child: Row(
              children: [
                SizedBox(
                    width: childContainerWidth.w,
                    child: Center(
                      child: Icon(
                        icon,
                        size: iconSize.sp,
                      ),
                    )),
                Container(
                  width: childContainerWidth.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        countText!,
                        style: TextStyle(
                            fontSize: counTextSize.sp,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        countName,
                        style: TextStyle(
                            fontSize: countNameSize.sp,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
