// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpp/src/models/asteca_model.dart';

import 'package:gpp/src/repositories/astecas_repository.dart';

import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  dotenv.testLoad(fileInput: File("env").readAsStringSync());

  final api = MockApiService();
  final repository = AstecaRepository(api: api);

  group('Astecas: ', () {
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

    test('Verifica a busca de Astecas', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 200));
      final asteca = await repository.fetchAll();
      expect(asteca, isA<List<AstecaModel>>());
    });
  });
}
