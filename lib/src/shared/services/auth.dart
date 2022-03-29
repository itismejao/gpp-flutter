import 'dart:convert';

import 'package:gpp/src/controllers/menu_filial/filial_controller.dart';
import 'package:gpp/src/models/user_model.dart';

import 'package:universal_html/html.dart';

import '../../models/filial/empresa_filial_model.dart';
import '../../models/filial/filial_model.dart';

final storage = window.localStorage;

void setToken(String token) {
  storage['token'] = token;
}

String? getToken() {
  return storage['token'];
}

void logout() {
  storage.remove('token');
}

bool isAuthenticated() {
  print(storage['token']);
  return storage['token'] != null;
}

void setFilial({EmpresaFilialModel? filial}) {
  FilialController filialController = FilialController();

  if (filial != null) {
    UsuarioModel usuario = UsuarioModel(idFilial: filial.id_filial);
    filialController.mudarFilialSelecionada(usuario);

    Map<String, dynamic> filialMap = filial.toJson();
    storage['filial'] = jsonEncode(filialMap);
  } else {
    UsuarioModel usuario = UsuarioModel(idFilial: 500);
    filialController.mudarFilialSelecionada(usuario);

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
