class UserProfileModel {
  String? uid;
  String? imagePath;
  String? fullName;
  String? gender;
  String? email;
  String? phone;
  String? about;

  UserProfileModel(
      {this.uid,
      this.imagePath,
      this.fullName,
      this.gender,
      this.email,
      this.phone,
      this.about});

//Receving from server
  factory UserProfileModel.fromMap(map) {
    return UserProfileModel(
        uid: map['uid'],
        imagePath: map['imagePath'],
        fullName: map['fullName'],
        gender: map['gender'],
        email: map['email'],
        phone: map['phone'],
        about: map['about']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'imagePath': imagePath,
      'fullName': fullName,
      'gender': gender,
      'email': email,
      'phone': phone,
      'about': about
    };
  }
}
