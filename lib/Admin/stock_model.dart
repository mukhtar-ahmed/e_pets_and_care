class StockModel {
  String? itemImageUrl;
  String? itemName;
  int? itemPrice;
  int? itemQuantity;
  String? petCategory;
  String? itemCategory;
  String? itemDescription;
  String? itemId;

  StockModel(
      {this.itemImageUrl,
      this.itemName,
      this.itemPrice,
      this.itemQuantity,
      this.petCategory,
      this.itemCategory,
      this.itemDescription,
      this.itemId});

//Receving from server
  static StockModel fromMap(Map<String, dynamic> json) {
    return StockModel(
        itemImageUrl: json['itemImageUrl'],
        itemName: json['itemName'],
        itemPrice: json['itemPrice'],
        itemQuantity: json['itemQuantity'],
        petCategory: json['petCategory'],
        itemCategory: json['itemCategory'],
        itemDescription: json['itemDescription'],
        itemId: json['itemId']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'itemImageUrl': itemImageUrl,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemQuantity': itemQuantity,
      'petCategory': petCategory,
      'itemCategory': itemCategory,
      'itemDescription': itemDescription,
      'itemId': itemId
    };
  }
}
