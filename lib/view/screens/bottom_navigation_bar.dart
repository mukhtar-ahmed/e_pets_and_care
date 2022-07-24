import 'package:badges/badges.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_pets_and_care/Controller/cart_screen_controller.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:e_pets_and_care/view/screens/cart_screen.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:e_pets_and_care/view/screens/order_screen.dart';
import 'package:e_pets_and_care/view/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/checkout_controller.dart';
import '../../Controller/registration_screen_controller.dart';

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
    GetBuilder<CartScreenController>(
      init: CartScreenController(),
      builder: (cartScreenController) {
        RegistrationScreenController registrationScreenController =
            Get.put(RegistrationScreenController());
        User? user = registrationScreenController.auth.currentUser;
        return StreamBuilder<List<CartModel>>(
            stream: cartScreenController.readCart(user!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Some Thing Wrong');
              } else if (snapshot.hasData) {
                return Badge(
                  badgeColor: Colors.lightGreen,
                  showBadge: snapshot.data!.isNotEmpty,
                  badgeContent: Text(
                    snapshot.data!.length.toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  child:
                      Icon(Icons.shopping_cart, size: 30, color: Colors.white),
                );
              } else {
                return const Center(child: CircleAvatar());
              }
            });
      },
    ),
    const Icon(Icons.shopping_bag, size: 30, color: kWhiteColor),
  ];
  final screens = [ProfileScreen(), HomeScreen(), CartScreen(), OrderScreen()];

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
