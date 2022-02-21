import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_especie_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_grupo_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_material_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/produto_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_grupo_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/pecas/cores_detail_view.dart';
import 'package:gpp/src/views/pecas/linha_detail_view.dart';
import 'package:gpp/src/views/pecas/material_detail_view.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';

class PecasDetailView extends StatefulWidget {
  PecasModel? pecasModelPopup;

  PecasDetailView({this.pecasModelPopup});

  @override
  _PecasDetailViewState createState() => _PecasDetailViewState();
}

class _PecasDetailViewState extends State<PecasDetailView> {
  PecasController _pecasController = PecasController();
  PecasLinhaController _pecasLinhaController = PecasLinhaController();
  PecasEspecieController _pecasEspecieController = PecasEspecieController();
  PecasGrupoController _pecasGrupoController = PecasGrupoController();
  PecasMaterialController _pecasMaterialController = PecasMaterialController();
  ProdutoController _produtoController = ProdutoController();

  final txtIdProduto = TextEditingController();
  final txtNomeProduto = TextEditingController();
  final txtIdFornecedor = TextEditingController();
  final txtNomeFornecedor = TextEditingController();

  PecasModel? pecasModelPopup;

  buscaProduto(String codigo) async {
    await _produtoController.buscar(codigo);
  }

  buscarLinhaEspecie(String codigo) async {
    await _pecasLinhaController.buscarEspecieVinculada(codigo);

    await _pecasLinhaController.buscarTodos();

    print('Dentro funcao');
    // print(await _pecasLinhaController.buscarEspecieVinculada(codigo));
  }

