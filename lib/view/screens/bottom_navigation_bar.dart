import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/cart_screen.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:e_pets_and_care/view/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBars extends StatefulWidget {
  static const String id = '/bottom_navigation_bar';
  const BottomNavigationBars({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  int index = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final item = <Widget>[
    const Icon(
      Icons.person,
      size: 30,
      color: kWhiteColor,
    ),
    const Icon(Icons.home, size: 30, color: kWhiteColor),
    const Icon(Icons.shopping_cart, size: 30, color: kWhiteColor),
  ];
  final screens = const [ProfileScreen(), HomeScreen(), CartScreen()];

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          color: kPrimaryColor,
          backgroundColor: Colors.transparent,
          key: _bottomNavigationKey,
          height: 45.h,
          items: item,
          index: index,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
        body: Container(
          child: screens[index],
        ),
      ),
    );
  }
}
