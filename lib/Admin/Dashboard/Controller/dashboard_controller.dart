import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/Admin/CategoryManagement/Model/category_screen_model.dart';
import 'package:e_pets_and_care/Admin/PetCategoryManagement/Model/pet_category_screen_model.dart';
import 'package:e_pets_and_care/Admin/stock_model.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:get/get.dart';

import '../../PetSupplierManagement/Model/supplier_ model.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var categoryLength = 0;

  @override
  void onInit() async {
    categoryLength =
        await firebaseFirestore.collection('category').snapshots().length;
    update();
    super.onInit();
  }

/* -------------------------------------------------------------------------- */
/*                          User Collection Read Data                         */
/* -------------------------------------------------------------------------- */
  Stream<List<UserModel>> readUserRoleUser() => FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'user')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => UserModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                         Stock Collection Read Data                         */
/* -------------------------------------------------------------------------- */
Stream<List<StockModel>> readStockCollection() => FirebaseFirestore.instance
      .collection('stock')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                       Read Stock Collection For Food                       */
/* -------------------------------------------------------------------------- */
Stream<List<StockModel>> readStockFoodCollection() => FirebaseFirestore.instance
      .collection('stock').where('itemCategory' ,isEqualTo: 'food')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());
/* -------------------------------------------------------------------------- */
/*                     Read Stock Collection For Medicine                     */
/* -------------------------------------------------------------------------- */
Stream<List<StockModel>> readStockMedicineCollection() => FirebaseFirestore.instance
      .collection('stock').where('itemCategory' ,isEqualTo: 'medicine')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                       Read Stock Collection For Pets                       */
/* -------------------------------------------------------------------------- */
Stream<List<StockModel>> readStockPetCollection() => FirebaseFirestore.instance
      .collection('stock').where('itemCategory' ,isEqualTo: 'pet')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => StockModel.fromMap(doc.data())).toList());

/* -------------------------------------------------------------------------- */
/*                        Category Collection Read Data                       */
/* -------------------------------------------------------------------------- */
  Stream<List<CategoryScreenModel>> readCategory() =>
      FirebaseFirestore.instance.collection('category').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => CategoryScreenModel.fromMap(doc.data()))
              .toList());

/* -------------------------------------------------------------------------- */
/*                    Pet Category Collection Read Data                       */
/* -------------------------------------------------------------------------- */
  Stream<List<PetCategoryScreenModel>> readPetCategory() =>
      FirebaseFirestore.instance.collection('pet_category').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => PetCategoryScreenModel.fromMap(doc.data()))
              .toList());
/* -------------------------------------------------------------------------- */
/*                      Pet Supplier Collection Read Data                     */
/* -------------------------------------------------------------------------- */
Stream<List<SupplierModel>> readSupplier() =>
      FirebaseFirestore.instance.collection('petSupplier').snapshots().map(
          (snapshots) => snapshots.docs
              .map((doc) => SupplierModel.fromMap(doc.data()))
              .toList());
}
