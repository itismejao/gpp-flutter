import 'dart:convert';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  String? baseUrl = dotenv.env['API_URL'];
  final Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> getHeader() {
    if (isAuthenticated()) {
      String token = getToken();
      headers.addAll({'Authorization': 'Bearer ' + token});
    } else {
      logout();
    }

    return headers;
  }

  Future<dynamic> get(String endpoint) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response = await http.get(uri, headers: getHeader());

    return response.body;
  }

  Future<dynamic> post(String endpoint, body) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response =
        await http.post(uri, headers: getHeader(), body: jsonEncode(body));

    return response;
  }
}

var api = Api();
