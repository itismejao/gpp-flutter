import 'dart:convert';

import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:gpp/src/models/FuncionalidadeModel.dart';
import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';

class EnderecamentoRepository {
  ApiService api;


  EnderecamentoRepository({
    required this.api,
  });

    Future<List<PisoEnderecamentoModel>> buscarTodos() async {
    Response response = await api.get('/piso');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<PisoEnderecamentoModel> enderecamentoPiso = data
          .map<PisoEnderecamentoModel>(
              (data) => PisoEnderecamentoModel.fromJson(data))
          .toList();

      return enderecamentoPiso;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
 




  // Future<FuncionalidadeModel> fetch(String id) async {
  //   Response response = await api.get('/funcionalidades/' + id);

  //   if (response.statusCode == StatusCode.OK) {
  //     var data = jsonDecode(response.body);

  //     return FuncionalidadeModel.fromJson(data);
  //   } else {
  //     throw FuncionalitiesException("Funcionalidades não encontrada !");
  //   }
  // }

  // Future<List<FuncionalidadeModel>> fetchAll() async {
  //   Response response = await api.get('/funcionalidades');

  //   if (response.statusCode == StatusCode.OK) {
  //     var data = jsonDecode(response.body);

  //     List<FuncionalidadeModel> funcionalidades = data
  //         .map<FuncionalidadeModel>(
  //             (data) => FuncionalidadeModel.fromJson(data))
  //         .toList();

  //     return funcionalidades;
  //   } else {
  //     throw FuncionalitiesException("Funcionalidades não encontrada !");
  //   }
  // }

  // // Future<bool> create(FuncionalidadeModel funcionalitie) async {
  // //   print(jsonEncode(funcionalitie.toJson()));
  // //   Response response =
  // //       await api.post('/funcionalidades', funcionalitie.toJson()); // alteração

  // //   if (response.statusCode == StatusCode.OK) {
  // //     return true;
  // //   } else {
  // //     throw FuncionalitiesException("Funcionalidade não foi cadastrada !");
  // //   }
  // // }

  // // Future<bool> update(FuncionalidadeModel funcionalitie) async {
  // //   Response response = await api.put(
  // //       '/funcionalidades/' + funcionalitie.idFuncionalidade.toString(),
  // //       funcionalitie.toJson());

  // //   if (response.statusCode == StatusCode.OK) {
  // //     return true;
  // //   } else {
  // //     throw FuncionalitiesException("Funcionalidade não foi atualizada !");
  // //   }
  // // }

  // // Future<bool> delete(FuncionalidadeModel funcionalitie) async {
  // //   Response response = await api.delete(
  // //     '/funcionalidades/' + funcionalitie.idFuncionalidade.toString(),
  // //   );

  //   if (response.statusCode == StatusCode.OK) {
  //     return true;
  //   } else {
  //     throw FuncionalitiesException("Funcionalidade não foi deletada !");
  //   }
  // }
}
