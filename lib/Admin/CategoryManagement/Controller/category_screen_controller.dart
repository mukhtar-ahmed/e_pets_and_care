import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class CategoryScreenController extends GetxController {
  File? image;
  late String imageUrl;
  late XFile photo;
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late bool isActive = false;
  CategoryScreenModel categoryScreenModel = CategoryScreenModel();
  List<CategoryScreenModel> fil = [];

  @override
  void onInit() {
    super.onInit();
  }

  addFill(suggestions) {
    fil = suggestions;
    update();
  }

  bool updateActive(value) {
    isActive = value;
    update();
    return isActive;
  }

  sendData() async {
    if (formKey.currentState!.validate()) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('category/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("category").doc();

      categoryScreenModel.title = titleController.text;

      categoryScreenModel.imageUrl = imageUrl;
      categoryScreenModel.active = isActive;
      categoryScreenModel.category_id = docRef.id;

      await firebaseFirestore
          .collection('category')
          .doc(docRef.id)
          .set(categoryScreenModel.toMap());
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

  Stream<List<CategoryScreenModel>> readCategory() => FirebaseFirestore.instance
      .collection('category')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => CategoryScreenModel.fromMap(doc.data()))
          .toList());
/* -------------------------------------------------------------------------- */
/*                               Delete Category                              */
/* -------------------------------------------------------------------------- */
  void deleteCategory(CategoryScreenModel index1) async {
    final category =
        firebaseFirestore.collection("category").doc(index1.category_id);
    category.delete();
    update();
  }

/* -------------------------------------------------------------------------- */
/*                                Edit Category                               */
/* -------------------------------------------------------------------------- */
  void updateCategory(CategoryScreenModel index1) async {
    // Get.snackbar('error1', titleController.text);
    // Get.snackbar('error1', imageUrl);
    // Get.snackbar('error2', isActive.toString());

    final fileName = basename(image!.path);
    //Get.snackbar('error1', titleController.text);
    var storageImage = FirebaseStorage.instance.ref('category/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final category =
        firebaseFirestore.collection("category").doc(index1.category_id);
    categoryScreenModel.title = titleController.text;

    categoryScreenModel.imageUrl = imageUrl;
    categoryScreenModel.active = isActive;

    await category.update(categoryScreenModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
    Get.back();
  }
}
