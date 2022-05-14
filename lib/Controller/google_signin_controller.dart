import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController {
  var googleSignIn = GoogleSignIn();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  GoogleSignInAccount? googleSignInAccount;

  logIn() async {
    googleSignInAccount = await googleSignIn.signIn();
    update();
  }

  logout() async {
    googleSignInAccount = await googleSignIn.signOut();
    update();
  }
}
