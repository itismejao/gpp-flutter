import 'dart:convert';

import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';

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

  Future<List<CorredorEnderecamentoModel>> buscarCorredor(String idPiso) async {
    Response response = await api.get('/piso/' + idPiso + '/corredor');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<CorredorEnderecamentoModel> enderecamentoCorredor = data
          .map<CorredorEnderecamentoModel>(
              (data) => CorredorEnderecamentoModel.fromJson(data))
          .toList();

      return enderecamentoCorredor;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<EstanteEnderecamentoModel>> buscarEstante(
      String idCorredor) async {
    Response response =
        await api.get('/piso/10/corredor/' + idCorredor + '/estante');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<EstanteEnderecamentoModel> enderecamentoEstante = data
          .map<EstanteEnderecamentoModel>(
              (data) => EstanteEnderecamentoModel.fromJson(data))
          .toList();

      return enderecamentoEstante;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<PrateleiraEnderecamentoModel>> buscarPrateleira(
      String idEstante) async {
    Response response = await api
        .get('/piso/10/corredor/10/estante/' + idEstante + '/prateleira');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);
      print(data);

      List<PrateleiraEnderecamentoModel> enderecamentoPrateleira = data
          .map<PrateleiraEnderecamentoModel>(
              (data) => PrateleiraEnderecamentoModel.fromJson(data))
          .toList();

      return enderecamentoPrateleira;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<List<BoxEnderecamentoModel>> buscarBox(String idPrateleira) async {
    Response response = await api.get(
        '/piso/00/corredor/00/estante/00/prateleira/' + idPrateleira + '/box');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      print(data);

      List<BoxEnderecamentoModel> enderecamentoBox = data
          .map<BoxEnderecamentoModel>(
              (data) => BoxEnderecamentoModel.fromJson(data))
          .toList();

      return enderecamentoBox;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  // excluir e criar Piso

  Future<bool> excluir(PisoEnderecamentoModel pisoModelo) async {
    Response response =
        await api.delete('/piso/' + pisoModelo.id_piso.toString());

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

  Future<bool> editar(PisoEnderecamentoModel pisos) async {
    //print(jsonEncode(pisos.toJson()));

    Response response =
        await api.put('/piso/' + pisos.id_piso.toString(), pisos.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro o piso';
    }
  }

  // excluir e criar Corredor

  Future<bool> excluirCorredor(
      CorredorEnderecamentoModel corredorModelo) async {
    Response response = await api
        .delete('/piso/00/corredor/' + corredorModelo.id_corredor.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> criarCorredor(
      CorredorEnderecamentoModel corredor, String idPiso) async {
    print(jsonEncode(corredor.toJson()));
    Response response =
        await api.post('/piso/' + idPiso + '/corredor', corredor.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar um corredor';
    }
  }

  Future<bool> editarCorredor(CorredorEnderecamentoModel corredorModelo) async {
    //print(jsonEncode(pisos.toJson()));

    Response response = await api.put(
        '/piso/00/corredor/' + corredorModelo.id_corredor.toString(),
        corredorModelo.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar o corredor';
    }
  }

  // excluir e criar Estante

  Future<bool> excluirEstate(
      EstanteEnderecamentoModel estanteEnderecamentoModel) async {
    Response response = await api.delete('/piso/00/corredor/00/estante/' +
        estanteEnderecamentoModel.id_estante.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> criarEstante(EstanteEnderecamentoModel estanteEnderecamentoModel,
      String idCorredor) async {
    print(jsonEncode(estanteEnderecamentoModel.toJson()));
    Response response = await api.post(
        '/piso/00/corredor/' + idCorredor + '/estante',
        estanteEnderecamentoModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar uma Estante';
    }
  }

  Future<bool> editarEstante(EstanteEnderecamentoModel estanteModelo) async {
    //print(jsonEncode(pisos.toJson()));

    Response response = await api.put(
        '/piso/00/corredor/00/estante/' + estanteModelo.id_estante.toString(),
        estanteModelo.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar a estante';
    }
  }

  // Prateleira

  Future<bool> excluirPrateleira(
      PrateleiraEnderecamentoModel prateleiraEnderecamentoModel) async {
    Response response = await api.delete(
        '/piso/00/corredor/00/estante/00/prateleira/' +
            prateleiraEnderecamentoModel.id_prateleira.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> criarPrateleira(
      PrateleiraEnderecamentoModel prateleiraEnderecamentoModel,
      String idEstante) async {
    print(jsonEncode(prateleiraEnderecamentoModel.toJson()));
    Response response = await api.post(
        '/piso/00/corredor/00/estante/' + idEstante + '/prateleira',
        prateleiraEnderecamentoModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar uma Prateleira';
    }
  }

  Future<bool> editarPrateleira(
      PrateleiraEnderecamentoModel prateleiraModelo) async {
    //print(jsonEncode(pisos.toJson()));

    Response response = await api.put(
        '/piso/00/corredor/00/estante/' +
            prateleiraModelo.id_prateleira.toString(),
        prateleiraModelo.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar a prateleira';
    }
  }

  // Box

  Future<bool> excluirBox(BoxEnderecamentoModel boxEnderecamentoModel) async {
    Response response = await api.delete(
        '/piso/00/corredor/00/estante/00/prateleira/00/box/' +
            boxEnderecamentoModel.id_box.toString());

    if (response.statusCode == StatusCode.OK) {
      print(response.body);
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<bool> criarBox(
      BoxEnderecamentoModel boxEnderecamentoModel, String idPrateleira) async {
    print(jsonEncode(boxEnderecamentoModel.toJson()));
    Response response = await api.post(
        '/piso/00/corredor/00/estante/00/prateleira/' + idPrateleira + '/box',
        boxEnderecamentoModel.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao criar um Box';
    }
  }

  Future<bool> editarBox(BoxEnderecamentoModel BoxModelo) async {
    //print(jsonEncode(pisos.toJson()));

    Response response = await api.put(
        '/piso/00/corredor/00/estante/00/prateleira/00/box/' +
            BoxModelo.id_box.toString(),
        BoxModelo.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw 'Ocorreu um erro ao editar o Box';
    }
  }
}
