import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreenController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  final auth = FirebaseAuth.instance;
  List<UserModel> fil = [];
/* -------------------------------------------------------------------------- */
/*                          User Collection Read Data                         */
/* -------------------------------------------------------------------------- */
  Stream<List<UserModel>> readUserRoleUser() => FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'user')
      .snapshots()
      .map((snapshots) =>
          snapshots.docs.map((doc) => UserModel.fromMap(doc.data())).toList());

  addFill(suggestions) {
    fil = suggestions;
    update();
  }

/* -------------------------------------------------------------------------- */
/*                                 Delete User                                */
/* -------------------------------------------------------------------------- */
  void deleteUser(UserModel? index1) async {
    final user = firebaseFirestore.collection("users").doc(index1!.uid);
    user.delete();
    
    update();
  }
}
