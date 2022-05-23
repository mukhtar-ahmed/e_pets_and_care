import 'dart:io';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();
  bool isActive = false;
  late XFile photo;
  File? image;
  late String imageUrl;
  // ignore: prefer_typing_uninitialized_variables
  late final item;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCategory;
  var index;
  List<DropdownMenuItem<dynamic>>? categoryIten = [];
  FoodModel foodModel = FoodModel();
  TextEditingController searchController = TextEditingController();
  List<FoodModel> fil = [];

  updateMenuValue(value) {
    selectedCategory = value;
    update();
  }
  addFill(suggestions) {
    fil = suggestions;
    update();
  }

/* -------------------------------------------------------------------------- */
/*                             Update Active Value                            */
/* -------------------------------------------------------------------------- */
  bool updateActive(value) {
    update();
    isActive = value;
    update();
    return isActive;
  }

/* -------------------------------------------------------------------------- */
/*                          Select Image From Gallery                         */
/* -------------------------------------------------------------------------- */
  Future selectFile() async {
    final ImagePicker _picker = ImagePicker();
    photo = (await _picker.pickImage(source: ImageSource.gallery))!;
    update();
    // ignore: unnecessary_null_comparison
    if (photo == null) return;
    final path = photo.path;
    image = File(path);
    update();
  }

/* -------------------------------------------------------------------------- */
/*                 Pet Category Collection For DropDownButton                 */
/* -------------------------------------------------------------------------- */
  Stream<List<PetCategoryScreenModel>> readCategory() =>
      FirebaseFirestore.instance.collection('pet_category').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => PetCategoryScreenModel.fromMap(doc.data()))
              .toList());

/* -------------------------------------------------------------------------- */
/*                           Send data to firestore                           */
/* -------------------------------------------------------------------------- */
  sendData() async {
    if ((formKey.currentState!.validate()) || image != null) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('food/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("food").doc();

      foodModel.active = isActive;
      foodModel.foodName = foodNameController.text;
      foodModel.imageUrl = imageUrl;
      foodModel.foodPrice = int.parse(foodPriceController.text);
      foodModel.petCategory = selectedCategory;
      foodModel.foodDescription = foodDescriptionController.text;
      foodModel.foodId = docRef.id;

      await firebaseFirestore
          .collection('food')
          .doc(docRef.id)
          .set(foodModel.toMap());
      formKey.currentState!.reset();
      image = null;
      foodNameController.clear();
      foodPriceController.clear();
      selectedCategory = null;
      foodDescriptionController.clear();
      Get.back();
    } else if (image == null) {
      Get.snackbar('Error', 'Image Missing');
    }
  }

/* -------------------------------------------------------------------------- */
/*                        Medicine Collection Read Data                       */
/* -------------------------------------------------------------------------- */
  Stream<List<FoodModel>> readMedicineCategory() => FirebaseFirestore.instance
      .collection('food')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => FoodModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                                   Delete                                   */
/* -------------------------------------------------------------------------- */
  void deleteFood(FoodModel index1) async {
    final medicine = firebaseFirestore.collection("food").doc(index1.foodId);
    medicine.delete();
    update();
  }

/* -------------------------------------------------------------------------- */
  /*                               Update Medicine                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(FoodModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('food/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final medicine = firebaseFirestore.collection("food").doc(index1.foodId);
    foodModel.active = isActive;
    foodModel.foodName = foodNameController.text;
    foodModel.imageUrl = imageUrl;
    foodModel.foodPrice = int.parse(foodPriceController.text);
    foodModel.petCategory = selectedCategory;
    foodModel.foodDescription = foodDescriptionController.text;

    await medicine.update(foodModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
  }
}
