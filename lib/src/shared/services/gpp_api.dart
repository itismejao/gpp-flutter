import 'dart:async';
import 'dart:convert';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ApiService {
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

  Future<Response> get(String endpoint) async {
    // ignore: avoid_print

    try {
      var uri = Uri.parse(baseUrl! + endpoint);
      Response response = await http
          .get(uri, headers: getHeader())
          .timeout(const Duration(seconds: 30));

      return response;
    } on TimeoutException {
      throw TimeoutException("Tempo de conexão excedido");
    }
  }

  Future<dynamic> post(String endpoint, body) async {
    try {
      var uri = Uri.parse(baseUrl! + endpoint);
      var response = await http
          .post(uri, headers: getHeader(), body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));

      return response;
    } on TimeoutException {
      throw TimeoutException("Tempo de conexão excedido");
    }
  }

  Future<dynamic> put(String endpoint, body) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response =
        await http.put(uri, headers: getHeader(), body: json.encode(body));

    return response;
  }

  Future<dynamic> delete(String endpoint) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response = await http.delete(uri, headers: getHeader());

    return response;
  }
}

final gppApi = ApiService();
