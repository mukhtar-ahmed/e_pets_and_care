class FoodModel {
  String? foodName;
  String? imageUrl;
  int? foodPrice;
  int? quantity;
  String? petCategory;
  String? foodDescription;
  String? foodId;

  FoodModel({
    this.quantity,
    this.foodName,
    this.imageUrl,
    this.foodPrice,
    this.petCategory,
    this.foodDescription,
    this.foodId,
  });

//Receving from server
  static FoodModel fromMap(Map<String, dynamic> json) {
    return FoodModel(
        quantity: json['quantity'],
        foodName: json['foodName'],
        imageUrl: json['imageUrl'],
        foodPrice: json['foodPrice'],
        petCategory: json['petCategory'],
        foodDescription: json['foodDescription'],
        foodId: json['foodId']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'foodName': foodName,
      'imageUrl': imageUrl,
      'foodPrice': foodPrice,
      'petCategory': petCategory,
      'foodDescription': foodDescription,
      'foodId': foodId
    };
  }
}
