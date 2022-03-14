// Mocks generated by Mockito 5.0.17 from annotations
// in gpp/test/pedido_entrada_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:gpp/src/shared/services/gpp_api.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeResponse_0 extends _i1.Fake implements _i2.Response {}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i3.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set baseUrl(String? _baseUrl) =>
      super.noSuchMethod(Invocation.setter(#baseUrl, _baseUrl),
          returnValueForMissingStub: null);
  @override
  Map<String, String> get headers =>
      (super.noSuchMethod(Invocation.getter(#headers),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  set headers(Map<String, String>? _headers) =>
      super.noSuchMethod(Invocation.setter(#headers, _headers),
          returnValueForMissingStub: null);
  @override
  Map<String, String> getHeader() =>
      (super.noSuchMethod(Invocation.method(#getHeader, []),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  _i4.Future<_i2.Response> get(String? endpoint,
          {Map<String, String>? queryParameters}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #get, [endpoint], {#queryParameters: queryParameters}),
              returnValue: Future<_i2.Response>.value(_FakeResponse_0()))
          as _i4.Future<_i2.Response>);
  @override
  _i4.Future<dynamic> post(String? path, dynamic body) =>
      (super.noSuchMethod(Invocation.method(#post, [path, body]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> postTeste(String? endpoint, dynamic body) =>
      (super.noSuchMethod(Invocation.method(#postTeste, [endpoint, body]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> endereco(String? endpoint, dynamic body) =>
      (super.noSuchMethod(Invocation.method(#endereco, [endpoint, body]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> put(String? endpoint, dynamic body) =>
      (super.noSuchMethod(Invocation.method(#put, [endpoint, body]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
  @override
  _i4.Future<dynamic> delete(String? endpoint) =>
      (super.noSuchMethod(Invocation.method(#delete, [endpoint]),
          returnValue: Future<dynamic>.value()) as _i4.Future<dynamic>);
}
