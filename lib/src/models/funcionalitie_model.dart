import 'package:flutter/material.dart';

class FuncionalitieModel {
  String id;
  String name;
  String icon;
  List<SubFuncionalities> subFuncionalities;
  bool isExpanded = false;

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
  String? icon;
  String? route;
  int? active;
  String? idRegister;
  Color? colorButton;
  Border? border =
      Border(left: BorderSide(color: Colors.grey.shade200, width: 2));

  SubFuncionalities(this.id, this.name,
      {this.active, this.icon, this.route, this.idRegister});

  factory SubFuncionalities.fromJson(Map<String, dynamic> json) {
    return SubFuncionalities(json['id'], json['name'],
        active: json['active'],
        icon: json['icon'],
        route: json['route'],
        idRegister: json['idregister']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active'] = active;
    data['icon'] = icon;
    data['route'] = route;
    data['idregister'] = idRegister;
    return data;
  }
}
