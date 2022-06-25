class MedicineModel {
  String? medicineName;
  String? imageUrl;
  int? medicinePrice;
  int? quantity;
  String? petCategory;
  String? medicineDescription;
  String? medicineId;

  MedicineModel(
      {this.quantity,
      this.medicineName,
      this.imageUrl,
      this.medicinePrice,
      this.petCategory,
      this.medicineDescription,
      this.medicineId});

//Receving from server
  static MedicineModel fromMap(Map<String, dynamic> json) {
    return MedicineModel(
        quantity: json['quantity'],
        medicineName: json['medicineName'],
        imageUrl: json['imageUrl'],
        medicinePrice: json['medicinePrice'],
        petCategory: json['petCategory'],
        medicineDescription: json['medicineDescription'],
        medicineId: json['medicineId']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'medicineName': medicineName,
      'imageUrl': imageUrl,
      'medicinePrice': medicinePrice,
      'petCategory': petCategory,
      'medicineDescription': medicineDescription,
      'medicineId': medicineId
    };
  }
}
