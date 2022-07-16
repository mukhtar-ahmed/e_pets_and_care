import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Views/Screens/category_screen.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/add_food_screen.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Views/Screens/food_screen.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Views/Screens/add_medicine_screen.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Views/Screens/medicine_screen.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/pet_category.dart';
import 'package:e_pets_and_care/Admin/Dashboard/Views/Screens/bottom_admin_navigation_bar.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Views/Screens/pet_category_screen.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Views/Screens/add_pet_screen.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Views/Screens/pet_screen.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/add_supplier_screen.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/supplier.dart';
import 'package:e_pets_and_care/Admin/PetSupplierManagement/Views/Screens/supplier_screen.dart';
import 'package:e_pets_and_care/Admin/UserManagement/Views/Screens/user_screen.dart';
import 'package:e_pets_and_care/constant.dart';
import 'package:e_pets_and_care/view/screens/bottom_navigation_bar.dart';
import 'package:e_pets_and_care/view/screens/cart_screen.dart';
import 'package:e_pets_and_care/view/screens/checkout_screen.dart';
import 'package:e_pets_and_care/view/screens/edit_profile_screen.dart';
import 'package:e_pets_and_care/view/screens/email_verification_screen.dart';
import 'package:e_pets_and_care/view/screens/first_screen.dart';
import 'package:e_pets_and_care/view/screens/forgot_password_screen.dart';
import 'package:e_pets_and_care/view/screens/home_screen.dart';
import 'package:e_pets_and_care/view/screens/item_details_screen.dart';
import 'package:e_pets_and_care/view/screens/registration_fb_google_screen.dart';
import 'package:e_pets_and_care/view/screens/registration_screen.dart';
import 'package:e_pets_and_care/view/screens/signin_screen.dart';
import 'package:e_pets_and_care/view/screens/unbording_screen.dart';
import 'package:e_pets_and_care/view/screens/user_selection_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: kPrimaryColor,
        ),
        // ignore: prefer_const_constructors
        home: FirstScreen(),
        getPages: [
          GetPage(
              name: EditProfileScreen.id,
              page: () => const EditProfileScreen()),
          GetPage(name: UnbordingScreen.id, page: () => UnbordingScreen()),
          GetPage(
              name: UserSelectionScreen.id,
              page: () => const UserSelectionScreen()),
          GetPage(name: FirstScreen.id, page: () => FirstScreen()),
          GetPage(
              name: BottomNavigationBars.id,
              page: () => const BottomNavigationBars()),
          GetPage(name: SignInScreen.id, page: () => SignInScreen()),
          GetPage(
              name: RegistrationScreen.id,
              page: () => const RegistrationScreen()),
          GetPage(
              name: RegistrationFbGoogleScreen.id,
              page: () => RegistrationFbGoogleScreen()),
          GetPage(name: HomeScreen.id, page: () => const HomeScreen()),
          GetPage(
              name: EmailVerificationScreen.id,
              page: () => EmailVerificationScreen()),
          GetPage(
              name: ForgotPasswordScreen.id,
              page: () => const ForgotPasswordScreen()),
          GetPage(name: CartScreen.id, page: () => const CartScreen()),
          GetPage(
              name: ItemDetailsScreen.id,
              page: () => const ItemDetailsScreen()),
          GetPage(name: CheckoutScreen.id, page: () => const CheckoutScreen()),

          /* -------------------------------------------------------------------------- */
          /*                              Admin Page Routes                             */
          /* -------------------------------------------------------------------------- */

          GetPage(
              name: BottomAdminNavigationBar.id,
              page: () => const BottomAdminNavigationBar()),
          GetPage(name: Category.id, page: () => const Category()),
          GetPage(name: PetCategory.id, page: () => const PetCategory()),
          GetPage(
              name: AddMedicineScreen.id,
              page: () => const AddMedicineScreen()),
          GetPage(name: AddFoodScreen.id, page: () => const AddFoodScreen()),
          GetPage(name: AddPetScreen.id, page: () => const AddPetScreen()),
          GetPage(
              name: AddSupplierScreen.id,
              page: () => const AddSupplierScreen()),
          GetPage(name: Supplier.id, page: () => const Supplier()),
          GetPage(name: SupplierScreen.id, page: () => const SupplierScreen()),
          GetPage(name: FoodScreen.id, page: () =>  FoodScreen()),
          GetPage(name: MedicineScreen.id, page: () =>  MedicineScreen()),
          GetPage(name: PetScreen.id, page: () =>  PetScreen()),
          GetPage(name: PetCategoryScreen.id, page: () =>  PetCategoryScreen()),
          GetPage(name: CategoryScreen.id, page: () =>  CategoryScreen()),
          GetPage(name: UserScreen.id, page: () =>  UserScreen()),
        ],
      ),
      designSize: const Size(375, 812),
    );
  }
}
