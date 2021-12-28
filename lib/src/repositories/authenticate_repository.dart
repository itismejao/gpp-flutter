import 'dart:convert';

import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';
import 'package:gpp/src/shared/repositories/global.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AuthenticateRepository {
  Future<bool> doLogin(UserModel user) async {
    try {
      var response = await gppApi.post('/user/login', user.toJson());

      if (response.statusCode == StatusCode.UNAUTHORIZED) {
        //var error = jsonDecode(response.body)['error'];
        throw AuthenticationException('Usuário ou senha incorretos !');
      }

      if (response.statusCode == StatusCode.OK) {
        AuthenticateModel authenticate =
            AuthenticateModel.fromJson(jsonDecode(response.body));

        //Seta token
        setToken(authenticate.accessToken);

        authenticateUser = authenticate;
        return true;
      }

      return false;
    } on AuthenticationException {
      rethrow;
    }
  }
}
