class SupplierModel {
  String? supplierName;
  String? imageUrl;
  String? supplierCompany;
  String? supplier_id;

  SupplierModel(
      {this.supplierName, this.imageUrl, this.supplierCompany, this.supplier_id});

//Receving from server
  static SupplierModel fromMap(Map<String, dynamic> json) {
    return SupplierModel(
        supplierName: json['supplierName'],
        imageUrl: json['imageUrl'],
        supplierCompany: json['supplierCompany'],
        supplier_id: json['supplier_id']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'supplierName': supplierName,
      'imageUrl': imageUrl,
      'supplierCompany': supplierCompany,
      'supplier_id': supplier_id
    };
  }
}
