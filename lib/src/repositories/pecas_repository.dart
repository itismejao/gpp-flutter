import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class PecasRepository {
  ApiService api;

  PecasRepository({
    required this.api,
  });

  Future<bool> create(PecasModel pecas) async {
    Response response = await api.postTeste('/create', pecas.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Deu erro no create';
    }
  }
}
