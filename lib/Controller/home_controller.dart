import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel loggedInUser = UserModel();
  //PetModel petModel = PetModel();
  User? user = FirebaseAuth.instance.currentUser;
  bool a = false;
  List<CategoryScreenModel> categoryData = [];
  List<PetCategoryScreenModel> petCategoryData = [];
  String mainCategoryOnPressed = '';
  String petCategoryOnPressed = '';
  var productCategory = [];
  int mainCategoryIndex = -1;
  int petCategoryIndex = -1;
  List<FoodModel> foodData = [];
  bool isPetCategory = false;
  int quantity = 0;

  void updateMainCategoryIndex(index) {
    mainCategoryIndex = index;
    update();
  }

  void updatePetCategoryIndex(index) {
    petCategoryIndex = index;
    isPetCategory = true;
    update();
  }

/* -------------------------------------------------------------------------- */
/*                  Read Food Category for Field petCategory                  */
/* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readFoodCategory() {
    if (isPetCategory == true && petCategoryOnPressed != '') {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('petCategory', isEqualTo: petCategoryOnPressed)
          .where('itemCategory', isEqualTo: 'food')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('itemCategory', isEqualTo: 'food')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                Read Medicine Category for Field petCategory                */
  /* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readMedicineCategory() {
    if (isPetCategory == true && petCategoryOnPressed != '') {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('petCategory', isEqualTo: petCategoryOnPressed)
          .where('itemCategory', isEqualTo: 'medicine')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('itemCategory', isEqualTo: 'medicine')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                   Read Pet  for Field petCategory                  */
  /* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readPet() {
    if (isPetCategory == true && petCategoryOnPressed != '') {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('petCategory', isEqualTo: petCategoryOnPressed)
          .where('itemCategory', isEqualTo: 'pet')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('stock')
          .where('itemCategory', isEqualTo: 'pet')
          .snapshots()
          .map((snapshots) => snapshots.docs
              .map((doc) => StockModel.fromMap(doc.data()))
              .toList());
    }
  }

  @override
  void onInit() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    super.onInit();
  }

/* -------------------------------------------------------------------------- */
/*                         updateMainCategoryOnPressed                        */
/* -------------------------------------------------------------------------- */
  updateMainCategoryOnPressed(CategoryScreenModel index) {
    if (categoryData.contains(index)) {
      mainCategoryOnPressed = index.title!;
      a = !a;
    }
    update();
  }

  updatePetCategoryOnPressed(PetCategoryScreenModel index) {
    if (petCategoryData.contains(index)) {
      petCategoryOnPressed = index.petName!;
      a = !a;
    }
    update();
  }

/* -------------------------------------------------------------------------- */
/*                           readCategory Collection                          */
/* -------------------------------------------------------------------------- */
  Stream<List<CategoryScreenModel>> readCategory() => FirebaseFirestore.instance
      .collection('category')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => CategoryScreenModel.fromMap(doc.data()))
          .toList());

/* -------------------------------------------------------------------------- */
/*                             Read Pets Category                             */
/* -------------------------------------------------------------------------- */
  Stream<List<PetCategoryScreenModel>> readPetCategory() =>
      FirebaseFirestore.instance.collection('pet_category').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => PetCategoryScreenModel.fromMap(doc.data()))
              .toList());
}
