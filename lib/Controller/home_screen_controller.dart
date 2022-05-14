import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  UserModel loggedInUser = UserModel();
  User? user = FirebaseAuth.instance.currentUser;
  List<Map> petsCategory = [
    {'name': 'Cat', 'IconPath': 'images/cat.png'},
    {'name': 'Dog', 'IconPath': 'images/dog.png'},
    {'name': 'Rabbit', 'IconPath': 'images/rabbit.png'},
    {'name': 'Bird', 'IconPath': 'images/parrot.png'},
    {'name': 'Fish', 'IconPath': 'images/horse.png'}
  ];
  List<Map> categoryName = [
    {'name': 'All'},
    {'name': 'Pet'},
    {'name': 'Food'},
    {'name': 'Medicine'}
  ];

  @override
  void onInit() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    super.onInit();
  }
}
