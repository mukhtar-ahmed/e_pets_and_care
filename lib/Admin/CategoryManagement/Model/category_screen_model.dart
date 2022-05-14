class CategoryScreenModel {
  String? title;
  String? imageUrl;
  bool? active;
  String? category_id;

  CategoryScreenModel(
      {this.title, this.imageUrl, this.active, this.category_id});

//Receving from server
  static CategoryScreenModel fromMap(Map<String, dynamic> json) {
    return CategoryScreenModel(
        title: json['title'],
        imageUrl: json['imageUrl'],
        active: json['active'],
        category_id: json['category_id']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'active': active,
      'category_id': category_id
    };
  }
}
