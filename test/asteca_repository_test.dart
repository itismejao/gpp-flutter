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
        "id_asteca": 252,
        "tipo_asteca": null,
        "id_filial_registro": 505,
        "observacao": "FAVOR LIGAR ANTES P/ MARIA RODRIGUES 32843476 P/ ABRIR A CS.CL ALEGA TER RECEBIDO O PRODT NO SABADO(03/11/05) C/ DEFEITO.",
        "defeito_estado_prod": "TEM UM FERRO Q RASGA O TECIDO QUANDO SE ABRE A POLTRONA",
        "data_emissao": "2005-12-07T00:00:00.000000Z",
        "asteca_end_cliente": null,
        "asteca_motivo": {
            "id_asteca_motivo": 8,
            "denominacao": "DEFEITO DE FABRICAÇÃO"
        },
        "documento_fiscal": {
            "id_documento_fiscal": 9924867,
            "id_filial_saida": 515,
            "id_filial_venda": 505,
            "nome": "EDNA TORRES DE LIMA",
            "cpf_cnpj": 92840116120,
            "num_doc_fiscal": 312228,
            "serie_doc_fiscal": 0,
            "data_emissao": "2005-11-30T14:09:48.000000Z",
            "item_doc_fiscal": {
                "id_ld": 2
            }
        },
        "produto": [
            {
                "id_produto": 12304,
                "resumida": "POLTRONA DIPLOMATA RECL TC GOB AZUL",
                "fornecedor": {
                    "id_fornecedor": 1296,
                    "cliente": {
                        "id_cliente": 12950,
                        "nome": "ULTRA-FLEX COLCHOES IND BRAS LTDA"
                    }
                }
            }
        ],
        "funcionario": [
            {
                "id_funcionario": 10481,
                "nome": "LUCIANA COELHO GUIMARAES"
            }
        ]
    },
    {
        "id_asteca": 257,
        "tipo_asteca": null,
        "id_filial_registro": 11,
        "observacao": null,
        "defeito_estado_prod": "O VIDRO DA GAVETA FOI QUEBRADO,O MONTADOR DISSE QUE VOLTARIA P/TROCAR A PECA MAIS NAO VOLTOU",
        "data_emissao": "2005-12-07T00:00:00.000000Z",
        "asteca_end_cliente": null,
        "asteca_motivo": {
            "id_asteca_motivo": 7,
            "denominacao": "MERC. DANIFICADA POR DEFICIÊNCIA DA EMB. / FALTA ACESSORIOS"
        },
        "documento_fiscal": {
            "id_documento_fiscal": 9835714,
            "id_filial_saida": 515,
            "id_filial_venda": 11,
            "nome": "NILSA LUCIA CASSIMIRO DE CASTRO",
            "cpf_cnpj": 85405680125,
            "num_doc_fiscal": 298681,
            "serie_doc_fiscal": 0,
            "data_emissao": "2005-11-09T11:44:13.000000Z",
            "item_doc_fiscal": {
                "id_ld": 0
            }
        },
        "produto": [
            {
                "id_produto": 10608,
                "resumida": "MESA TELEFONE 1003 P.MOGNO",
                "fornecedor": {
                    "id_fornecedor": 3074,
                    "cliente": {
                        "id_cliente": 2703469,
                        "nome": "EDCLAU MOVEIS LTDA                 "
                    }
                }
            }
        ],
        "funcionario": [
            {
                "id_funcionario": 1076,
                "nome": "JUNIO CESAR DO NASCIMENTO"
            }
        ]
    },
    {
        "id_asteca": 258,
        "tipo_asteca": null,
        "id_filial_registro": 500,
        "observacao": null,
        "defeito_estado_prod": "FALTOU 1 DOBRADIÇA",
        "data_emissao": "2005-12-07T00:00:00.000000Z",
        "asteca_end_cliente": null,
        "asteca_motivo": {
            "id_asteca_motivo": 11,
            "denominacao": "FALTA ACESSORIO/PEÇA NA EMBALAGEM"
        },
        "documento_fiscal": {
            "id_documento_fiscal": 9929132,
            "id_filial_saida": 515,
            "id_filial_venda": 1,
            "nome": "RENIR CAMILO DE SOUZA",
            "cpf_cnpj": 23429194172,
            "num_doc_fiscal": 312930,
            "serie_doc_fiscal": 0,
            "data_emissao": "2005-12-01T09:03:50.000000Z",
            "item_doc_fiscal": {
                "id_ld": 0
            }
        },
        "produto": [
            {
                "id_produto": 8489,
                "resumida": "COZ MUNICH 3PCS (P6PV/MAP2P/AP3P) BC",
                "fornecedor": {
                    "id_fornecedor": 288,
                    "cliente": {
                        "id_cliente": 1583,
                        "nome": "COLOR VISAO DO BRASIL INDUSTRIA ACRILICA LIMITADA"
                    }
                }
            }
        ],
        "funcionario": [
            {
                "id_funcionario": 3539,
                "nome": "SIRLEY DA SILVA OLIVEIRA"
            }
        ]
    },
    {
        "id_asteca": 259,
        "tipo_asteca": null,
        "id_filial_registro": 500,
        "observacao": null,
        "defeito_estado_prod": "TROCAR 1 PORTA ESQUERDA DE BAIXO ( AMASSADA)",
        "data_emissao": "2005-12-07T00:00:00.000000Z",
        "asteca_end_cliente": null,
        "asteca_motivo": {
            "id_asteca_motivo": 2,
            "denominacao": "MAU USO CONSUMIDOR"
        },
        "documento_fiscal": {
            "id_documento_fiscal": 9943689,
            "id_filial_saida": 515,
            "id_filial_venda": 12,
            "nome": "ALMIRA BRAZ MASCARENHAS",
            "cpf_cnpj": 8316252104,
            "num_doc_fiscal": 315083,
            "serie_doc_fiscal": 0,
            "data_emissao": "2005-12-04T15:46:45.000000Z",
            "item_doc_fiscal": {
                "id_ld": 2
            }
        },
        "produto": [
            {
                "id_produto": 10371,
                "resumida": "PANELEIRO DUP STILE TOP 4065 6PT VD BC97",
                "fornecedor": {
                    "id_fornecedor": 17,
                    "cliente": {
                        "id_cliente": 15779,
                        "nome": "MOVEIS BERTOLINI S.A.              "
                    }
                }
            }
        ],
        "funcionario": [
            {
                "id_funcionario": 3539,
                "nome": "SIRLEY DA SILVA OLIVEIRA"
            }
        ]
    },
    {
        "id_asteca": 260,
        "tipo_asteca": null,
        "id_filial_registro": 500,
        "observacao": null,
        "defeito_estado_prod": "FALTOU A LATERAL N. 9  ( REPETIU A N.10 ) ESTÁ MONTADO PARCILAMENTE",
        "data_emissao": "2005-12-07T00:00:00.000000Z",
        "asteca_end_cliente": null,
        "asteca_motivo": {
            "id_asteca_motivo": 8,
            "denominacao": "DEFEITO DE FABRICAÇÃO"
        },
        "documento_fiscal": {
            "id_documento_fiscal": 9943282,
            "id_filial_saida": 515,
            "id_filial_venda": 5,
            "nome": "WELIO MOURA DO NASCIMENTO",
            "cpf_cnpj": 47211474149,
            "num_doc_fiscal": 314990,
            "serie_doc_fiscal": 0,
            "data_emissao": "2005-12-04T11:47:28.000000Z",
            "item_doc_fiscal": {
                "id_ld": 0
            }
        },
        "produto": [
            {
                "id_produto": 12143,
                "resumida": "MESA COMP PRATIKA 4030 P.TABACO",
                "fornecedor": {
                    "id_fornecedor": 212,
                    "cliente": {
                        "id_cliente": 1568,
                        "nome": "MOVEIS PROVINCIA IND E COM LTDA    "
                    }
                }
            }
        ],
        "funcionario": [
            {
                "id_funcionario": 3539,
                "nome": "SIRLEY DA SILVA OLIVEIRA"
            }
        ]
    }
]''';

    test('Verifica a busca de astecas', () async {
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
