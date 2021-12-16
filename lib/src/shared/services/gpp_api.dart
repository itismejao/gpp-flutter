import 'dart:async';
import 'dart:convert';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GppApi {
  String? baseUrl = dotenv.env['API_URL'];
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  String? getBaseUrl() {
    return baseUrl;
  }

  Map<String, String> getHeader() {
    if (isAuthenticated()) {
      String token = getToken();
      headers['Authorization'] = 'Bearer ' + token;
    } else {
      logout();
    }

    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    // ignore: avoid_print

    try {
      var uri = Uri.parse(baseUrl! + endpoint);
      var response = await http
          .get(uri, headers: getHeader())
          .timeout(const Duration(minutes: 1));

      return response;
    } on TimeoutException catch (aa) {
      // ignore: avoid_print
      print(aa.message);
      // throw TimeoutException("Erro de conexão com a API");
    }
  }

  Future<dynamic> post(String endpoint, body) async {
    try {
      var uri = Uri.parse(baseUrl! + endpoint);
      var response = await http
          .post(uri, headers: getHeader(), body: jsonEncode(body))
          .timeout(const Duration(minutes: 1));

      return response;
    } on TimeoutException {
      throw TimeoutException("Erro de conexão com a API");
    }
  }

  Future<dynamic> put(String endpoint, body) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response =
        await http.post(uri, headers: getHeader(), body: jsonEncode(body));

    return response;
  }
}

final gppApi = GppApi();
