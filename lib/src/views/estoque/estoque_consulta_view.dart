import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/controllers/pecas_controller/peca_estoque_controller.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class EstoqueConsultaView extends StatefulWidget {
  const EstoqueConsultaView({Key? key}) : super(key: key);

  @override
  _EstoqueConsultaViewState createState() => _EstoqueConsultaViewState();
}

class _EstoqueConsultaViewState extends State<EstoqueConsultaView> {
  TextEditingController _controllerIdFilial = new TextEditingController();
  TextEditingController _controllerNomeFilial = new TextEditingController();

  TextEditingController _controllerIdFornecedor = new TextEditingController();
  TextEditingController _controllerNomeFornecedor = new TextEditingController();

  TextEditingController _controllerIdProduto = new TextEditingController();
  TextEditingController _controllerNomeProduto = new TextEditingController();

  TextEditingController _controllerIdPeca = new TextEditingController();
  TextEditingController _controllerNomePeca = new TextEditingController();

  TextEditingController _controllerCorredor = new TextEditingController();
  TextEditingController _controllerPrateleira = new TextEditingController();
  TextEditingController _controllerEstante = new TextEditingController();
  TextEditingController _controllerBox = new TextEditingController();

  bool disponivel = false;
  bool reservado = false;
  bool transferencia = false;
  bool? endereco;

