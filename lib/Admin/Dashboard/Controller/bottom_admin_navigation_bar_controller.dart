import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category_screen.dart';
import 'package:e_pets_and_care/Admin/Dashboard/Views/Screens/dashboard_screen.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/food_screen.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Views/Screens/medicine_screen.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/pet_category_screen.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Views/Screens/pet_screen.dart';
import 'package:e_pets_and_care/Admin/UserManagement/Views/Screens/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomAdminNavigationBarController extends GetxController {
  int index = 3;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final item = <Widget>[
    const CustomeContainerOfNavigationBar(
      icon: Icons.menu,
      text: "Category",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.category,
      text: "Pets Category",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.pets,
      text: "Pet",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.dashboard,
      text: "Dashboard",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.medication,
      text: "Medicine",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.food_bank,
      text: "Food",
      fontSize: 8,
    ),
    const CustomeContainerOfNavigationBar(
      icon: Icons.person,
      text: "User",
      fontSize: 8,
    ),
  ];
  final screens = [
    const CategoryScreen(),
    const PetCategoryScreen(),
    PetScreen(),
    DashboardScreen(),
    MedicineScreen(),
    FoodScreen(),
    const UserScreen(),
  ];

  updateindex(index1) {
    index = index1;
    update();
  }
}

class CustomeContainerOfNavigationBar extends StatelessWidget {
  const CustomeContainerOfNavigationBar({
    Key? key,
    required this.icon,
    required this.text,
    required this.fontSize,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        children: [
          Icon(icon, size: 30.sp),
          Text(
            text,
            style: TextStyle(fontSize: fontSize.sp),
          )
        ],
      ),
    );
  }
}
