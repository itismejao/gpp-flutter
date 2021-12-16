import 'dart:async';
import 'dart:convert';

import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/models/token_model.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AuthenticateController {
  Future<AuthenticateModel> login(uid, password) async {
    try {
      var response =
          await gppApi.post('/user/login', {'uid': uid, 'password': password});

      if (response.statusCode == StatusCode.UNAUTHORIZED) {
        var error = jsonDecode(response.body)['error'];
        throw AuthenticationException(error);
      }

      return AuthenticateModel.fromJson(jsonDecode(response.body));
    } on AuthenticationException {
      rethrow;
    }
  }

  Future<TokenModel> createToken(email, password) async {
    var response = await gppApi
        .post('/user/token', {'email': email, 'password': password});

    try {
      if (response.statusCode == 401) {
        throw ("Usuário não possui token disponível");
      }
      return TokenModel.fromJson(jsonDecode(response.body));
    } catch (error) {
      rethrow;
    }
  }
}
