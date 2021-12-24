// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gpp/main.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/exceptions/user_exception.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  dotenv.testLoad(fileInput: File("env").readAsStringSync());

  final api = MockApiService();
  final repository = UserRepository(api: api);

  test('Verifica a busca de usuários', () async {
    when(api.get(any))
        .thenAnswer((realInvocation) async => Response(jsonBodySucess, 200));
    final users = await repository.fetchUser();
    expect(users, isA<List<UserModel>>());
  });

  test('Verifica erro ao realizar a busca de usuários', () async {
    when(api.get(any))
        .thenAnswer((realInvocation) async => Response(jsonBodyError, 404));

    expect(repository.fetchUser(), throwsA(isA<UserException>()));
  });
}

String jsonBodyError = '''{
    "error": "Funcionalidade não cadastrada no GPP."
}''';

String jsonBodySucess = ''' [
    [
        {
            "id": "1",
            "uid": "9010000401",
            "name": "Marcelo Jose De Castro Neiva",
            "email": "9010000401@novomundo.com.br",
            "email_verified_at": null,
            "password": "Sm2bXQRXxAGOXH85ZXoZwRChvfk.HRy2TH7WAB95vM2",
            "remember_token": null,
            "created_at": "2021-12-21 19:49:09",
            "updated_at": "2021-12-21 19:49:09",
            "active": "0",
            "iddepto": null,
            "foto": null
        },
        {
            "id": "2",
            "uid": "9010000409",
            "name": "Fernando Henrique Ramos Mendes",
            "email": "mendesfnando@gmail.com",
            "email_verified_at": null,
            "password": "Qdrw31nUKCRiws4WMLYDZrVUeueCTLW",
            "remember_token": null,
            "created_at": "2021-12-21 19:49:49",
            "updated_at": "2021-12-21 19:49:49",
            "active": "0",
            "iddepto": null,
            "foto": null
        },
        {
            "id": "3",
            "uid": "1032445",
            "name": "Weverson Barbosa De Lima",
            "email": "weverson.lima@novomundo.com.br",
            "email_verified_at": null,
            "password": "Qdrw31nUKCRiws4WMLYDZrVUeueCTLW",
            "remember_token": null,
            "created_at": "2021-12-21 19:50:09",
            "updated_at": "2021-12-21 19:50:09",
            "active": "0",
            "iddepto": null,
            "foto": null
        }
    ]
]''';
