import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PetScreenCotroller extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petPriceController = TextEditingController();
  TextEditingController petQuantityController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();

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

  addFill(suggestions) {
    fil = suggestions;
    update();
  }

  updateMenuValue(value) {
    selectedCategory = value;
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
  /*                          Pet Collection Read Data                          */
  /* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readPetCategory() => FirebaseFirestore.instance
      .collection('stock')
      .where('itemCategory', isEqualTo: 'pet')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                                   Delete                                   */
/* -------------------------------------------------------------------------- */
  void deletePet(StockModel index1) async {
    final pet = firebaseFirestore.collection("stock").doc(index1.itemId);
    pet.delete();
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Update Pet                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(StockModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('stock/pet/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final pet = firebaseFirestore.collection("stock").doc(index1.itemId);

    stockModel.itemName = petNameController.text;
    stockModel.itemImageUrl = imageUrl;
    stockModel.itemPrice = int.parse(petPriceController.text);
    stockModel.itemQuantity = int.parse(petQuantityController.text);
    stockModel.petCategory = selectedCategory;
    stockModel.itemCategory = 'pet';
    stockModel.itemDescription = petDescriptionController.text;

    await pet.update(stockModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
  }

/* -------------------------------------------------------------------------- */
/*                           Send data to firestore                           */
/* -------------------------------------------------------------------------- */
  sendData() async {
    if ((formKey.currentState!.validate()) || image != null) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('stock/pet/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("stock").doc();

      stockModel.itemName = petNameController.text;
      stockModel.itemImageUrl = imageUrl;
      stockModel.itemPrice = int.parse(petPriceController.text);
      stockModel.itemQuantity = int.parse(petQuantityController.text);
      stockModel.petCategory = selectedCategory;
      stockModel.itemCategory = 'pet';
      stockModel.itemDescription = petDescriptionController.text;
      stockModel.itemId = docRef.id;

      await firebaseFirestore
          .collection('stock')
          .doc(docRef.id)
          .set(stockModel.toMap());
      formKey.currentState!.reset();
      image = null;
      petNameController.clear();
      petPriceController.clear();
      selectedCategory = null;
      petDescriptionController.clear();
      Get.back();
    } else if (image == null) {
      Get.snackbar('Error', 'Image Missing');
    }
  }
}
