import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category_screen.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/food_screen.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Views/Screens/pet_screen.dart';
import 'package:e_pets_and_care/Admin/view/screens/medicine_management_screen.dart';
import 'package:e_pets_and_care/Admin/view/screens/pet_management_screen.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomAdminNavigationBar extends StatefulWidget {
  static const String id = '/bottom_admin_navigation_bar';
  const BottomAdminNavigationBar({Key? key}) : super(key: key);

  @override
  State<BottomAdminNavigationBar> createState() =>
      _BottomAdminNavigationBarState();
}

class _BottomAdminNavigationBarState extends State<BottomAdminNavigationBar> {
  int index = 1;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final item = <Widget>[
    const Icon(Icons.pets, size: 30),
    const Icon(Icons.category, size: 30),
    const Icon(Icons.medication, size: 30),
    const Icon(Icons.food_bank, size: 30),
  ];
  final screens = [
    const PetScreen(),
    const CategoryScreen(),
    const MedicineManagementScreen(),
    const FoodScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          buttonBackgroundColor: Colors.purple,
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
