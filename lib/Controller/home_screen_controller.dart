import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel loggedInUser = UserModel();
  PetModel petModel = PetModel();
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

  void updateMainCategoryIndex(index) {
    mainCategoryIndex = index;
    update();
  }

  void updatePetCategoryIndex(index) {
    petCategoryIndex = index;
    update();
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

  readForUser() async {
    if (mainCategoryOnPressed == 'Pets' && petCategoryOnPressed == 'cat') {
      print("mukhtar");
      QuerySnapshot query = await firebaseFirestore
          .collection('pet')
          .where("petCategory", isEqualTo: 'cat')
          .get();
      print(query);

      print("mukhtar0");
    }
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
