class PetCategoryScreenModel {
  String? petName;
  String? imageUrl;
  bool? active;
  String? petCategoryId;

  PetCategoryScreenModel(
      {this.petName, this.imageUrl, this.active, this.petCategoryId});

//Receving from server
  static PetCategoryScreenModel fromMap(Map<String, dynamic> json) {
    return PetCategoryScreenModel(
        petName: json['petName'],
        imageUrl: json['imageUrl'],
        active: json['active'],
        petCategoryId: json['petCategoryId']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'petName': petName,
      'imageUrl': imageUrl,
      'active': active,
      'petCategoryId': petCategoryId
    };
  }
}
