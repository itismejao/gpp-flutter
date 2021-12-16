// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gpp/src/shared/controllers/authenticate_controller.dart';
import 'package:gpp/src/shared/exceptions/authenticate_exception.dart';
import 'package:gpp/src/shared/models/authenticate_model.dart';

void main() async {
  try {
    dotenv.testLoad(fileInput: File(".env").readAsStringSync());

    AuthenticateController authenticateController = AuthenticateController();

    var resposta = await authenticateController.login(
        dotenv.env['USER'], dotenv.env['PASSWORD']);

    test('Usuário authenticado', () {
      expect(resposta, isInstanceOf<AuthenticateModel>());
    });
  } on AuthenticationException catch (authenticationException) {
    test('Credenciais inválidas', () {
      expect(authenticationException, isInstanceOf<AuthenticationException>());
    });
  }
}
