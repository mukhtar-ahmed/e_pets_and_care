import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/Model/pets_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AddPetScreenController extends GetxController {
  final GlobalKey<FormState> petFormKey = GlobalKey<FormState>();
  String? category;
  String? petsCategory;
  List<String> petsName = ['Cat', 'Dog', 'Rabbit', 'Bird', 'Fish'];
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petPriceController = TextEditingController();
  final TextEditingController petDescriptionController =
      TextEditingController();
  final TextEditingController petColorController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  File? file;

  onChangedPetCatagory(String? value1) {
    petsCategory = value1;
  }

  addPetDetails() async {
    if (petFormKey.currentState!.validate()) {
      PetDetails petDetails = PetDetails();
      petDetails.petName = petNameController.text;

      petDetails.petCategory = petsCategory;
      petDetails.petColor = petColorController.text;
      petDetails.petPrice = double.parse(petPriceController.text);
      petDetails.petDescription = petDescriptionController.text;

      await firebaseFirestore
          .collection('pet_details')
          .doc()
          .set(petDetails.toMap());
      uploadFile();
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;
    file = File(path);
    update();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'pets/$fileName';

    uploadtoFirebaseFile(destination, file!);
    Get.snackbar('sssssss', 'sssss');
  }

  static UploadTask? uploadtoFirebaseFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      Get.snackbar('sssssss', e.toString());
      return null;
    }
  }
}
