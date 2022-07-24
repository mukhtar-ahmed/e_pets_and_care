class OrderModel {
  String? productName;
  String? productPrice;
  String? adress;
  String? productQuantity;
  String? productId;
  String? uid;
  String? orderStatus;
  String? productImage;

  OrderModel({
    this.productName,
    this.productPrice,
    this.adress,
    this.productQuantity,
    this.productId,
    this.orderStatus,
    this.uid,
    this.productImage,
  });

//Receving from server
  factory OrderModel.fromMap(map) {
    return OrderModel(
      productName: map['productName'],
      productPrice: map['productPrice'],
      productId: map['productId'],
      adress: map['adress'],
      productQuantity: map['productQuantity'],
      orderStatus: map['orderStatus'],
      uid: map['uid'],
      productImage: map['productImage'],
    );
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'adress': adress,
      'productQuantity': productQuantity,
      'productId': productId,
      'orderStatus': orderStatus,
      'uid': uid,
      'productImage': productImage,
    };
  }
}
