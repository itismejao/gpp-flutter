// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/subfuncionalities_model.dart';

import 'package:gpp/src/repositories/subfuncionalities_repository.dart';
import 'package:gpp/src/shared/exceptions/subfuncionalities_exception.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  dotenv.testLoad(fileInput: File("env").readAsStringSync());

  final api = MockApiService();
  final repository = SubFuncionalitiesRepository(api: api);

  group('SubFuncionalidades - Buscar: ', () {
    String dataReceived = '''[
    [
        {
            "id": "5",
            "idfunc": "2",
            "name": "Funcionalidades",
            "routes": "/funcionalidades",
            "active": "1",
            "icon": "add_a_photo",

        }
    ]
    ]''';
    FuncionalitieModel funcionalitie = FuncionalitieModel(id: 5);
    test('Valida a busca de subfuncionalidades', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 200));

      final subfuncionalities = await repository.fetch(funcionalitie);
      expect(subfuncionalities, isA<List<SubFuncionalitiesModel>>());
    });

    test('Valida se as subfuncionalidades não foram encontradas', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response('', 404));

      expect(() async => await repository.fetch(funcionalitie),
          throwsA(isA<SubFuncionalitiesException>()));
    });
  });

  group('Funcionalidades - Criação: ', () {
    FuncionalitieModel funcionalitie = FuncionalitieModel(id: 5);
    SubFuncionalitiesModel subFuncionalitie = SubFuncionalitiesModel(
        name: "Teste", route: "/teste", icon: "home_work", active: false);

    test('Valida a criação de subfuncionalidade relacionada a funcionalidade',
        () async {
      when(api.post(any, any))
          .thenAnswer((realInvocation) async => Response('', 200));

      expect(await repository.create(funcionalitie, subFuncionalitie), true);
    });

    test(
        'Valida se a subfuncionalidade relacionada a funcionalidade não foi cadastrada',
        () async {
      when(api.post(any, any))
          .thenAnswer((realInvocation) async => Response('', 404));

      expect(
          () async => await repository.create(funcionalitie, subFuncionalitie),
          throwsA(isA<SubFuncionalitiesException>()));
    });
  });

  group('Funcionalidades - Atualização: ', () {
    SubFuncionalitiesModel subFuncionalitie = SubFuncionalitiesModel(
        id: 22, name: "Teste", route: "/teste", icon: "home_work");

    test('Valida se a funcionalidade foi atualizada', () async {
      when(api.put(any, any))
          .thenAnswer((realInvocation) async => Response('', 200));

      expect(await repository.update(subFuncionalitie), true);
    });

    test('Valida se a funcionalidade não foi atualizada', () async {
      when(api.put(any, any))
          .thenAnswer((realInvocation) async => Response('', 404));

      expect(() async => await repository.update(subFuncionalitie),
          throwsA(isA<SubFuncionalitiesException>()));
    });
  });

  group('Funcionalidade - Exclusão: ', () {
    SubFuncionalitiesModel subFuncionalitie = SubFuncionalitiesModel(
        id: 22, name: "Teste", route: "/teste", icon: "home_work");

    test('Valida se a funcionalidade foi deletada', () async {
      when(api.delete(any))
          .thenAnswer((realInvocation) async => Response('', 200));

      expect(await repository.delete(subFuncionalitie), true);
    });

    test('Valida se a funcionalidade não foi deletada', () async {
      when(api.delete(any))
          .thenAnswer((realInvocation) async => Response('', 404));

      expect(() async => await repository.delete(subFuncionalitie),
          throwsA(isA<SubFuncionalitiesException>()));
    });
  });
}
