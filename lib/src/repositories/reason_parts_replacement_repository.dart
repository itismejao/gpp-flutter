import 'dart:convert';

import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class ReasonPartsReplacementRepository {
  ApiService api;
  String endpoint = '/parts-reason-replacement';

  ReasonPartsReplacementRepository({
    required this.api,
  });

  Future<List<ReasonPartsReplacementModel>> fetchAll() async {
    Response response = await api.get(endpoint);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<ReasonPartsReplacementModel> reasonPartsReplacement = data.first
          .map<ReasonPartsReplacementModel>(
              (data) => ReasonPartsReplacementModel.fromJson(data))
          .toList();

      return reasonPartsReplacement;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> create(
      ReasonPartsReplacementModel reasonPartsReplacement) async {
    Response response =
        await api.post(endpoint, reasonPartsReplacement.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> update(
      ReasonPartsReplacementModel reasonPartsReplacement) async {
    Response response = await api.put(
        endpoint + '/' + reasonPartsReplacement.id.toString(),
        reasonPartsReplacement.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> delete(
      ReasonPartsReplacementModel reasonPartsReplacement) async {
    Response response = await api.delete(
      endpoint + '/' + reasonPartsReplacement.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
}
