import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category_screen.dart';
import 'package:e_pets_and_care/Admin/Dashboard/Controller/dashboard_controller.dart';
import 'package:e_pets_and_care/Admin/Dashboard/Views/Widget/custome_dashboard_container.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/food_screen.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Views/Screens/medicine_screen.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/pet_category_screen.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Views/Screens/pet_screen.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/supplier_screen.dart';
import 'package:e_pets_and_care/Admin/UserManagement/Views/Screens/user_screen.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../PetSupplierManagement/Model/supplier_ model.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (dashboardController) {
          return Scaffold(
            backgroundColor: kWhiteColor,
            body: SingleChildScrollView(
              child: SizedBox(
                width: 375.w,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                  child: Column(
                    children: [
                      /* -------------------------------------------------------------------------- */
                      /*                                 Total User                                 */
                      /* -------------------------------------------------------------------------- */
                      StreamBuilder<List<UserModel>>(
                          stream: dashboardController.readUserRoleUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(UserScreen.id);
                                },
                                child: CustomeDashboardContainer(
                                  width: 375,
                                  icon: Icons.person,
                                  iconSize: 150,
                                  childContainerWidth: 150,
                                  countText: snapshot.data!.length.toString(),
                                  counTextSize: 50,
                                  countName: 'Total User',
                                  countNameSize: 20,
                                ),
                              );
                            } else {
                              return const Center(child: CircleAvatar());
                            }
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      /* ------------------------- Category & Pet Category ------------------------ */
                      Row(
                        children: [
                          /* -------------------------------------------------------------------------- */
                          /*                                  Category                                  */
                          /* -------------------------------------------------------------------------- */
                          StreamBuilder<List<CategoryScreenModel>>(
                              stream: dashboardController.readCategory(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Some Thing Wrong');
                                } else if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(CategoryScreen.id);
                                    },
                                    child: CustomeDashboardContainer(
                                      width: 160,
                                      icon: Icons.menu,
                                      iconSize: 50,
                                      childContainerWidth: 80,
                                      countText:
                                          snapshot.data!.length.toString(),
                                      counTextSize: 25,
                                      countName: 'Category',
                                      countNameSize: 16,
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircleAvatar());
                                }
                              }),
                          SizedBox(
                            width: 15.w,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                                Pet Category                                */
                          /* -------------------------------------------------------------------------- */
                          StreamBuilder<List<PetCategoryScreenModel>>(
                              stream: dashboardController.readPetCategory(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Some Thing Wrong');
                                } else if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(PetCategoryScreen.id);
                                    },
                                    child: CustomeDashboardContainer(
                                      width: 160,
                                      icon: Icons.pets,
                                      iconSize: 50,
                                      childContainerWidth: 80,
                                      countText:
                                          snapshot.data!.length.toString(),
                                      counTextSize: 25,
                                      countName: 'Pet Category',
                                      countNameSize: 16,
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircleAvatar());
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      /* -------------------------------------------------------------------------- */
                      /*                                 Total Item                                 */
                      /* -------------------------------------------------------------------------- */
                      StreamBuilder<List<StockModel>>(
                          stream: dashboardController.readStockCollection(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapshot.hasData) {
                              return CustomeDashboardContainer(
                                width: 375,
                                icon: Icons.inventory,
                                iconSize: 150,
                                childContainerWidth: 150,
                                countText: snapshot.data!.length.toString(),
                                counTextSize: 50,
                                countName: 'Total Item In Stock',
                                countNameSize: 20,
                              );
                            } else {
                              return const Center(child: CircleAvatar());
                            }
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                      /* ---------------------------- Food and Medicine --------------------------- */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          /* -------------------------------------------------------------------------- */
                          /*                                    Food                                    */
                          /* -------------------------------------------------------------------------- */
                          StreamBuilder<List<StockModel>>(
                              stream:
                                  dashboardController.readStockFoodCollection(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Some Thing Wrong');
                                } else if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(FoodScreen.id);
                                    },
                                    child: CustomeDashboardContainer(
                                      width: 100,
                                      icon: Icons.food_bank,
                                      iconSize: 50,
                                      childContainerWidth: 50,
                                      countText:
                                          snapshot.data!.length.toString(),
                                      counTextSize: 20,
                                      countName: 'Food',
                                      countNameSize: 10,
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircleAvatar());
                                }
                              }),
                          SizedBox(
                            width: 5.w,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                                  Medicine                                  */
                          /* -------------------------------------------------------------------------- */
                          StreamBuilder<List<StockModel>>(
                              stream: dashboardController
                                  .readStockMedicineCollection(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Some Thing Wrong');
                                } else if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(MedicineScreen.id);
                                    },
                                    child: CustomeDashboardContainer(
                                      width: 100,
                                      icon: Icons.medication,
                                      iconSize: 50,
                                      childContainerWidth: 50,
                                      countText:
                                          snapshot.data!.length.toString(),
                                      counTextSize: 20,
                                      countName: 'Medicine',
                                      countNameSize: 10,
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircleAvatar());
                                }
                              }),
                          SizedBox(
                            width: 5.w,
                          ),
                          /* -------------------------------------------------------------------------- */
                          /*                                     Pet                                    */
                          /* -------------------------------------------------------------------------- */

                          StreamBuilder<List<StockModel>>(
                              stream:
                                  dashboardController.readStockPetCollection(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Some Thing Wrong');
                                } else if (snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(PetScreen.id);
                                    },
                                    child: CustomeDashboardContainer(
                                      width: 100,
                                      icon: Icons.pets,
                                      iconSize: 50,
                                      childContainerWidth: 50,
                                      countText:
                                          snapshot.data!.length.toString(),
                                      counTextSize: 20,
                                      countName: 'Pets',
                                      countNameSize: 10,
                                    ),
                                  );
                                } else {
                                  return const Center(child: CircleAvatar());
                                }
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      /* -------------------------------------------------------------------------- */
                      /*                                Pet Supplier                                */
                      /* -------------------------------------------------------------------------- */
                      StreamBuilder<List<SupplierModel>>(
                          stream: dashboardController.readSupplier(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Some Thing Wrong');
                            } else if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed(SupplierScreen.id);
                                },
                                child: CustomeDashboardContainer(
                                  width: 375,
                                  icon: Icons.delivery_dining,
                                  iconSize: 150,
                                  childContainerWidth: 150,
                                  countText: snapshot.data!.length.toString(),
                                  counTextSize: 50,
                                  countName: 'Total Pet Supplier',
                                  countNameSize: 20,
                                ),
                              );
                            } else {
                              return const Center(child: CircleAvatar());
                            }
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
