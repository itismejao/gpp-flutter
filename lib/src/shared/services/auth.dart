import 'dart:convert';

import 'package:gpp/src/controllers/menu_filial/filial_controller.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/models/menu_filial/filial_model.dart';
import 'package:universal_html/html.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storage = window.localStorage;

void setToken(String token) {
  storage['token'] = token;
}

void logout() {
  storage.remove('token');
}

String? getToken() {
  return storage['token'];
}

bool isAuthenticated() {
  print(storage['token']);
  return storage['token'] != null;
}

void setFilial({EmpresaFilialModel? filial}) {
  if (filial != null) {
    Map<String, dynamic> filialMap = filial.toJson();

    storage['filial'] = jsonEncode(filialMap);
  } else {
    Map<String, dynamic> filialMap = EmpresaFilialModel(
      id_empresa: 1,
      id_filial: 500,
      filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
    ).toJson();

    storage['filial'] = jsonEncode(filialMap);
  }
}

EmpresaFilialModel getFilial() {
  Map<String, dynamic> json = jsonDecode(storage['filial']!);

  EmpresaFilialModel filialModel = EmpresaFilialModel.fromJson(json);

  return filialModel;
}
