import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:get/get.dart';

class CustomeProductDetailsController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CartModel cartModel = CartModel();
  int quantity = 1;
  bool increasePressed = false;
  bool decreasePressed = false;
  bool cartPressed = false;

  increaseQuantity() {
    quantity = quantity + 1;
    increasePressed = true;
    decreasePressed = false;
    update();
  }

  decreaseQuantity() {
    if (quantity > 1) {
      quantity = quantity - 1;
      increasePressed = false;
      decreasePressed = true;
      update();
    } else {
      quantity = 1;
      increasePressed = false;
      decreasePressed = false;
    }
  }

  sendData(productName, imageUrl, productPrice, petCategoy, id) async {
    cartPressed = true;
    update();
    //final docRef = FirebaseFirestore.instance.collection("cart").doc();
    cartModel.productName = productName;
    cartModel.imageUrl = imageUrl;
    cartModel.productPrice = productPrice;
    cartModel.petCategory = petCategoy;
    cartModel.productId = id;
    cartModel.quantity = quantity;
    bool exist;

    var a = await firebaseFirestore.collection('collection').doc(id).get();
    if (a.exists) {
      Get.snackbar('Already Exist', productName);

      //return a;
    }
    if (!a.exists) {
      firebaseFirestore.collection('cart').doc(id).set(cartModel.toMap());
      cartPressed = false;
      update();

      Get.back();
      print('mukhtar');
      Get.snackbar('Notification', 'Product Added to cart',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1));
    }
  }
}
