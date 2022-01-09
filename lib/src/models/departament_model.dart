class DepartamentModel {
  int? id;
  String? name;
  bool? active;

  String? createdAt;
  String? updatedAt;

  DepartamentModel(
      {this.id, this.name, this.active, this.createdAt, this.updatedAt});

  factory DepartamentModel.fromJson(Map<String, dynamic> json) {
    bool? active;

    if (json['active'] == "1") {
      active = true;
    } else {
      active = false;
    }

    return DepartamentModel(
        id: int.parse(json['id']),
        name: json['description'],
        active: active,
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active'] = active;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
