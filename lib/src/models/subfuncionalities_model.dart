import 'package:flutter/material.dart';

class SubFuncionalitiesModel {
  int? id;
  String? name;
  String? icon;
  String? route;
  bool? active;

  String? idRegister;
  Color? colorButton;
  BoxDecoration? boxDecoration;
  // Border? border =
  //     Border(left: BorderSide(color: Colors.grey.shade200, width: 2));

  SubFuncionalitiesModel(
      {this.id,
      this.name,
      this.active,
      this.icon,
      this.route,
      this.idRegister});

  factory SubFuncionalitiesModel.fromJson(Map<String, dynamic> json) {
    int? id = json['id'];

    bool? active = json['active'];

    return SubFuncionalitiesModel(
        id: id,
        name: json['name'],
        active: active,
        icon: json['icon'],
        route: json['route'],
        idRegister: json['idregister']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['active'] = active! ? 1 : 0;
    data['icon'] = icon;
    data['route'] = route;
    data['idregister'] = idRegister;
    return data;
  }
}
