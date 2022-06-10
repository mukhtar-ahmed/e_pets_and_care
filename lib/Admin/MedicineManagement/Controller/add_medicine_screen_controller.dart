// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'dart:io';
import 'package:e_pets_and_care/Admin/MedicineManagement/Model/medicine_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: duplicate_ignore
class AddMedicineScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicinePriceController = TextEditingController();
  TextEditingController medicineDescriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  List<MedicineModel> fil = [];

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
  MedicineModel medicineModel = MedicineModel();

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
  Stream<List<MedicineModel>> readMedicineCategory() {
    return FirebaseFirestore.instance.collection('medicine').snapshots().map(
        (snapshots) => snapshots.docs
            .map((doc) => MedicineModel.fromMap(doc.data()))
            .toList());
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
/*                           Send data to firestore                           */
/* -------------------------------------------------------------------------- */
  sendData() async {
    if ((formKey.currentState!.validate()) || image != null) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('medicine/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("medicine").doc();

      medicineModel.active = isActive;
      medicineModel.medicineName = medicineNameController.text;
      medicineModel.imageUrl = imageUrl;
      medicineModel.medicinePrice = int.parse(medicinePriceController.text);
      medicineModel.petCategory = selectedCategory;
      medicineModel.medicineDescription = medicineDescriptionController.text;
      medicineModel.medicineId = docRef.id;

      await firebaseFirestore
          .collection('medicine')
          .doc(docRef.id)
          .set(medicineModel.toMap());
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
  void deleteMedicine(MedicineModel index1) async {
    final medicine =
        firebaseFirestore.collection("medicine").doc(index1.medicineId);
    medicine.delete();
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Update Medicine                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(MedicineModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('medicine/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final medicine =
        firebaseFirestore.collection("medicine").doc(index1.medicineId);
    medicineModel.active = isActive;
    medicineModel.medicineName = medicineNameController.text;
    medicineModel.imageUrl = imageUrl;
    medicineModel.medicinePrice = int.parse(medicinePriceController.text);
    medicineModel.petCategory = selectedCategory;
    medicineModel.medicineDescription = medicineDescriptionController.text;

    await medicine.update(medicineModel.toMap());

    // category.update({
    //   'title': titleController.text,
    //   'active': isActive,
    //   'imageUrl': imageUrl
    // });
    update();
  }
}
