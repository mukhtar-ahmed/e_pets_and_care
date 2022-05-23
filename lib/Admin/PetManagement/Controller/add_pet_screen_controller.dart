import 'package:e_pets_and_care/Admin/PetManagement/Model/pet_model.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPetScreenCotroller extends GetxController
{
  final formKey = GlobalKey<FormState>();
  TextEditingController petNameController = TextEditingController();
  TextEditingController petPriceController = TextEditingController();
  TextEditingController petDescriptionController = TextEditingController();
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
  PetModel petModel = PetModel();
  TextEditingController searchController = TextEditingController();
  List<PetModel> fil = [];

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
/*                             Update Active Value                            */
/* -------------------------------------------------------------------------- */
  bool updateActive(value) {
    update();
    isActive = value;
    update();
    return isActive;
  }

 /* -------------------------------------------------------------------------- */
 /*                          Pet Collection Read Data                          */
 /* -------------------------------------------------------------------------- */
  Stream<List<PetModel>> readPetCategory() =>
      FirebaseFirestore.instance.collection('pet').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => PetModel.fromMap(doc.data()))
              .toList());

/* -------------------------------------------------------------------------- */
/*                                   Delete                                   */
/* -------------------------------------------------------------------------- */
  void deletePet(PetModel index1) async {
    final pet =
        firebaseFirestore.collection("pet").doc(index1.petId);
    pet.delete();
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Update Pet                              */
  /* -------------------------------------------------------------------------- */
  void updateCategory(PetModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('pet/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    // final category = firebaseFirestore.collection("category").doc('uid');
    final pet =
        firebaseFirestore.collection("pet").doc(index1.petId);
    petModel.active = isActive;
    petModel.petName = petNameController.text;
    petModel.imageUrl = imageUrl;
    petModel.petPrice = int.parse(petPriceController.text);
    petModel.petCategory = selectedCategory;
    petModel.petDescription = petDescriptionController.text;

    await pet.update(petModel.toMap());

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
      var storageImage = FirebaseStorage.instance.ref('pet/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();

      final docRef = FirebaseFirestore.instance.collection("pet").doc();

      petModel.active = isActive;
      petModel.petName = petNameController.text;
      petModel.imageUrl = imageUrl;
      petModel.petPrice = int.parse(petPriceController.text);
      petModel.petCategory = selectedCategory;
      petModel.petDescription = petDescriptionController.text;
      petModel.petId = docRef.id;

      await firebaseFirestore
          .collection('pet')
          .doc(docRef.id)
          .set(petModel.toMap());
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