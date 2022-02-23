import 'dart:convert';

import 'package:gpp/src/models/AutenticacaoModel.dart';
import 'package:gpp/src/models/user_model.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:gpp/src/shared/utils/Usuario.dart';
import 'package:http/http.dart';

class AutenticacaoRepository {
  String path = '/autenticacao';

  ApiService api = gppApi;

  Future<bool> criar(AutenticacaoModel autenticacao) async {
    Response response = await api.post(path, autenticacao.toJson());

    if (response.statusCode == StatusCode.OK) {
      usuario = UsuarioModel.fromJson(jsonDecode(response.body));

      //Seta token
      setToken(usuario.accessToken!);
      // authenticateUser = authenticate;

      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}
