import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  String? baseUrl = dotenv.env['API_URL'];
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    //'Accept': 'application/json',
    //'Authorization': 'Bearer $token'
  };

  Future<dynamic> get(String endpoint) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response = await http.get(uri, headers: _headers);

    return response.body;
  }

  Future<dynamic> post(String endpoint, body) async {
    var uri = Uri.parse(baseUrl! + endpoint);
    var response =
        await http.post(uri, headers: _headers, body: jsonEncode(body));

    return response.body;
  }
}

var api = Api();
