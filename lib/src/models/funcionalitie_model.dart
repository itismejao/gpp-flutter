import 'package:gpp/src/models/subfuncionalities_model.dart';

class FuncionalitieModel {
  int? id;
  String? name;
  String? icon;
  bool? active;

  List<SubFuncionalitiesModel>? subFuncionalities;
  bool isExpanded = false;
  FuncionalitieModel({
    this.id,
    this.name,
    this.icon,
    this.active,
    this.subFuncionalities,
  });

  factory FuncionalitieModel.fromJson(Map<String, dynamic> json) {
    var id = json['id'];
    var name = json['name'];
    var icon = json['icon'];
    bool? active = json['active'];

    List<SubFuncionalitiesModel> subFuncionalities = [];
    if (json['subFuncionalities'] != null) {
      json['subFuncionalities'].forEach((data) {
        subFuncionalities.add(SubFuncionalitiesModel.fromJson(data));
      });
    }
    return FuncionalitieModel(
        id: id,
        name: name,
        icon: icon,
        active: active,
        subFuncionalities: subFuncionalities);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['active'] = active! ? 1 : 0;
    data['subFuncionalities'] != null
        ? subFuncionalities!.map((v) => v.toJson()).toList()
        : null;

    return data;
  }
}
