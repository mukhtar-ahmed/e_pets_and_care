class PetDetails {
  String? petName;
  String? petCategory;
  double? petPrice;
  String? petColor;
  String? petDescription;

  PetDetails(
      {this.petName,
      this.petCategory,
      this.petPrice,
      this.petColor,
      this.petDescription});

//Receving from server
  factory PetDetails.fromMap(map) {
    return PetDetails(
      petName: map['petName'],
      petCategory: map['petCategory'],
      petPrice: map['petPrice'],
      petColor: map['petColor'],
      petDescription: map['petDescription'],
    );
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'petName': petName,
      'petCategory': petCategory,
      'petPrice': petPrice,
      'petColor': petColor,
      'petDescription': petDescription,
    };
  }
}
