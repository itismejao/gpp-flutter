import 'dart:convert';

import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/AstecaModel.dart';
import 'package:gpp/src/models/asteca_tipo_pendencia_model.dart';

import 'package:http/http.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AstecaRepository {
  ApiService api = gppApi;
  String endpoint = '/asteca';
  PendenciaRepository pendencia = PendenciaRepository();

  Future<AstecaModel> buscar(int id) async {
    Response response = await api.get(endpoint + '/' + id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return AstecaModel.fromJson(data);
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<List> buscarTodas(int pagina,
      {AstecaModel? filtroAsteca,
      String? pendencia,
      DateTime? dataInicio,
      DateTime? dataFim}) async {
    Map<String, String> queryParameters = {
      'pagina': pagina.toString(),
      'idAsteca': filtroAsteca?.idAsteca ?? '',
      'cpfCnpj': filtroAsteca?.documentoFiscal?.cpfCnpj?.toString() ?? '',
      'numeroNotaFiscalVenda':
          filtroAsteca?.documentoFiscal?.numDocFiscal?.toString() ?? '',
      'pendencia': pendencia?.toString() ?? '',
      'dataInicio': dataInicio != null ? dataInicio.toString() : '',
      'dataFim': dataFim != null ? dataFim.toString() : ''
    };

    Response response =
        await api.get(endpoint, queryParameters: queryParameters);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaModel> astecas = data['astecas']
          .map<AstecaModel>((data) => AstecaModel.fromJson(data))
          .toList();

      //Obtém a pagina
      PaginaModel pagina = PaginaModel.fromJson(data['pagina']);
      return [astecas, pagina];
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }

  // Future<AstecaModel> fetch(String id) async {
  //   Response response = await api.get('/astecas/' + id);

  //   if (response.statusCode == StatusCode.OK) {
  //     var data = jsonDecode(response.body);

  //     return AstecaModel.fromJson(data.first.first);
  //   } else {
  //     throw AstecaException("Não foi possível encontrar astecas !");
  //   }
  // }

//   Future<List<AstecaModel>> fetchAll() async {
// //     //######somente para o teste mocado############
// //     String dataReceived = ''' [
// //     [
// //         {
// //             "id": "288799876",
// //             "name": "Marcos Resende Coimbra",
// //             "salebranch": "500",
// //             "invoice": "1238998878",
// //             "series": "A001",
// //             "opendate": "18/10/2021",
// //             "defect": "Porta Lateral esta com marcas de batida",
// //             "note": "Deverá ser trocada todas as portas por conta do padrão de cores",
// //             "signal": "red"
// //         },
// //         {
// //             "id": "2887232876",
// //             "name": "Maria Terezaa",
// //             "salebranch": "501",
// //             "invoice": "1238932878",
// //             "series": "223201",
// //             "opendate": "11/11/2021",
// //             "defect": "Falta dos puxadores",
// //             "note": "Enviar 12 puxadores do armário",
// //             "signal": "red"
// //         },
// //         {
// //             "id": "1287799876",
// //             "name": "Luis Gonzaga",
// //             "salebranch": "499",
// //             "invoice": "98758998878",
// //             "series": "12221",
// //             "opendate": "12/12/2021",
// //             "defect": "Espelho da porta central quebrado",
// //             "note": "O espelho da porta esta quebrado",
// //             "signal": "red"
// //         },
// //         {
// //             "id": "354799876",
// //             "name": "Ronaldo Nazario",
// //             "salebranch": "500",
// //             "invoice": "787998878",
// //             "series": "4589",
// //             "opendate": "01/01/2022",
// //             "defect": "Tampo da gaveteiro esta quebrado",
// //             "note": "Deverá ser trocada toda a gaveta do paneleiro",
// //             "signal": "yellow"
// //         },
// //         {
// //             "id": "245699876",
// //             "name": "Frank aguiar",
// //             "salebranch": "500",
// //             "invoice": "2658998878",
// //             "series": "1201",
// //             "opendate": "04/01/2022",
// //             "defect": "Fundo do armario esta menor do que o tamanho do armario",
// //             "note": "Deverá ser trocada o fundo integral",
// //             "signal": "yellow"
// //         },
// //         {
// //             "id": "988377676",
// //             "name": "Luiz figo",
// //             "salebranch": "501",
// //             "invoice": "9775565878",
// //             "series": "9676",
// //             "opendate": "03/01/2022",
// //             "defect": "O estrado da Cama esta com farpas ponte agudas que furam o colchão",
// //             "note": "Estrado deverá ser trocado",
// //             "signal": "yellow"
// //         },
// //         {
// //             "id": "546659876",
// //             "name": "Arthur Antunes Coimbra",
// //             "salebranch": "499",
// //             "invoice": "655665678",
// //             "series": "A003",
// //             "opendate": "12/01/2022",
// //             "defect": "Porta Esquerda Empenada",
// //             "note": "Deverá ser trocada ",
// //             "signal": "green"
// //         },
// //         {
// //            "id": "268759876",
// //             "name": "Amarildo Luiz",
// //             "salebranch": "500",
// //             "invoice": "900912878",
// //             "series": "2201",
// //             "opendate": "18/01/2022",
// //             "defect": "Porta Lateral esta empenada",
// //             "note": "Deverá ser trocada todas as portas por conta do encaixe do movel",
// //             "signal": "green"
// //         }
// //     ]
// // ]''';
// //     //Response response = await api.get('/astecas');
// //     Response response = Response(dataReceived, 200);
// //     //#############################################

// //     if (response.statusCode == StatusCode.OK) {
// //       var data = jsonDecode(response.body);

// //       List<AstecaModel> Asteca = data.first
// //           .map<AstecaModel>((data) => AstecaModel.fromJson(data))
// //           .toList();
// //       return Asteca;
// //     } else {
// //       throw AstecaException("Não foi possível encontrar astecas !");
// //     }
// //   }

// //   Future<List<SubFuncionalitiesModel>> fetchSubFuncionalities(
// //       AstecaModel Asteca) async {
// //     Response response = await api.get(
// //         '/astecas/itensfuncionalidades/' + Asteca.id.toString());

// //     if (response.statusCode == StatusCode.OK) {
// //       var data = jsonDecode(response.body);

// //       List<SubFuncionalitiesModel> subFuncionalities = data.first
// //           .map<SubFuncionalitiesModel>(
// //               (data) => SubFuncionalitiesModel.fromJson(data))
// //           .toList();
// //       return subFuncionalities;
// //     } else {
// //       throw FuncionalitiesException(
// //           "Não foi possivel encontrar itens de funcionalidades relacionadas ao astecas !");
// //     }
// //   }

// //   Future<bool> updateDepartmentSubFuncionalities(AstecaModel Asteca,
// //       List<SubFuncionalitiesModel> subFuncionalities) async {
// //     List<Map<String, dynamic>> dataSend = subFuncionalities
// //         .map((subFuncionalitie) => subFuncionalitie.toJson())
// //         .toList();

// //     Response response = await api.put(
// //         '/astecas/itensfuncionalidades/' + Asteca.id.toString(),
// //         dataSend);

// //     if (response.statusCode == StatusCode.OK) {
// //       return true;
// //     } else {
// //       return throw AstecaException(
// //           "Funcionalidades do departamento foram atualizadas !");
// //     }
// //   }

// //   Future<bool> create(AstecaModel Asteca) async {
// //     Response response = await api.post('/astecas', Asteca.toJson());
// //     print(Asteca.toJson());
// //     if (response.statusCode == StatusCode.OK) {
// //       return true;
// //     } else {
// //       var error = json.decode(response.body)['error'];
// //       throw AstecaException(error);
// //     }
// //   }

// //   Future<bool> delete(AstecaModel Asteca) async {
// //     Response response = await api.delete(
// //       '/astecas/' + Asteca.id.toString(),
// //     );

// //     if (response.statusCode == StatusCode.OK) {
// //       return true;
// //     } else {
// //       var error = json.decode(response.body)['error'];
// //       throw AstecaException(error);
// //     }
// //   }

// //   Future<bool> update(AstecaModel Asteca) async {
// //     Response response = await api.put(
// //         '/astecas/' + Asteca.id.toString(), Asteca.toJson());

// //     print(Asteca.toJson());
// //     if (response.statusCode == StatusCode.OK) {
// //       return true;
// //     } else {
// //       throw AstecaException("Departamento não foi atualizado!");
// //     }
// //   }
}

class PendenciaRepository {
  ApiService api = gppApi;

  Future<List<AstecaTipoPendenciaModel>> buscarPendencias() async {
    Response response = await api.get('/asteca' + '/pendencia');

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaTipoPendenciaModel> astecaTipoPendencia = data
          .map<AstecaTipoPendenciaModel>(
              (data) => AstecaTipoPendenciaModel.fromJson(data))
          .toList();
      return astecaTipoPendencia;
    } else {
      var error = jsonDecode(response.body)['error'];
      throw error;
    }
  }

  Future<bool> criar(
      AstecaModel asteca, AstecaTipoPendenciaModel pendencia) async {
    Response response = await api.post(
        '/asteca/${asteca.idAsteca}/pendencia', pendencia.toJson());

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw error;
    }
  }
}
