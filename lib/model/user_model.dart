class UserModel {
  String? uid;
  String? fullName;
  String? email;
  String? role;

  UserModel({this.uid, this.fullName, this.email, this.role});

//Receving from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        fullName: map['fullName'],
        email: map['email'],
        role: map['role']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'fullName': fullName, 'email': email, 'role': role};
  }
}
