class CartModel {
  String? productName;
  String? uid;
  String? imageUrl;
  int? productPrice;
  String? petCategory;
  int? quantity;
  String? productId;
  int? stock;

  CartModel(
      {this.productName,
      this.imageUrl,
      this.productPrice,
      this.petCategory,
      this.uid,
      this.quantity,
      this.stock,
      this.productId});

//Receving from server
  static CartModel fromMap(Map<String, dynamic> json) {
    return CartModel(
      productName: json['productName'],
      imageUrl: json['imageUrl'],
      productPrice: json['productPrice'],
      petCategory: json['petCategory'],
      quantity: json['quantity'],
      productId: json['productId'],
      stock: json['itemQuantity'],
      uid: json['uid'],
    );
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'imageUrl': imageUrl,
      'productPrice': productPrice,
      'petCategory': petCategory,
      'productId': productId,
      'itemQuantity': stock,
      'quantity': quantity,
      'uid': uid,
    };
  }
}
