import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gpp/src/views/produto/controllers/produto_controller.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/views/produto/controllers/produto_detalhe_controller.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';

class ProdutoDetalheView extends StatelessWidget {
  final int id;
  const ProdutoDetalheView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produtoController = Get.put(
      ProdutoDetalheController(id),
    );

    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      TitleComponent('Produto'),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Obx(() => !produtoController.carregando.value
                      ? Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InputComponent(
                                    enable: false,
                                    label: 'Código do produto',
                                    initialValue: produtoController
                                        .produto.idProduto
                                        .toString(),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: InputComponent(
                                    enable: false,
                                    label: 'Descrição',
                                    initialValue: produtoController
                                        .produto.resumida
                                        .toString()
                                        .capitalize,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: InputComponent(
                                    enable: false,
                                    label: 'Fornecedor',
                                    initialValue: produtoController.produto
                                        .fornecedores!.first.cliente!.nome
                                        .toString()
                                        .capitalize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : LoadingComponent())
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: Get.height * 0.7,
              child: Container(
                color: Colors.white,
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
                                    onPressed: () =>
                                        produtoController.importarPecas(id),
                                    text: 'Importar peças',
                                    icon: Icon(Icons.upload_file_rounded,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              child: Row(
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
                            ),
                            Expanded(
                                child: Obx(() => !produtoController
                                        .carregando.value
                                    ? ListView.builder(
                                        itemCount: produtoController
                                            .produtoPecas.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8),
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
                                                              .produtoPecas[
                                                                  index]
                                                              .peca!
                                                              .descricao
                                                              .toString()
                                                              .capitalize ??
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
                                                              .produtoPecas[
                                                                  index]
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
                                                  Expanded(
                                                      child: ButtonAcaoWidget(
                                                    deletar: () =>
                                                        produtoController
                                                            .deletarProdutoPeca(
                                                                id,
                                                                produtoController
                                                                    .produtoPecas[
                                                                        index]
                                                                    .peca!
                                                                    .id_peca),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : LoadingComponent())),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                                margin: EdgeInsets.all(8),
                                child: Obx(
                                  () => !produtoController.carregando.value
                                      ? Row(
                                          children: [
                                            TextComponent(
                                              'Total de peças vinculadas ${produtoController.produtoPecas.length + 1}',
                                              fontWeight: FontWeight.bold,
                                            )
                                          ],
                                        )
                                      : Container(),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
