class FoodModel {
  bool? active;
  String? foodName;
  String? imageUrl;
  int? foodPrice;
  String? petCategory;
  String? foodDescription;
  String? foodId;

  FoodModel({
    this.active,
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
        active: json['active'],
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
      'active': active,
      'foodName': foodName,
      'imageUrl': imageUrl,
      'foodPrice': foodPrice,
      'petCategory': petCategory,
      'foodDescription': foodDescription,
      'foodId': foodId
    };
  }
}
