import 'dart:io';
import 'package:e_pets_and_care/Admin/FoodManagement/Model/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class FoodScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController foodNameController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();
  TextEditingController foodQuantityController = TextEditingController();
  TextEditingController foodDescriptionController = TextEditingController();

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
  StockModel stockModel = StockModel();
  TextEditingController searchController = TextEditingController();
  List<StockModel> fil = [];

  updateMenuValue(value) {
    selectedCategory = value;
    update();
  }

  addFill(suggestions) {
    fil = suggestions;
    update();
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
      var storageImage = FirebaseStorage.instance.ref('stock/food/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("stock").doc();

      stockModel.itemName = foodNameController.text;
      stockModel.itemImageUrl = imageUrl;
      stockModel.itemPrice = int.parse(foodPriceController.text);
      stockModel.itemQuantity = int.parse(foodQuantityController.text);
      stockModel.petCategory = selectedCategory;
      stockModel.itemCategory = 'food';
      stockModel.itemDescription = foodDescriptionController.text;
      stockModel.itemId = docRef.id;

      await firebaseFirestore
          .collection('stock')
          .doc(docRef.id)
          .set(stockModel.toMap());
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
/*                        Food Collection Read Data                           */
/* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readFoodCategory() => FirebaseFirestore.instance
      .collection('stock')
      .where('itemCategory', isEqualTo: 'food')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                                   Delete                                   */
/* -------------------------------------------------------------------------- */
  void deleteFood(StockModel index1) async {
    final food = firebaseFirestore.collection("stock").doc(index1.itemId);
    food.delete();
    update();
  }

/* -------------------------------------------------------------------------- */
  /*                               Update Food                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(StockModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('stock/food/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final food = firebaseFirestore.collection("stock").doc(index1.itemId);

    stockModel.itemName = foodNameController.text;
    stockModel.itemImageUrl = imageUrl;
    stockModel.itemPrice = int.parse(foodPriceController.text);
    stockModel.itemQuantity = int.parse(foodQuantityController.text);
    stockModel.petCategory = selectedCategory;
    stockModel.itemCategory = 'food';
    stockModel.itemDescription = foodDescriptionController.text;

    await food.update(stockModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
  }
}
