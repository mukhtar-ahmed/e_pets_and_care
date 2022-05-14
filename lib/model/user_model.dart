class UserModel {
  String? uid;
  String? fullName;
  String? email;

  UserModel({this.uid, this.fullName, this.email});

//Receving from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'], fullName: map['fullName'], email: map['email']);
  }

//Sending to server
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'fullName': fullName, 'email': email};
  }
}
