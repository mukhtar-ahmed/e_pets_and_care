class PetModel {
  
  String? petName;
  String? imageUrl;
  int? petPrice;
  int? quantity;
  String? petCategory;
  String? petDescription;
  String? petId;

  PetModel(
      {this.quantity,
      this.petName,
      this.imageUrl,
      this.petPrice,
      this.petCategory,
      this.petDescription,
      this.petId});

//Receving from server
  static PetModel fromMap(Map<String, dynamic> json) {
    return PetModel(
        quantity: json['quantity'],
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
      'quantity': quantity,
      'petName': petName,
      'imageUrl': imageUrl,
      'petPrice': petPrice,
      'petCategory': petCategory,
      'petDescription': petDescription,
      'petId': petId
    };
  }
}
