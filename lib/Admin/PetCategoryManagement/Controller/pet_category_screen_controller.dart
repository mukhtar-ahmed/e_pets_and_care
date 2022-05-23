import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class PetCategoryScreenController extends GetxController {
  File? image;
  late String imageUrl;
  late XFile photo;
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late bool isActive = false;
  PetCategoryScreenModel petCategoryScreenModel = PetCategoryScreenModel();
  TextEditingController searchController = TextEditingController();
  List<PetCategoryScreenModel> fil = [];

  addFill(suggestions) {
    fil = suggestions;
    update();
  }

  bool updateActive(value) {
    update();
    isActive = value;
    update();
    return isActive;
  }

  sendData() async {
    if (formKey.currentState!.validate()) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('petCategory/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef =
          FirebaseFirestore.instance.collection("pet_category").doc();

      petCategoryScreenModel.petName = titleController.text;

      petCategoryScreenModel.imageUrl = imageUrl;
      petCategoryScreenModel.active = isActive;
      petCategoryScreenModel.petCategoryId = docRef.id;

      await firebaseFirestore
          .collection('pet_category')
          .doc(docRef.id)
          .set(petCategoryScreenModel.toMap());
      Get.back();
    }
  }

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

  Stream<List<PetCategoryScreenModel>> readCategory() =>
      FirebaseFirestore.instance.collection('pet_category').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => PetCategoryScreenModel.fromMap(doc.data()))
              .toList());
/* -------------------------------------------------------------------------- */
/*                               Delete Category                              */
/* -------------------------------------------------------------------------- */
  void deletePetCategory(PetCategoryScreenModel index1) async {
    final category =
        firebaseFirestore.collection("pet_category").doc(index1.petCategoryId);
    category.delete();
    update();
  }

/* -------------------------------------------------------------------------- */
/*                                Edit Category                               */
/* -------------------------------------------------------------------------- */
  void updatePetCategory(PetCategoryScreenModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('petCategory/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final category =
        firebaseFirestore.collection("pet_category").doc(index1.petCategoryId);
    petCategoryScreenModel.petName = titleController.text;

    petCategoryScreenModel.imageUrl = imageUrl;
    petCategoryScreenModel.active = isActive;

    await category.update(petCategoryScreenModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
    Get.back();
  }
}
