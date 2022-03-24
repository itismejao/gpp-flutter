import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';
import 'package:gpp/src/views/widgets/situacao_widget.dart';

import '../../controllers/produto_controller.dart';

class ProdutoView extends StatelessWidget {
  const ProdutoView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtoController = Get.put(ProdutoController());

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            child: Row(
              children: [TitleComponent('Produtos')],
            ),
          ),
          Expanded(
            child: Obx(
              () => produtoController.carregado.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                        itemCount: produtoController.produtos.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              produtoController.exibirProdutoDetalhe(
                                  produtoController.produtos[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: CardWidget(
                                widget: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              TextComponent(
                                                'Código do produto',
                                                fontWeight: FontWeight.bold,
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: TextComponent(
                                          'Descrição',
                                          fontWeight: FontWeight.bold,
                                        )),
                                        Expanded(
                                            child: TextComponent(
                                          'Fornecedor',
                                          fontWeight: FontWeight.bold,
                                        )),
                                        Expanded(
                                            child: TextComponent(
                                          'Situação',
                                          fontWeight: FontWeight.bold,
                                        )),
                                        Expanded(
                                            child: TextComponent(
                                          'Ações',
                                          fontWeight: FontWeight.bold,
                                        )),
                                      ],
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              TextComponent(
                                                produtoController
                                                    .produtos[index].idProduto
                                                    .toString(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            child: TextComponent(
                                          produtoController
                                                  .produtos[index].resumida ??
                                              '',
                                        )),
                                        Expanded(
                                            child: TextComponent(
                                                produtoController
                                                        .produtos[index]
                                                        .fornecedores!
                                                        .first
                                                        .cliente!
                                                        .nome ??
                                                    '')),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            SituacaoWidget(
                                                situacao: produtoController
                                                    .produtos[index].situacao!),
                                          ],
                                        )),
                                        Expanded(
                                          child: ButtonAcaoWidget(),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : LoadingComponent(),
            ),
          )
        ],
      ),
    );
  }
}