  criar(context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _pecasController.criar()) {
        notify.sucess("Peça cadastrada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  void initState() {
    pecasModelPopup = widget.pecasModelPopup;
    if (pecasModelPopup != null) {
      _pecasController.pecasModel = pecasModelPopup!;
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 20)),
              Icon(pecasModelPopup == null ? Icons.add_box : Icons.edit),
              Padding(padding: EdgeInsets.only(right: 12)),
              TitleComponent(pecasModelPopup == null ? 'Cadastrar Peças' : 'Editar Peças'),
            ],
          ),
        ),
        Divider(),
        Padding(padding: EdgeInsets.only(bottom: 30)),
        Column(
          children: [
            Row(
              children: [
                // Produto
                SizedBox(
                  width: 120,
                  child: Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: txtIdProduto,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ID',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await buscaProduto(txtIdProduto.text);

                              txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                              txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                              txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                            },
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: txtNomeProduto,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Produto',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                // Fornecedor
                SizedBox(
                  width: 80,
                  child: Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: txtIdFornecedor,
                        enabled: false,
                        onChanged: (value) {
                          // _pecasController.pecasModel.id_fornecedor = int.parse(value);
                        },
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'ID',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: txtNomeFornecedor,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Fornecedor',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                // Fim Fornecedor
              ],
            ),
            // Row(
            //   children: [
            //     ButtonComponent(
            //       onPressed: () async {
            //         print('chamou botao');
            //         await buscarLinhaEspecie('1');

            //         // print(_pecasLinhaController.listaPecasLinhaModel?[0].especie?[0].especie);
            //       },
            //       text: 'Salvar teste',
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Flexible(
            //       child: Container(
            //         width: 600,
            //         height: 48,
            //         child: FutureBuilder(
            //           future: _produtoController.buscarTodos2('14634'),
            //           builder: (context, AsyncSnapshot snapshot) {
            //             switch (snapshot.connectionState) {
            //               case ConnectionState.none:
            //                 return Text("Sem Conexão");
            //               case ConnectionState.active:
            //               case ConnectionState.waiting:
            //                 return Center(child: new CircularProgressIndicator());
            //               case ConnectionState.done:
            //                 return Container(
            //                   padding: EdgeInsets.only(left: 12, right: 12),
            //                   decoration: BoxDecoration(
            //                     color: Colors.grey.shade200,
            //                     borderRadius: BorderRadius.circular(5),
            //                   ),
            //                   child: DropdownSearch<ProdutoModel?>(
            //                     mode: Mode.DIALOG,
            //                     showSearchBox: true,
            //                     items: snapshot.data,
            //                     itemAsString: (ProdutoModel? value) =>
            //                         value?.id_produto == null ? 'Produto Nulo' : value!.id_produto!.toString(),
            //                     onChanged: (value) {
            //                       print(value?.id_produto);
            //                       _pecasController.pecasModel.id_peca = value!.id_produto;
            //                     },
            //                     dropdownSearchDecoration: InputDecoration(
            //                       enabledBorder: InputBorder.none,
            //                     ),
            //                     dropDownButton: Icon(
            //                       Icons.arrow_drop_down_rounded,
            //                       color: Colors.black,
            //                     ),
            //                     showAsSuffixIcons: true,
            //                   ),
            //                 );
            //             }
            //           },
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              children: [
                Text(
                  'Informações da Peça',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Flexible(
                  child: InputComponent(
                    label: 'Descrição da Peça',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.descricao == null
                            ? ''
                            : _pecasController.pecasModel.descricao.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.descricao = value;
                      _pecasController.pecasModel.volumes = "1";
                      _pecasController.pecasModel.active = 1;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                SizedBox(
                  width: 100,
                  child: Flexible(
                    child: InputComponent(
                      label: 'Quantidade',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Flexible(
                  child: InputComponent(
                    label: 'Número',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.numero == null
                            ? ''
                            : _pecasController.pecasModel.numero.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.numero = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Código de Fabrica',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.codigo_fabrica == null
                            ? ''
                            : _pecasController.pecasModel.codigo_fabrica.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.codigo_fabrica = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Custo R\$',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.custo == null
                            ? ''
                            : _pecasController.pecasModel.custo.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.custo = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Unidade',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.unidade == null
                            ? ''
                            : _pecasController.pecasModel.unidade.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.unidade = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              children: [
                Text(
                  'Medidas',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Flexible(
                  child: InputComponent(
                    label: 'Largura',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.largura == null
                            ? ''
                            : _pecasController.pecasModel.largura.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.largura = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Altura',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.altura == null
                            ? ''
                            : _pecasController.pecasModel.altura.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.altura = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Profundidade',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.profundidade == null
                            ? ''
                            : _pecasController.pecasModel.profundidade.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.profundidade = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Und. Medida',
                    initialValue: pecasModelPopup == null
                        ? ''
                        : _pecasController.pecasModel.unidade_medida == null
                            ? ''
                            : _pecasController.pecasModel.unidade_medida.toString(),
                    onChanged: (value) {
                      _pecasController.pecasModel.unidade_medida = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              children: [
                Text(
                  'Linha e Espécie',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextComponent('Linha'),
                      Padding(padding: EdgeInsets.only(top: 6)),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Flexible(
                              child: InputComponent(
                                hintText: 'ID',
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          // Flexible(
                          //   child: InputComponent(
                          //     hintText: 'Nome Linha',
                          //     onChanged: (value) {},
                          //   ),
                          // ),
                          Flexible(
                            child: Container(
                              width: 600,
                              height: 48,
                              child: FutureBuilder(
                                future: _pecasLinhaController.buscarTodos(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text("Sem Conexão");
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      return Center(child: new CircularProgressIndicator());
                                    case ConnectionState.done:
                                      return Container(
                                        padding: EdgeInsets.only(left: 12, right: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: DropdownSearch<PecasLinhaModel?>(
                                          mode: Mode.DIALOG,
                                          showSearchBox: true,
                                          items: snapshot.data,
                                          itemAsString: (PecasLinhaModel? value) => value!.linha!,
                                          onChanged: (value) {
                                            _pecasLinhaController.pecasLinhaModel.id_peca_linha = value!.id_peca_linha;
                                          },
                                          dropdownSearchDecoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          dropDownButton: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.black,
                                          ),
                                          showAsSuffixIcons: true,
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextComponent('Espécie'),
                      Padding(padding: EdgeInsets.only(top: 6)),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Flexible(
                              child: InputComponent(
                                hintText: 'ID',
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          // Flexible(
                          //   child: InputComponent(
                          //     hintText: 'Nome Espécie',
                          //     onChanged: (value) {},
                          //   ),
                          // ),
                          Flexible(
                            child: Container(
                              width: 600,
                              height: 48,
                              child: FutureBuilder(
                                future: _pecasLinhaController.buscarEspecieVinculada('1'),
                                builder: (context, AsyncSnapshot snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text("Sem conexão");
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      return Center(child: new CircularProgressIndicator());
                                    case ConnectionState.done:
                                      return Container(
                                        padding: EdgeInsets.only(left: 12, right: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: DropdownSearch<PecasLinhaModel?>(
                                          mode: Mode.DIALOG,
                                          showSearchBox: true,
                                          items: snapshot.data,
                                          itemAsString: (PecasLinhaModel? value) => value!.linha!,
                                          onChanged: (value) {
                                            _pecasEspecieController.pecasEspecieModel.id_peca_linha = value!.id_peca_linha;
                                          },
                                          dropdownSearchDecoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          dropDownButton: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.black,
                                          ),
                                          showAsSuffixIcons: true,
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              children: [
                Text(
                  'Material de Fabricação',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(bottom: 30)),
            Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextComponent('Grupo'),
                      Padding(padding: EdgeInsets.only(top: 6)),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Flexible(
                              child: InputComponent(
                                hintText: 'ID',
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          // Flexible(
                          //   child: InputComponent(
                          //     hintText: 'Nome Grupo',
                          //     onChanged: (value) {},
                          //   ),
                          // ),
                          Flexible(
                            child: Container(
                              width: 600,
                              height: 48,
                              child: FutureBuilder(
                                future: _pecasGrupoController.buscarTodos(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.none:
                                      return Text("there is no connection");
                                    case ConnectionState.active:
                                    case ConnectionState.waiting:
                                      return Center(child: new CircularProgressIndicator());
                                    case ConnectionState.done:
                                      return Container(
                                        padding: EdgeInsets.only(left: 12, right: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: DropdownSearch<PecasGrupoModel?>(
                                          mode: Mode.DIALOG,
                                          showSearchBox: true,
                                          items: snapshot.data,
                                          itemAsString: (PecasGrupoModel? value) => value!.grupo!,
                                          onChanged: (value) {
                                            _pecasMaterialController.pecasMaterialModel.id_peca_grupo_material =
                                                value!.id_peca_grupo_material;
                                          },
                                          dropdownSearchDecoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          dropDownButton: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.black,
                                          ),
                                          showAsSuffixIcons: true,
                                          // popupTitle: Column(
                                          //   children: [
                                          //     Padding(padding: EdgeInsets.only(top: 20)),
                                          //     Row(
                                          //       crossAxisAlignment: CrossAxisAlignment.start,
                                          //       children: [
                                          //         Padding(padding: EdgeInsets.only(left: 10)),
                                          //         Text(
                                          //           'Selecione a linha',
                                          //           style: TextStyle(fontWeight: FontWeight.bold),
                                          //         ),
                                          //         // Padding(padding: EdgeInsets.only(top: 20, left: 60)),
                                          //       ],
                                          //     ),
                                          //     Padding(padding: EdgeInsets.only(top: 20)),
                                          //   ],
                                          // ),
                                        ),
                                      );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextComponent('Material'),
                      Padding(padding: EdgeInsets.only(top: 6)),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Flexible(
                              child: InputComponent(
                                hintText: 'ID',
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Flexible(
                            child: InputComponent(
                              hintText: 'Nome Material',
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonComponent(
                  onPressed: () {
                    criar(context);
                  },
                  text: 'Salvar',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
