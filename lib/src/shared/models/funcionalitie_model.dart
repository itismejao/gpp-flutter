class FuncionalitieModel {
  String id;
  String name;
  String icon;
  List<SubFuncionalities> subFuncionalities;

  FuncionalitieModel(
      {required this.id,
      required this.name,
      required this.icon,
      required this.subFuncionalities});

  factory FuncionalitieModel.fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var icon = json['icon'];
    List<SubFuncionalities> subFuncionalities = [];
    if (json['subFuncionalities'] != null) {
      json['subFuncionalities'].forEach((data) {
        subFuncionalities.add(SubFuncionalities.fromJson(data));
      });
    }
    return FuncionalitieModel(
        id: id, name: name, icon: icon, subFuncionalities: subFuncionalities);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['subFuncionalities'] =
        subFuncionalities.map((v) => v.toJson()).toList();
    return data;
  }
}

class SubFuncionalities {
  String id;
  String name;
  String icon;
  String route;

  SubFuncionalities(
      {required this.id,
      required this.name,
      required this.icon,
      required this.route});

  factory SubFuncionalities.fromJson(Map<String, dynamic> json) {
    return SubFuncionalities(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        route: json['route']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['route'] = route;
    return data;
  }
}
