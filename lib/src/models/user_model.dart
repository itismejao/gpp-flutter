class UserModel {
  String? id;
  String? uid;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  bool? active;
  String? iddepto;
  String? departement;
  String? foto;

  UserModel(
      {this.id,
      this.uid,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.active,
      this.iddepto,
      this.departement,
      this.foto});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    bool? active;

    if (json['active'] == "1") {
      active = true;
    } else if (json['active'] == "0") {
      active = false;
    }

    return UserModel(
        id: json['id'],
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        emailVerifiedAt: json['email_verified_at'],
        password: json['password'],
        rememberToken: json['remember_token'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        active: active,
        iddepto: json['iddepto'],
        departement: json['depto'],
        foto: json['foto']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['active'] = active;
    data['iddepto'] = iddepto;
    data['depto'] = departement;
    data['foto'] = foto;

    return data;
  }
}
