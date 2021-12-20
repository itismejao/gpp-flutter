class UserModel {
  String? uid;
  String? password;

  UserModel({this.uid, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(uid: json['uid'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['password'] = password;
    return data;
  }
}
