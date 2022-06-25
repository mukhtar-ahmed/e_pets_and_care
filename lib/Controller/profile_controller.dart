import 'package:e_pets_and_care/view/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((_) {
      print('mukhtar');
      Get.toNamed(RegistrationScreen.id);
      print('mukhtar');
    });

   

    update();
  }
}
