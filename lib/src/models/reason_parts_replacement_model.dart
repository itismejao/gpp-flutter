import 'package:flutter/material.dart';

class ReasonPartsReplacementModel {
  int? id;
  String? name;
  bool? status;
  ReasonPartsReplacementModel({
    this.id,
    this.name,
    this.status,
  });

  factory ReasonPartsReplacementModel.fromJson(Map<String, dynamic> json) {
    return ReasonPartsReplacementModel(
        id: json['id'], name: json['name'], status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
