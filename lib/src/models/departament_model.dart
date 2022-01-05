class DepartamentModel {
  String id;
  String description;
  String active;

  String createdAt;
  String updatedAt;

  DepartamentModel(
      {required this.id,
      required this.description,
      required this.active,
      required this.createdAt,
      required this.updatedAt});

  factory DepartamentModel.fromJson(Map<String, dynamic> json) {
    return DepartamentModel(
        id: json['id'],
        description: json['description'],
        active: json['active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['active'] = active;

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
