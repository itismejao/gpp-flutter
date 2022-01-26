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
            "salebranch": "500",
            "invoice": "1238998878",
            "series": "A001",
            "opendate": "18/10/2021",
            "defect": "Porta Lateral esta com marcas de batida",
            "note": "Deverá ser trocada todas as portas por conta do padrão de cores",
            "signal": "red"
        },
        {
            "id": "2887232876",
            "name": "Maria Terezaa",
            "salebranch": "501",
            "invoice": "1238932878",
            "series": "223201",
            "opendate": "11/11/2021",
            "defect": "Falta dos puxadores",
            "note": "Enviar 12 puxadores do armário",
            "signal": "red"
        },
        {
            "id": "1287799876",
            "name": "Luis Gonzaga",
            "salebranch": "499",
            "invoice": "98758998878",
            "series": "12221",
            "opendate": "12/12/2021",
            "defect": "Espelho da porta central quebrado",
            "note": "O espelho da porta esta quebrado",
            "signal": "red"
        },
        {
            "id": "354799876",
            "name": "Ronaldo Nazario",
            "salebranch": "500",
            "invoice": "787998878",
            "series": "4589",
            "opendate": "01/01/2022",
            "defect": "Tampo da gaveteiro esta quebrado",
            "note": "Deverá ser trocada toda a gaveta do paneleiro",
            "signal": "yellow"
        },
        {
            "id": "245699876",
            "name": "Frank aguiar",
            "salebranch": "500",
            "invoice": "2658998878",
            "series": "1201",
            "opendate": "04/01/2022",
            "defect": "Fundo do armario esta menor do que o tamanho do armario",
            "note": "Deverá ser trocada o fundo integral",
            "signal": "yellow"
        },
        {
            "id": "988377676",
            "name": "Luiz figo",
            "salebranch": "501",
            "invoice": "9775565878",
            "series": "9676",
            "opendate": "03/01/2022",
            "defect": "O estrado da Cama esta com farpas ponte agudas que furam o colchão",
            "note": "Estrado deverá ser trocado",
            "signal": "yellow"
        },
        {
            "id": "546659876",
            "name": "Arthur Antunes Coimbra",
            "salebranch": "499",
            "invoice": "655665678",
            "series": "A003",
            "opendate": "12/01/2022",
            "defect": "Porta Esquerda Empenada",
            "note": "Deverá ser trocada ",
            "signal": "green"
        },
        {
           "id": "268759876",
            "name": "Amarildo Luiz",
            "salebranch": "500",
            "invoice": "900912878",
            "series": "2201",
            "opendate": "18/01/2022",
            "defect": "Porta Lateral esta empenada",
            "note": "Deverá ser trocada todas as portas por conta do encaixe do movel",
            "signal": "green"
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
