// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gpp/src/shared/services/gpp_api.dart';

void main() {
  dotenv.testLoad(fileInput: File(".env").readAsStringSync());
  test('Verifica se a url da api está correta', () {
    expect(dotenv.env['API_URL'], gppApi.getBaseUrl());
  });
}
