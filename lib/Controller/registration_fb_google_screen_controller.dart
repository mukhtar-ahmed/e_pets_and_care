import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegistrationFbGoogleScreenController extends GetxController {
  late UserModel userModel;
  // ignore: non_constant_identifier_names
  Future<UserCredential> SignInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    User? _user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    //Add To FIRESTORE
    if (_user != null) {
      final QuerySnapshot resultQuery = await FirebaseFirestore.instance
          .collection("users")
          .where('uid', isEqualTo: _user.uid)
          .get();

      final List<DocumentSnapshot> _documentSnapshort = resultQuery.docs;
      if (_documentSnapshort.isEmpty) {
        userModel = UserModel(
            uid: _user.uid, email: _user.email, fullName: _user.displayName);
        FirebaseFirestore.instance
            .collection("users")
            .doc(_user.uid)
            .set(userModel.toMap());
      }
    }
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  checkGoogleUserIsAuthenticated() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        SignInWithGoogle().then((value) {
          Get.snackbar('SignUp', 'Successfully Sinup');
        });
      }
      if (user != null) {
        Get.snackbar('SignUp', 'Already ');
      }
    });

    
  }
}
