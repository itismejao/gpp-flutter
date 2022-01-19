import 'dart:convert';


import 'package:gpp/src/models/asteca_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/shared/exceptions/asteca_exception.dart';

import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';
import 'package:http/http.dart';

import 'package:gpp/src/shared/repositories/status_code.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AstecaRepository {
  ApiService api;

  AstecaRepository({
    required this.api,
  });

  Future<AstecaModel> fetch(String id) async {
    Response response = await api.get('/astecas/' + id);

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      return AstecaModel.fromJson(data.first.first);
    } else {
      throw AstecaException("Não foi possível encontrar astecas !");
    }
  }

  Future<List<AstecaModel>> fetchAll() async {
    //######somente para o teste mocado############
    String dataReceived = ''' [
    [
        {
            "id": "288799876",
            "name": "Marcos Resende Coimbra",
            "filialvenda": "500",
            "notafiscal": "1238998878",
            "serie": "A001",
            "dataabertura": "18/10/2021",
            "defeito": "Porta Lateral esta com marcas de batida",
            "obs": "Deverá ser trocada todas as portas por conta do padrão de cores"
        },
        {
            "id": "2887232876",
            "name": "Maria Terezaa",
            "filialvenda": "501",
            "notafiscal": "1238932878",
            "serie": "223201",
            "dataabertura": "11/11/2021",
            "defeito": "Falta dos puxadores",
            "obs": "Enviar 12 puxadores do armário"
        },
        {
            "id": "1287799876",
            "name": "Luis Gonzaga",
            "filialvenda": "499",
            "notafiscal": "98758998878",
            "serie": "12221",
            "dataabertura": "12/12/2021",
            "defeito": "Espelho da porta central quebrado",
            "obs": "O espelho da porta esta quebrado"
        },
        {
            "id": "354799876",
            "name": "Ronaldo Nazario",
            "filialvenda": "500",
            "notafiscal": "787998878",
            "serie": "4589",
            "dataabertura": "01/01/2022",
            "defeito": "Tampo da gaveteiro esta quebrado",
            "obs": "Deverá ser trocada toda a gaveta do paneleiro"
        },
        {
            "id": "245699876",
            "name": "Frank aguiar",
            "filialvenda": "500",
            "notafiscal": "2658998878",
            "serie": "1201",
            "dataabertura": "04/01/2022",
            "defeito": "Fundo do armario esta menor do que o tamanho do armario",
            "obs": "Deverá ser trocada o fundo integral"
        },
        {
            "id": "988377676",
            "name": "Luiz figo",
            "filialvenda": "501",
            "notafiscal": "9775565878",
            "serie": "9676",
            "dataabertura": "09/01/2022",
            "defeito": "O estrado da Cama esta com farpas ponte agudas que furam o colchão",
            "obs": "Estrado deverá ser trocado"
        },
        {
            "id": "546659876",
            "name": "Arthur Antunes Coimbra",
            "filialvenda": "499",
            "notafiscal": "655665678",
            "serie": "A003",
            "dataabertura": "12/01/2022",
            "defeito": "Porta Esquerda Empenada",
            "obs": "Deverá ser trocada "
        },
        {
           "id": "268759876",
            "name": "Amarildo Luiz",
            "filialvenda": "500",
            "notafiscal": "900912878",
            "serie": "2201",
            "dataabertura": "18/01/2022",
            "defeito": "Porta Lateral esta empenada",
            "obs": "Deverá ser trocada todas as portas por conta do encaixe do movel"
        }
    ]
]''';
    //Response response = await api.get('/astecas');
    Response response = Response(dataReceived, 200);
    //#############################################

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<AstecaModel> Asteca = data.first
          .map<AstecaModel>((data) => AstecaModel.fromJson(data))
          .toList();
      return Asteca;
    } else {
      throw AstecaException("Não foi possível encontrar astecas !");
    }
  }

  Future<List<SubFuncionalitiesModel>> fetchSubFuncionalities(
      AstecaModel Asteca) async {
    Response response = await api.get(
        '/astecas/itensfuncionalidades/' + Asteca.id.toString());

    if (response.statusCode == StatusCode.OK) {
      var data = jsonDecode(response.body);

      List<SubFuncionalitiesModel> subFuncionalities = data.first
          .map<SubFuncionalitiesModel>(
              (data) => SubFuncionalitiesModel.fromJson(data))
          .toList();
      return subFuncionalities;
    } else {
      throw FuncionalitiesException(
          "Não foi possivel encontrar itens de funcionalidades relacionadas ao astecas !");
    }
  }

  Future<bool> updateDepartmentSubFuncionalities(AstecaModel Asteca,
      List<SubFuncionalitiesModel> subFuncionalities) async {
    List<Map<String, dynamic>> dataSend = subFuncionalities
        .map((subFuncionalitie) => subFuncionalitie.toJson())
        .toList();

    Response response = await api.put(
        '/astecas/itensfuncionalidades/' + Asteca.id.toString(),
        dataSend);

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      return throw AstecaException(
          "Funcionalidades do departamento foram atualizadas !");
    }
  }

  Future<bool> create(AstecaModel Asteca) async {
    Response response = await api.post('/astecas', Asteca.toJson());
    print(Asteca.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw AstecaException(error);
    }
  }

  Future<bool> delete(AstecaModel Asteca) async {
    Response response = await api.delete(
      '/astecas/' + Asteca.id.toString(),
    );

    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      var error = json.decode(response.body)['error'];
      throw AstecaException(error);
    }
  }

  Future<bool> update(AstecaModel Asteca) async {
    Response response = await api.put(
        '/astecas/' + Asteca.id.toString(), Asteca.toJson());

    print(Asteca.toJson());
    if (response.statusCode == StatusCode.OK) {
      return true;
    } else {
      throw AstecaException("Departamento não foi atualizado!");
    }
  }
}
