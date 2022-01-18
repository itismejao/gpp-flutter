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
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';
import 'package:gpp/src/repositories/astecas_repository.dart';
import 'package:gpp/src/shared/exceptions/asteca_exception.dart';

import 'package:gpp/src/shared/exceptions/departament_exception.dart';
import 'package:gpp/src/shared/exceptions/funcionalities_exception.dart';

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
            "id": "1",
            "description": "Tecnologia",
            "active": "1",
     
            "created_at": "2021-12-24 17:05:12",
            "updated_at": "2021-12-24 17:07:05"
        },
        {
            "id": "2",
            "description": "Gerência",
            "active": "0",
   
            "created_at": "2021-12-24 17:05:36",
            "updated_at": "2021-12-24 17:05:36"
        },
        {
            "id": "4",
            "description": "Asteca",
            "active": "0",
   
            "created_at": "2021-12-24 17:05:51",
            "updated_at": "2021-12-24 17:05:51"
        },
        {
            "id": "5",
            "description": "Estoque",
            "active": "0",
           
            "created_at": "2021-12-24 17:05:57",
            "updated_at": "2021-12-24 17:05:57"
        },
        {
            "id": "6",
            "description": "Expedição",
            "active": "0",
        
            "created_at": "2021-12-24 17:06:08",
            "updated_at": "2021-12-24 17:06:08"
        }
    ]
]''';

    test('Verifica a busca de usuários', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 200));
      final asteca = await repository.fetchAll();
      expect(asteca, isA<List<AstecaModel>>());
    });

    test('Valida se não foi possível realizar a busca de departamentos',
        () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 404));

      expect(() async => await repository.fetchAll(),
          throwsA(isA<AstecaException>()));
    });
  });

  group('Departamentos e Funcionalidades: ', () {
    String dataReceived = '''[
    [
        {
            "id": "5",
            "name": "Funcionalidades",
            "active": 1,
            "idregister": "33"
        },
        {
            "id": "8",
            "name": "Peças",
            "active": 1,
            "idregister": "37"
        },
        {
            "id": "9",
            "name": "Endereços",
            "active": 0,
            "idregister": null
        },
        {
            "id": "10",
            "name": "Movimentos",
            "active": 0,
            "idregister": null
        },
        {
            "id": "11",
            "name": "Manutenção",
            "active": 1,
            "idregister": "25"
        },
        {
            "id": "12",
            "name": "Solicitados",
            "active": 1,
            "idregister": "6"
        },
        {
            "id": "12",
            "name": "Solicitados",
            "active": 1,
            "idregister": "26"
        },
        {
            "id": "13",
            "name": "Cancelados",
            "active": 1,
            "idregister": "27"
        },
        {
            "id": "14",
            "name": "Departamentos",
            "active": 0,
            "idregister": null
        },
        {
            "id": "15",
            "name": "Menus",
            "active": 1,
            "idregister": "28"
        },
        {
            "id": "16",
            "name": "Itens do menu",
            "active": 1,
            "idregister": "29"
        },
        {
            "id": "21",
            "name": "Usuários",
            "active": 0,
            "idregister": null
        },
        {
            "id": "22",
            "name": "Departamento",
            "active": 0,
            "idregister": null
        }
    ]
]''';

    test('Valida busca de funcionalidades relacionadas ao departamento',
        () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 200));

      AstecaModel asteca = AstecaModel(
          id: 1,
          name: "Tecnologia",
          active: true,
          createdAt: "2021-12-24 17:05:12",
          updatedAt: "2021-12-24 17:05:12");

      final subFucionalities =
          await repository.fetchSubFuncionalities(asteca);

      expect(subFucionalities, isA<List<SubFuncionalitiesModel>>());
    });

    test(
        'Verifica se não foi realizada a busca de funcionalidades relacionadas ao departamento',
        () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response('', 404));

      AstecaModel asteca = AstecaModel(
          id: 1,
          name: "Tecnologia",
          active: true,
          createdAt: "2021-12-24 17:05:12",
          updatedAt: "2021-12-24 17:05:12");

      expect(() async => await repository.fetchSubFuncionalities(asteca),
          throwsA(isA<FuncionalitiesException>()));
    });
  });

  group('Departamento atualização: ', () {
    test(
        'Valida se a lista de funcionalidades relacionadas ao departamento foi atualizada',
        () async {
      when(api.put(any, any))
          .thenAnswer((realInvocation) async => Response('', 200));

      AstecaModel asteca = AstecaModel(
          id: 1,
          name: "Tecnologia",
          active: true,
          createdAt: "2021-12-24 17:05:12",
          updatedAt: "2021-12-24 17:05:12");

      List<SubFuncionalitiesModel> subFuncionalities = [
        SubFuncionalitiesModel(
            id: 5, name: "Funcionalidades", active: true, idRegister: "33")
      ];

      final response = await repository.updateDepartmentSubFuncionalities(
          asteca, subFuncionalities);

      expect(response, true);
    });

    test(
        'Valida se a lista de funcionalidades relacionadas ao departamento não foi atualizada',
        () async {
      when(api.put(any, any))
          .thenAnswer((realInvocation) async => Response('', 404));

      AstecaModel asteca = AstecaModel(
          id: 1,
          name: "Tecnologia",
          active: true,
          createdAt: "2021-12-24 17:05:12",
          updatedAt: "2021-12-24 17:05:12");

      List<SubFuncionalitiesModel> subFuncionalities = [
        SubFuncionalitiesModel(
            name: "Funcionalidades", active: true, idRegister: "33")
      ];

      expect(
          () async => await repository.updateDepartmentSubFuncionalities(
              asteca, subFuncionalities),
          throwsA(isA<AstecaException>()));
    });
  });
}
