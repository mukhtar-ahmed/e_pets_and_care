import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

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
}
