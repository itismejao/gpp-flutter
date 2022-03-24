import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpp/src/controllers/produto_controller.dart';

import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';

import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';

class ProdutoDetalheView extends StatelessWidget {
  // final ProdutoModel produto;
  const ProdutoDetalheView({
    Key? key,
    //  required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtoController = Get.put(ProdutoController());

    return Material(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24),
                      child: Row(
                        children: [
                          TitleComponent('Peças'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                              child: InputComponent(
                            hintText: 'Buscar',
                          )),
                          SizedBox(
                            width: 8,
                          ),
                          ButtonComponent(
                            onPressed: () {},
                            text: 'Adicionar',
                            icon: Icon(Icons.upload_file_rounded,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          ButtonComponent(
                            onPressed: () {},
                            text: 'Importar peças',
                            icon: Icon(Icons.upload_file_rounded,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextComponent(
                            'Código da peça',
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                            'Descrição',
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                            'Quantidade de peças por produto',
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                            'Código de fabrica',
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                            'Medida',
                          ),
                        ),
                        Expanded(
                          child: TextComponent(
                            'Ações',
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: Obx(() => produtoController.carregado.value
                            ? ListView.builder(
                                itemCount:
                                    produtoController.produtoPecas.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    child: CardWidget(
                                      widget: Row(
                                        children: [
                                          Expanded(
                                            child: TextComponent(
                                              produtoController
                                                  .produtoPecas[index]
                                                  .peca!
                                                  .id_peca
                                                  .toString(),
                                            ),
                                          ),
                                          Expanded(
                                            child: TextComponent(
                                              produtoController
                                                      .produtoPecas[index]
                                                      .peca!
                                                      .descricao ??
                                                  '',
                                            ),
                                          ),
                                          Expanded(
                                            child: TextComponent(
                                              '${produtoController.produtoPecas[index].quantidadePorProduto ?? ''}',
                                            ),
                                          ),
                                          Expanded(
                                            child: TextComponent(
                                              produtoController
                                                      .produtoPecas[index]
                                                      .peca!
                                                      .codigo_fabrica ??
                                                  '',
                                            ),
                                          ),
                                          Expanded(
                                            child: TextComponent(
                                              '${produtoController.produtoPecas[index].peca!.altura}x${produtoController.produtoPecas[index].peca!.largura}x${produtoController.produtoPecas[index].peca!.profundidade}',
                                            ),
                                          ),
                                          Expanded(child: ButtonAcaoWidget())
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : LoadingComponent()))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
