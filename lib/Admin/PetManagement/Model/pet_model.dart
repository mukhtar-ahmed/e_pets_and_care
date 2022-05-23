class PetModel {
  bool? active;
  String? petName;
  String? imageUrl;
  int? petPrice;
  String? petCategory;
  String? petDescription;
  String? petId;

  PetModel(
      {this.active,
      this.petName,
      this.imageUrl,
      this.petPrice,
      this.petCategory,
      this.petDescription,
      this.petId});

//Receving from server
  static PetModel fromMap(Map<String, dynamic> json) {
    return PetModel(
        active: json['active'],
        petName: json['petName'],
        imageUrl: json['imageUrl'],
        petPrice: json['petPrice'],
        petCategory: json['petCategory'],
        petDescription: json['petDescription'],
        petId: json['petId']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'active': active,
      'petName': petName,
      'imageUrl': imageUrl,
      'petPrice': petPrice,
      'petCategory': petCategory,
      'petDescription': petDescription,
      'petId': petId
    };
  }
}
