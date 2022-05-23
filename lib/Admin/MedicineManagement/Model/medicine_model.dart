class MedicineModel {
  bool? active;
  String? medicineName;
  String? imageUrl;
  int? medicinePrice;
  String? petCategory;
  String? medicineDescription;
  String? medicineId;

  MedicineModel(
      {this.active,
      this.medicineName,
      this.imageUrl,
      this.medicinePrice,
      this.petCategory,
      this.medicineDescription,
      this.medicineId});

//Receving from server
  static MedicineModel fromMap(Map<String, dynamic> json) {
    return MedicineModel(
        active: json['active'],
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
      'active': active,
      'medicineName': medicineName,
      'imageUrl': imageUrl,
      'medicinePrice': medicinePrice,
      'petCategory': petCategory,
      'medicineDescription': medicineDescription,
      'medicineId': medicineId
    };
  }
}
