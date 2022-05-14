import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/product_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductAddController extends GetxController {
  final GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  String? category;
  String? petsCategory;
  List<String> categoryName = ['Pets', 'Food', 'Medicine'];
  List<String> petsName = ['Cat', 'Dog', 'Rabbit', 'Bird', 'Fish'];
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  postProductDetailsToFireStore() async {
    if (productFormKey.currentState!.validate()) {
      ProductDetails productModel = ProductDetails();
      productModel.productName = productNameController.text;
      productModel.productCategory = category;
      productModel.petCategory = petsCategory;
      productModel.productPrice = double.parse(productPriceController.text);
      productModel.productDescription = productDescriptionController.text;

      await firebaseFirestore
          .collection('product_details')
          .doc()
          .set(productModel.toMap());
    }
  }

  onChangedPetCategory(String? value) {
    petsCategory = value;
    update();
  }

  onChangedCategory(String? value) {
    category = value;
    update();
  }
}
