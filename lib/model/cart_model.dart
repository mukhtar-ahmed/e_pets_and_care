class CartModel {
  String? productName;
  String? imageUrl;
  int? productPrice;
  String? petCategory;
  int? quantity;
  String? productId;

  CartModel(
      {this.productName,
      this.imageUrl,
      this.productPrice,
      this.petCategory,
      this.quantity,
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
      'quantity': quantity,
    };
  }
}