  PecaEstoqueController pecaEstoqueController = PecaEstoqueController();

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Icon(Icons.grid_view_outlined),
              const Padding(padding: EdgeInsets.only(right: 12)),
              const TitleComponent('Consultar Estoque'),
              const Padding(padding: EdgeInsets.only(right: 5)),
            ],
          ),
        ),
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        Container(
          child: Column(children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdFilial,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Filial',
                        labelText: 'Filial',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {},
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeFilial,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Filial',
                        labelText: 'Nome Filial',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdFornecedor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                          hintText: 'ID',
                          labelText: 'ID',
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            onPressed: () async {},
                            icon: Icon(Icons.search),
                          )),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeFornecedor,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Fornecedor',
                        labelText: 'Nome Fornecedor',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                // Fim Fornecedor
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdProduto,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ID',
                        labelText: 'ID',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_controllerIdProduto.text == '') {
                              //limparFieldsPeca();
                            } else {
                              //buscarProduto(_controllerIdProduto.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeProduto,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Produto',
                        labelText: 'Nome Produto',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdPeca,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                          hintText: 'ID',
                          labelText: 'ID',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_controllerIdPeca.text == '') {
                                //limparFieldsPeca();
                              } else {
                                //buscarPeca(_controllerIdPeca.text);
                              }
                            },
                            icon: const Icon(Icons.search),
                          )),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomePeca,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Peça',
                        labelText: 'Nome Peça',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                // Fim Fornecedor
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                        controller: _controllerCorredor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        }),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                        enabled: _controllerCorredor.text == '' ? false : true,
                        controller: _controllerEstante,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        }),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                        enabled: _controllerEstante.text == '' ? false : true,
                        controller: _controllerPrateleira,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        }),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                        enabled:
                            _controllerPrateleira.text == '' ? false : true,
                        controller: _controllerBox,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        }),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Disponível'),
                    leading: Checkbox(
                      value: disponivel,
                      onChanged: (value) {
                        setState(() {
                          disponivel = value!;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Reservado'),
                    leading: Checkbox(
                      value: reservado,
                      onChanged: (value) {
                        setState(() {
                          reservado = value!;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Transferência'),
                    leading: Checkbox(
                      value: transferencia,
                      onChanged: (value) {
                        setState(() {
                          transferencia = value!;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Endereçado'),
                    leading: Radio(
                      groupValue: endereco,
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          endereco = true;
                        });
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: ListTile(
                    title: const Text('Sem endereço'),
                    leading: Radio(
                      groupValue: endereco,
                      value: false,
                      onChanged: (value) {
                        setState(() {
                          endereco = false;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  child: ButtonComponent(
                      onPressed: () async {
                        consultarEstoque();
                      },
                      text: 'Pesquisar'),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 32,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const TitleComponent('Endereços'),
                      ],
                    ),
                    Row(
                      children: [
                        ButtonComponent(
                            color: primaryColor,
                            onPressed: () {},
                            text: 'Limpar Filtros')
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const TextComponent(
                        'Filial',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: const TextComponent('Endereço'),
                    ),
                    Expanded(
                      child: const TextComponent(
                        'Cod. Peça',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: const TextComponent('Descrição Peça'),
                    ),
                    Expanded(
                      flex: 2,
                      child: const TextComponent('Fornecedor'),
                    ),
                    Expanded(
                      child: const TextComponent(
                        'Disp.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: const TextComponent(
                        'Reserv.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: const TextComponent(
                        'Ações',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Center(
                child: Container(
                  height: media.height / 2,
                  child: Stack(
                    children: [
                      ListView.builder(
                        primary: false,
                        itemCount: pecaEstoqueController.pecas_estoque.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Padding(padding: EdgeInsets.only(left: 10)),
                                // CheckboxComponent(),
                                Expanded(
                                  child: Text(
                                    pecaEstoqueController
                                        .pecas_estoque[index]!.filial
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    pecaEstoqueController.pecas_estoque[index]!
                                            .enderecamento?.endereco ??
                                        '-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    pecaEstoqueController
                                        .pecas_estoque[index]!.id_peca
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(pecaEstoqueController
                                          .pecas_estoque[index]!
                                          .pecasModel
                                          ?.descricao ??
                                      ''),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(pecaEstoqueController
                                          .pecas_estoque[index]!.fornecedor ??
                                      '-'),
                                ),
                                Expanded(
                                  child: Text(
                                    pecaEstoqueController
                                        .pecas_estoque[index]!.saldo_disponivel
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    pecaEstoqueController
                                        .pecas_estoque[index]!.saldo_reservado
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () async {},
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          tooltip: 'Etiqueta',
                                          icon: Icon(
                                            Icons.local_offer_outlined,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () => {
                                            //PopUpEditar.popUpPeca(context,EnderecoDetailView(pecaEnderecamento: snapshot.data![index]))
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      pecaEstoqueController.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Container(
                height: media.height * 0.10,
                width: media.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent('Total de páginas: ' +
                        pecaEstoqueController.paginaModel.total.toString()),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.first_page),
                            onPressed: () {
                              setState(() {
                                pecaEstoqueController.paginaModel.atual = 1;
                              });
                              consultarEstoque();
                              //buscarTodas();
                            }),
                        IconButton(
                            icon: const Icon(
                              Icons.navigate_before_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                if (pecaEstoqueController.paginaModel.atual >
                                    1) {
                                  pecaEstoqueController.paginaModel.atual =
                                      pecaEstoqueController.paginaModel.atual -
                                          1;
                                  //buscarTodas();
                                }
                              });
                              consultarEstoque();
                            }),
                        TextComponent(
                            pecaEstoqueController.paginaModel.atual.toString()),
                        IconButton(
                            icon: Icon(Icons.navigate_next_rounded),
                            onPressed: () {
                              setState(() {
                                if (pecaEstoqueController.paginaModel.atual !=
                                    pecaEstoqueController.paginaModel.total) {
                                  pecaEstoqueController.paginaModel.atual =
                                      pecaEstoqueController.paginaModel.atual +
                                          1;
                                }
                              });
                              consultarEstoque();
                              //buscarTodas();
                            }),
                        IconButton(
                            icon: Icon(Icons.last_page),
                            onPressed: () {
                              setState(() {
                                pecaEstoqueController.paginaModel.atual =
                                    pecaEstoqueController.paginaModel.total;
                              });
                              consultarEstoque();
                              //buscarTodas();
                            }),
                      ],
                    )
                  ],
                ),
              )
            ])
          ]),
        ),
      ],
    );
  }

  consultarEstoque() async {
    setState(() {
      pecaEstoqueController.isLoading = true;
    });
    await pecaEstoqueController
        .consultarEstoque(
            pecaEstoqueController.paginaModel.atual,
            _controllerIdFilial.text,
            _controllerIdPeca.text,
            _controllerIdProduto.text,
            _controllerIdFornecedor.text,
            endereco,
            disponivel,
            reservado,
            transferencia,
            _controllerCorredor.text,
            _controllerEstante.text,
            _controllerPrateleira.text,
            _controllerBox.text)
        .then((value) => setState(() {
              pecaEstoqueController.isLoading = false;
            }));
  }
}
