import 'dart:convert';

import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
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

      List<PisoEnderecamentoModel> enderecamentoPiso =
          data.map<PisoEnderecamentoModel>((data) => PisoEnderecamentoModel.fromJson(data)).toList();

      return enderecamentoPiso;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }

    
  }

  Future<List<CorredorEnderecamentoModel>> buscarCorredor(String idPiso) async {
    Response response = await api.get('/piso/' + idPiso + '/corredor');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<CorredorEnderecamentoModel> enderecamentoCorredor =
          data.map<CorredorEnderecamentoModel>((data) => CorredorEnderecamentoModel.fromJson(data)).toList();

      return enderecamentoCorredor;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<EstanteEnderecamentoModel>> buscarEstante(String idCorredor) async {
    Response response = await api.get('/piso/10/corredor/' + idCorredor + '/estante');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<EstanteEnderecamentoModel> enderecamentoEstante =
          data.map<EstanteEnderecamentoModel>((data) => EstanteEnderecamentoModel.fromJson(data)).toList();

      return enderecamentoEstante;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<PrateleiraEnderecamentoModel>> buscarPrateleira(String idEstante) async {
    Response response = await api.get('/piso/10/corredor/10/estante/' + idEstante + '/prateleira');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<PrateleiraEnderecamentoModel> enderecamentoPrateleira =
          data.map<PrateleiraEnderecamentoModel>((data) => PrateleiraEnderecamentoModel.fromJson(data)).toList();

      return enderecamentoPrateleira;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<BoxEnderecamentoModel>> buscarBox(String idPrateleira) async {
    Response response = await api.get('/piso/10/corredor/10/estante/10/prateleira/' + idPrateleira + '/box');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<BoxEnderecamentoModel> enderecamentoBox =
          data.map<BoxEnderecamentoModel>((data) => BoxEnderecamentoModel.fromJson(data)).toList();

      return enderecamentoBox;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  // excluir e criar Piso

  Future<bool> excluir(PisoEnderecamentoModel pisoModelo) async {
    Response response = await api.delete('/piso/' + pisoModelo.id_piso.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
    Future<bool> criar(PisoEnderecamentoModel pisos) async {
    print(jsonEncode(pisos.toJson()));
    Response response = await api.post('/piso', pisos.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar um piso';
    }
  }

  // excluir e criar Corredor

  Future<bool> excluirCorredor(CorredorEnderecamentoModel corredorModelo) async {
    Response response = await api.delete('/piso/00/corredor/' + corredorModelo.id_corredor.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
    
   Future<bool> criarCorredor(CorredorEnderecamentoModel corredor, String idPiso) async {
    print(jsonEncode(corredor.toJson()));
    Response response = await api.post('/piso/'+ idPiso +'/corredor', corredor.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar um coredor';
    }
   }

   // excluir e criar Estante

  Future<bool> excluirEstate(EstanteEnderecamentoModel estanteModelo) async {
    Response response = await api.delete('/piso/00/corredor/' + estanteModelo.id_corredor.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }
    
   Future<bool> criarEstante(EstanteEnderecamentoModel estanteModelo, String idCorredor) async {
    print(jsonEncode(estanteModelo.toJson()));
    Response response = await api.post('/piso/00/corredor/'+ idCorredor +'/estante', estanteModelo.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar um coredor';
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

