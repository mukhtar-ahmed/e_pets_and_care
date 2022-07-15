import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../Model/supplier_ model.dart';

class SupplierController extends GetxController
{
  File? image;
  late String imageUrl;
  late XFile photo;
  final formKey = GlobalKey<FormState>();
  TextEditingController supplierNameController = TextEditingController();
  TextEditingController supplierCompanyController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance; 
  SupplierModel supplierModel = SupplierModel();
  List<SupplierModel> fil = [];

  addFill(suggestions) {
    fil = suggestions;
    update();
  }

  sendData() async {
    if (formKey.currentState!.validate()) {
      final fileName = basename(image!.path);
      var storageImage = FirebaseStorage.instance.ref('petSupplier/$fileName');
      var task = storageImage.putFile(image!);
      imageUrl = await (await task).ref.getDownloadURL();
      final docRef = FirebaseFirestore.instance.collection("petSupplier").doc();
      supplierModel.supplierName = supplierNameController.text;
      supplierModel.imageUrl = imageUrl;
      supplierModel.supplierCompany = supplierCompanyController.text;
      supplierModel.supplier_id = docRef.id;
      await firebaseFirestore
          .collection('petSupplier')
          .doc(docRef.id)
          .set(supplierModel.toMap());
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

  Stream<List<SupplierModel>> readSupplier() => FirebaseFirestore.instance
      .collection('petSupplier')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map((doc) => SupplierModel.fromMap(doc.data()))
          .toList());

/* -------------------------------------------------------------------------- */
/*                             Delete Pet Supplier                            */
/* -------------------------------------------------------------------------- */
  void deleteSupplier(SupplierModel index1) async {
    final supplier =
        firebaseFirestore.collection("petSupplier").doc(index1.supplier_id);
    supplier.delete();
    update();
  }

/* -------------------------------------------------------------------------- */
/*                              Edit Pet Suppiler                             */
/* -------------------------------------------------------------------------- */
  void updateSupplier(SupplierModel index1) async {
    final fileName = basename(image!.path);
    var storageImage = FirebaseStorage.instance.ref('petSupplier/$fileName');
    var task = storageImage.putFile(image!);
    imageUrl = await (await task).ref.getDownloadURL();
    final supplier =
        firebaseFirestore.collection("petSupplier").doc(index1.supplier_id);
    supplierModel.supplierName = supplierNameController.text;
    supplierModel.imageUrl = imageUrl;
    supplierModel.supplierCompany = supplierCompanyController.text;
    await supplier.update(supplierModel.toMap());
    update();
    Get.back();
  }

}