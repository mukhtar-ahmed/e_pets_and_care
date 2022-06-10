import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_pets_and_care/model/cart_model.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CartModel cartModel = CartModel();
  List<int> quantity = [];
  int total = 0;
  List<int> price = [];
  bool ok = false;
  String onPressedCart = '';
  List productTotalPrice = [];

  int totalBagPrice() {
    print(productTotalPrice);
    total = 0;
    for (int i = 0; i < productTotalPrice.length; i++) {
      total = (total + productTotalPrice[i]) as int;
    }
    return total;
  }

  updateonPressedCart(CartModel b) {
    onPressedCart = b.productName!;
    update();
  }

  /* -------------------------------------------------------------------------- */
  /*                               Quantity Start                               */
  /* -------------------------------------------------------------------------- */
  bool increasePressed = false;
  bool decreasePressed = false;

  increaseQuantity(int index, String id) {
    quantity[index] = quantity[index] + 1;
    firebaseFirestore
        .collection('cart')
        .doc(id)
        .update({'quantity': quantity[index]});
    increasePressed = true;
    decreasePressed = false;
    ok = true;
    update();
  }

  decreaseQuantity(int index, String id) {
    if (quantity[index] > 1) {
      quantity[index] = quantity[index] - 1;
      firebaseFirestore
          .collection('cart')
          .doc(id)
          .update({'quantity': quantity[index]});
      increasePressed = false;
      decreasePressed = true;
      ok = true;
      update();
    } else {
      // quantity[index] = 0;
      // firebaseFirestore
      //     .collection('cart')
      //     .doc(id)
      //     .update({'quantity': quantity[index]});
      firebaseFirestore.collection('cart').doc(id).delete();
      increasePressed = false;
      decreasePressed = false;
      ok = true;
    }
  }

  deleteContainer(CartModel index) {
    firebaseFirestore.collection('cart').doc(index.productId).delete();
    update();
  }

  // sendData(productName, imageUrl, productPrice, petCategoy) {
  //   final docRef = FirebaseFirestore.instance.collection("cart").doc();
  //   cartModel.productName = productName;
  //   cartModel.imageUrl = imageUrl;
  //   cartModel.productPrice = productPrice;
  //   cartModel.petCategory = petCategoy;
  //   cartModel.productId = docRef.id;
  //   //cartModel.quantity = quantity;
  //   firebaseFirestore.collection('cart').doc(docRef.id).set(cartModel.toMap());
  // }

  Stream<List<CartModel>> readCart() {
    return FirebaseFirestore.instance.collection('cart').snapshots().map(
        (snapshots) => snapshots.docs
            .map((doc) => CartModel.fromMap(doc.data()))
            .toList());
  }
}
