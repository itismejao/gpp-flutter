import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';

import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/produto/controllers/produto_controller.dart';
import 'package:gpp/src/views/produto/controllers/produto_detalhe_controller.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';
import 'package:gpp/src/views/widgets/situacao_widget.dart';

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
              children: [
                Expanded(child: TitleComponent('Produtos')),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: InputComponent(
                        hintText: 'Buscar',
                        onFieldSubmitted: (value) {
                          produtoController.pesquisarProduto(value);
                        },
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => !produtoController.carregando.value
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                        itemCount: produtoController.produtos.length,
                        itemBuilder: (context, index) {
                          return Container(
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
                                              '${produtoController.produtos[index].idProduto.toString()}',
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: TextComponent(
                                        produtoController
                                                .produtos[index].resumida
                                                .toString()
                                                .capitalize ??
                                            '',
                                      )),
                                      Expanded(
                                          child: TextComponent(produtoController
                                                  .produtos[index]
                                                  .fornecedores!
                                                  .first
                                                  .cliente!
                                                  .nome
                                                  .toString()
                                                  .capitalize ??
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
                                        child: ButtonAcaoWidget(
                                          detalhe: () {
                                            Get.delete<
                                                ProdutoDetalheController>();
                                            Get.keys[1]!.currentState!.pushNamed(
                                                '/produtos/${produtoController.produtos[index].idProduto}');
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : LoadingComponent(),
            ),
          ),
        ],
      ),
    );
  }
}
