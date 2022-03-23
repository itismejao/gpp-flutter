// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpp/src/models/asteca/asteca_model.dart';

import 'package:gpp/src/repositories/AstecaRepository.dart';

import 'package:gpp/src/shared/services/gpp_api.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'asteca_repository_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  dotenv.testLoad(fileInput: File("env").readAsStringSync());

  final api = MockApiService();
  final repository = AstecaRepository();

  group('Astecas: ', () {
    String dataReceived = '''[
        {
            "id_asteca": 687924,
            "tipo_asteca": 1,
            "id_filial_registro": 500,
            "observacao": "PEÇA QUEBRADA",
            "defeito_estado_prod": "CÓD.15520 - PUXADOR ALUMINIO",
            "data_emissao": "2021-10-07T00:00:00.000000Z",
            "asteca_end_cliente": {
                "id_asteca_end_cli": 1044590,
                "logradouro": "RUA GENERAL OSORIO NR 1 QD-Y1 LT-15",
                "localidade": "GOIANIA",
                "numero": 1,
                "complemento": "QD-Y1 LT-15",
                "bairro": "VILA CONCORDIA",
                "uf": "GO",
                "cep": 74770350,
                "ponto_referencia_1": null,
                "ponto_referencia_2": null,
                "ddd": 62,
                "telefone": 994907199
            },
            "asteca_motivo": null,
            "documento_fiscal": {
                "id_documento_fiscal": 62397354,
                "id_filial_saida": 515,
                "id_filial_venda": 1748,
                "id_cliente": "13924252",
                "nome": "LYLIAN TAVARES PEREIRA",
                "cpf_cnpj": "70807959154",
                "num_doc_fiscal": 4569496,
                "serie_doc_fiscal": "10",
                "data_emissao": "2020-02-13T13:35:43.000000Z",
                "item_doc_fiscal": {
                    "id_ld": 4
                },
                "cliente": {
                    "id_cliente": 13924252,
                    "cnpj_cpf": "70807959154",
                    "nome": "LYLIAN TAVARES PEREIRA"
                }
            },
            "produto": [
                {
                    "id_produto": 58414,
                    "resumida": "G ROUPA GHAIA STATUS 2P C/ESP PES AME/BC",
                    "id_fornecedor": "14584",
                    "situacao": "1",
                    "cod_barra": "7908051409731",
                    "marca": null,
                    "data_cadastro": "2019-04-30 10:39:43",
                    "pivot": {
                        "id_comp_est": "120088",
                        "id_produto": "58414"
                    },
                    "fornecedores": [
                        {
                            "id_fornecedor": 14584,
                            "enviado": "1",
                            "cli_forn_principal": null,
                            "cliente": {
                                "id_cliente": 7433048,
                                "nome": "MOVEIS BOM PASTOR LTDA",
                                "e_mail": "nfe@bompastor.ind.br",
                                "cnpj_cpf": "01610917000332"
                            }
                        },
                        {
                            "id_fornecedor": 14584,
                            "enviado": "1",
                            "cli_forn_principal": null,
                            "cliente": {
                                "id_cliente": 5580205,
                                "nome": "MOVEIS BOM PASTOR LTDA",
                                "e_mail": "nfe@bompastor.ind.br",
                                "cnpj_cpf": "01610917000413"
                            }
                        },
                        {
                            "id_fornecedor": 14584,
                            "enviado": "1",
                            "cli_forn_principal": null,
                            "cliente": {
                                "id_cliente": 4668618,
                                "nome": "MOVEIS BOM PASTOR LTDA",
                                "e_mail": "nfe@bompastor.ind.br",
                                "cnpj_cpf": "01610917000251"
                            }
                        },
                        {
                            "id_fornecedor": 14584,
                            "enviado": "2",
                            "cli_forn_principal": null,
                            "cliente": {
                                "id_cliente": 3543535,
                                "nome": "MOVEIS BOM PASTOR LTDA",
                                "e_mail": "nfe@bompastor.ind.br",
                                "cnpj_cpf": "01610917000170"
                            }
                        }
                    ]
                }
            ],
            "funcionario": [
                {
                    "id_funcionario": 1031386,
                    "nome": "LYLIAN TAVARES PEREIRA"
                }
            ],
            "pendencia": [
                {
                    "id_tipo_pendencia": 3622,
                    "descricao": "PEDIDO DE PEÇAS AO PULMÃO",
                    "situacao": "1",
                    "usr_cria": "18000",
                    "data_cria": "2016-06-13 09:18:48",
                    "usr_alt": "18331",
                    "data_alt": "2019-09-09 10:36:50",
                    "tipo_registro": "1",
                    "pivot": {
                        "id_asteca": "687924",
                        "id_tipo_pendencia": "3622"
                    }
                },
                {
                    "id_tipo_pendencia": 3622,
                    "descricao": "PEDIDO DE PEÇAS AO PULMÃO",
                    "situacao": "1",
                    "usr_cria": "18000",
                    "data_cria": "2016-06-13 09:18:48",
                    "usr_alt": "18331",
                    "data_alt": "2019-09-09 10:36:50",
                    "tipo_registro": "1",
                    "pivot": {
                        "id_asteca": "687924",
                        "id_tipo_pendencia": "3622"
                    }
                }
            ]
        },]''';

    test('teste de busca de astecas', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response(dataReceived, 200));
      final resposta = await repository.buscar(1);
      expect(resposta, isA<List<AstecaModel>>());
    });

    test('Verifica se não foi possível encontrar as astecas', () async {
      when(api.get(any))
          .thenAnswer((realInvocation) async => Response('', 404));

      expect(() async => await repository.buscar(1), throwsA(isA<Exception>()));
    });
  });
}
