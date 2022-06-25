// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:io';
import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: duplicate_ignore
class MedicineScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicinePriceController = TextEditingController();
  TextEditingController medicineQuantityController = TextEditingController();
  TextEditingController medicineDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<StockModel> fil = [];

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
/*                        Medicine Collection Read Data                       */
/* -------------------------------------------------------------------------- */
  Stream<List<StockModel>> readMedicineCategory() {
    return FirebaseFirestore.instance
        .collection('stock')
        .where('itemCategory', isEqualTo: 'medicine')
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => StockModel.fromMap(doc.data()))
            .toList());
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
/*                           Send data to firestore                           */
/* -------------------------------------------------------------------------- */
  sendData() async {
    if ((formKey.currentState!.validate()) || image != null) {
      final fileName = basename(image!.path);
      var storageImage =
          FirebaseStorage.instance.ref('stock/medicine/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("stock").doc();

      stockModel.itemName = medicineNameController.text;
      stockModel.itemImageUrl = imageUrl;
      stockModel.itemPrice = int.parse(medicinePriceController.text);
      stockModel.itemQuantity = int.parse(medicineQuantityController.text);
      stockModel.petCategory = selectedCategory;
      stockModel.itemCategory = 'medicine';
      stockModel.itemDescription = medicineDescriptionController.text;
      stockModel.itemId = docRef.id;

      await firebaseFirestore
          .collection('stock')
          .doc(docRef.id)
          .set(stockModel.toMap());
      formKey.currentState!.reset();
      image = null;
      medicineNameController.clear();
      medicinePriceController.clear();
      selectedCategory = null;
      medicineDescriptionController.clear();
      Get.back();
    } else if (image == null) {
      Get.snackbar('Error', 'Image Missing');
    }
  }

/* -------------------------------------------------------------------------- */
/*                                   Delete                                   */
/* -------------------------------------------------------------------------- */
  void deleteMedicine(StockModel index1) async {
    final medicine = firebaseFirestore.collection("stock").doc(index1.itemId);
    medicine.delete();
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Update Medicine                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(StockModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('stock/medicine/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final medicine = firebaseFirestore.collection("stock").doc(index1.itemId);

    stockModel.itemName = medicineNameController.text;
    stockModel.itemImageUrl = imageUrl;
    stockModel.itemPrice = int.parse(medicinePriceController.text);
    stockModel.itemQuantity = int.parse(medicineQuantityController.text);
    stockModel.petCategory = selectedCategory;
    stockModel.itemCategory = 'medicine';
    stockModel.itemDescription = medicineDescriptionController.text;

    await medicine.update(stockModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
  }
}
