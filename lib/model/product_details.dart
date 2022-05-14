class ProductDetails {
  String? productUid;
  String? productName;
  String? productCategory;
  String? petCategory;
  double? productPrice;
  String? productDescription;

  ProductDetails(
      {this.productUid,
      this.productName,
      this.productCategory,
      this.petCategory,
      this.productPrice,
      this.productDescription});

//Receving from server
  factory ProductDetails.fromMap(map) {
    return ProductDetails(
      productUid: map['productUid'],
      productName: map['productName'],
      productCategory: map['productCategory'],
      petCategory: map['petCategory'],
      productPrice: map['productPrice'],
      productDescription: map['productDescription'],
    );
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'productUid': productUid,
      'productName': productName,
      'productCategory': productCategory,
      'petCategory': petCategory,
      'productPrice': productPrice,
      'productDescription': productDescription,
    };
  }
}
