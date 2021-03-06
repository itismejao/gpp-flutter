import 'dart:async';
import 'dart:convert';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/views/autenticacao/AutenticacaoView.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:get/get.dart';

class ApiService {
  late String? baseUrl;
  late Map<String, String> headers;

  ApiService() {
    baseUrl = dotenv.env['API_URL'];
    headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
  }

  String? getBaseUrl() {
    return baseUrl;
  }

  Map<String, String> getHeader() {
    if (isAuthenticated()) {
      String? token = getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer ' + token;
      }
    } else {
      logout();
    }

    return headers;
  }

  Future<http.Response> get(String endpoint,
      {Map<String, String>? queryParameters}) async {
    try {
      var uri = Uri.parse(baseUrl! + endpoint)
          .replace(queryParameters: queryParameters);

      http.Response response = await http
          .get(uri, headers: getHeader())
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == StatusCode.UNAUTHORIZED) {
        logout();

        Get.to(AutenticacaoView());
      }

      return response;
    } on TimeoutException {
      throw TimeoutException("Tempo de conexão excedido");
    }
  }

  Future<dynamic> post(String path, body) async {
    try {
      var uri = Uri.parse(baseUrl! + path);
      var response = await http
          .post(uri, headers: getHeader(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == StatusCode.UNAUTHORIZED) {
        logout();
        Get.to(AutenticacaoView());
      }

      return response;
    } on TimeoutException {
      throw TimeoutException("Tempo de conexão excedido");
    }
  }

  Future<dynamic> put(String endpoint, body) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response =
        await http.put(uri, headers: getHeader(), body: jsonEncode(body));

    if (response.statusCode == StatusCode.UNAUTHORIZED) {
      logout();
      Get.to(AutenticacaoView());
    }

    return response;
  }

  Future<dynamic> delete(String endpoint) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response = await http.delete(uri, headers: getHeader());

    if (response.statusCode == StatusCode.UNAUTHORIZED) {
      logout();
      Get.to(AutenticacaoView());
    }

    return response;
  }
}
