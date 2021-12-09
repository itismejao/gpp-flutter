class AuthenticateModel {
  String name;
  String email;
  String uid;

  AuthenticateModel(
      {required this.name, required this.email, required this.uid});

  String getEmail() {
    return email;
  }

  factory AuthenticateModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateModel(
        name: json['name'], email: json['email'], uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['uid'] = uid;
    return data;
  }
}
