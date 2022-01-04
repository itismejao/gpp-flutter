import 'package:flutter/material.dart';

class FuncionalitieModel {
  int? id;
  String? name;
  String? icon;
  bool? active;

  List<SubFuncionalities>? subFuncionalities;
  bool isExpanded = false;
  FuncionalitieModel({
    this.id,
    this.name,
    this.icon,
    this.active,
    this.subFuncionalities,
  });

  factory FuncionalitieModel.fromJson(Map<String, dynamic> json) {
    var id = json['id'] != null ? int.parse(json['id']) : null;
    var name = json['name'];
    var icon = json['icon'];
    bool? active;
    if (json['active'] != null) {
      active = int.parse(json['active']) == 1 ? true : false;
    }
    List<SubFuncionalities> subFuncionalities = [];
    if (json['subFuncionalities'] != null) {
      json['subFuncionalities'].forEach((data) {
        subFuncionalities.add(SubFuncionalities.fromJson(data));
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

class SubFuncionalities {
  String id;
  String? name;
  String? icon;
  String? route;
  int? active;
  String? idRegister;
  Color? colorButton;
  BoxDecoration? boxDecoration;
  // Border? border =
  //     Border(left: BorderSide(color: Colors.grey.shade200, width: 2));

  SubFuncionalities(this.id,
      {this.name, this.active, this.icon, this.route, this.idRegister});

  factory SubFuncionalities.fromJson(Map<String, dynamic> json) {
    return SubFuncionalities(json['id'],
        name: json['name'],
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
