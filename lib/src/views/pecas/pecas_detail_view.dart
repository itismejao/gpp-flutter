import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_especie_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_grupo_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_material_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/produto_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_especie_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_grupo_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_material_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/pecas/cores_detail_view.dart';
import 'package:gpp/src/views/pecas/linha_detail_view.dart';
import 'package:gpp/src/views/pecas/material_detail_view.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import 'package:gpp/src/views/pecas/und_medida.dart';
import 'package:gpp/src/views/pecas/unidade.dart';

class PecasDetailView extends StatefulWidget {
  const PecasDetailView({Key? key}) : super(key: key);

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

  final txtIdLinha = TextEditingController();
  final txtIdEspecie = TextEditingController();
  final txtIdGrupo = TextEditingController();
  final txtIdMaterial = TextEditingController();

  PecasLinhaModel _selectedLinha = PecasLinhaModel(id_peca_linha: 1, linha: '', situacao: 1);
  List<PecasEspecieModel> _pecasEspecieModel = [PecasEspecieModel(id_peca_especie: 1, especie: '', id_peca_linha: 1)];

  PecasGrupoModel _selectedGrupo = PecasGrupoModel(id_peca_grupo_material: 1, grupo: '', situacao: 1);
  List<PecasMaterialModel> _pecasMaterialModel = [
    PecasMaterialModel(id_peca_material_fabricacao: 1, material: '', sigla: '', situacao: 1)
  ];

  UnidadeTipo? _selectedUnidadeTipo = UnidadeTipo.Unidade;
  UnidadeMedida? _selectedUnidadeMedida = UnidadeMedida.Centimetros;

  PecasModel? _pecasModelInserido = PecasModel();

  buscaProduto(String codigo) async {
    await _produtoController.buscar(codigo);
  }

  buscarLinhaEspecie(String codigo) async {
    await _pecasLinhaController.buscarEspecieVinculada(codigo);

    await _pecasLinhaController.buscarTodos();

    print('Dentro funcao');
    // print(await _pecasLinhaController.buscarEspecieVinculada(codigo));
  }

  criarPeca() async {
    try {
      _pecasModelInserido = await _pecasController.criarPeca();
    } catch (e) {
      print(e.toString());
    }
  }

  criarProdutoPeca(context) async {
    NotifyController notify = NotifyController(context: context);
    try {
      _pecasController.produtoPecaModel.id_peca = _pecasModelInserido!.id_peca;

      if (await _pecasController.criarProdutoPeca()) {
        notify.sucess("Peça cadastrada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  @override
  void initState() {
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
              Icon(Icons.add_box),
              Padding(padding: EdgeInsets.only(right: 12)),
              TitleComponent('Cadastrar Peças'),
            ],
          ),
        ),
        Divider(),
        Padding(padding: EdgeInsets.only(bottom: 30)),
        Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 2,
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

                            _pecasController.produtoPecaModel.id_produto = int.parse(txtIdProduto.text);
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  flex: 5,
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
                Flexible(
                  flex: 2,
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
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 5,
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
                  flex: 6,
                  child: InputComponent(
                    label: 'Descrição da Peça',
                    onChanged: (value) {
                      _pecasController.pecasModel.descricao = value;
                      _pecasController.pecasModel.volumes = "1";
                      _pecasController.pecasModel.active = 1;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 1,
                  child: InputComponent(
                    label: 'Quantidade',
                    onChanged: (value) {
                      _pecasController.produtoPecaModel.quantidade_por_produto = int.parse(value);
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InputComponent(
                    label: 'Número',
                    onChanged: (value) {
                      _pecasController.pecasModel.numero = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 1,
                  child: InputComponent(
                    label: 'Código de Fabrica',
                    onChanged: (value) {
                      _pecasController.pecasModel.codigo_fabrica = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 1,
                  child: InputComponent(
                    label: 'Custo R\$',
                    onChanged: (value) {
                      _pecasController.pecasModel.custo = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                // Flexible(
                //   flex: 1,
                //   child: InputComponent(
                //     label: 'Unidade',
                //     onChanged: (value) {
                //       _pecasController.pecasModel.unidade = int.parse(value);
                //     },
                //   ),
                // ),
                // Padding(padding: EdgeInsets.only(right: 30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextComponent('Unidade'),
                    Padding(padding: EdgeInsets.only(top: 6)),
                    Container(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<UnidadeTipo>(
                          value: UnidadeTipo.values[_selectedUnidadeTipo!.index],
                          onChanged: (UnidadeTipo? value) {
                            setState(() {
                              _selectedUnidadeTipo = value;

                              _pecasController.pecasModel.unidade = value!.index;
                            });
                          },
                          items: UnidadeTipo.values.map((UnidadeTipo? unidadeTipo) {
                            return DropdownMenuItem<UnidadeTipo>(value: unidadeTipo, child: Text(unidadeTipo!.name));
                          }).toList(),
                        ),
                      ),
                    )
                  ],
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
                    onChanged: (value) {
                      _pecasController.pecasModel.largura = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Altura',
                    onChanged: (value) {
                      _pecasController.pecasModel.altura = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Profundidade',
                    onChanged: (value) {
                      _pecasController.pecasModel.profundidade = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextComponent('Und. Medida'),
                    Padding(padding: EdgeInsets.only(top: 6)),
                    Container(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<UnidadeMedida>(
                          value: UnidadeMedida.values[_selectedUnidadeMedida!.index],
                          onChanged: (UnidadeMedida? value) {
                            setState(() {
                              _selectedUnidadeMedida = value;

                              _pecasController.pecasModel.unidade_medida = value!.index;
                            });
                          },
                          items: UnidadeMedida.values.map((UnidadeMedida? unidadeMedida) {
                            return DropdownMenuItem<UnidadeMedida>(value: unidadeMedida, child: Text(unidadeMedida!.name));
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
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
                          Flexible(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: txtIdLinha,
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
                          Padding(padding: EdgeInsets.only(right: 10)),
                          // Flexible(
                          //   child: InputComponent(
                          //     hintText: 'Nome Linha',
                          //     onChanged: (value) {},
                          //   ),
                          // ),
                          Flexible(
                            flex: 5,
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
                                          itemAsString: (PecasLinhaModel? value) => value!.linha!.toUpperCase(),
                                          onChanged: (value) {
                                            _selectedLinha = value!;
                                            txtIdLinha.text = value.id_peca_linha.toString();

                                            setState(() {
                                              _pecasEspecieModel = value.especie!;
                                            });
                                            // _pecasLinhaController.pecasLinhaModel.id_peca_linha = value!.id_peca_linha;
                                          },
                                          dropdownSearchDecoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          dropDownButton: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.black,
                                          ),
                                          showAsSuffixIcons: true,
                                          selectedItem: _selectedLinha,
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
                          Flexible(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: txtIdEspecie,
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
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Flexible(
                            flex: 5,
                            child: Container(
                              width: 600,
                              height: 48,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownSearch<PecasEspecieModel?>(
                                mode: Mode.DIALOG,
                                showSearchBox: true,
                                items: _pecasEspecieModel,
                                itemAsString: (PecasEspecieModel? value) => value!.especie!.toUpperCase(),
                                onChanged: (value) {
                                  txtIdEspecie.text = value!.id_peca_especie.toString();

                                  _pecasController.pecasModel.id_peca_especie = value.id_peca_especie;
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
                          // Flexible(
                          //   flex: 2,
                          //   child: InputComponent(
                          //     hintText: 'ID',
                          //     onChanged: (value) {},
                          //   ),
                          // ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: txtIdGrupo,
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
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Flexible(
                            flex: 5,
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
                                          itemAsString: (PecasGrupoModel? value) => value!.grupo!.toUpperCase(),
                                          onChanged: (value) {
                                            _selectedGrupo = value!;
                                            txtIdGrupo.text = value.id_peca_grupo_material.toString();

                                            setState(() {
                                              _pecasMaterialModel = value.material_fabricacao!;
                                            });
                                          },
                                          dropdownSearchDecoration: InputDecoration(
                                            enabledBorder: InputBorder.none,
                                          ),
                                          dropDownButton: Icon(
                                            Icons.arrow_drop_down_rounded,
                                            color: Colors.black,
                                          ),
                                          showAsSuffixIcons: true,
                                          selectedItem: _selectedGrupo,
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
                          Flexible(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: txtIdMaterial,
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
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Flexible(
                            flex: 5,
                            child: Container(
                              width: 600,
                              height: 48,
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownSearch<PecasMaterialModel?>(
                                mode: Mode.DIALOG,
                                showSearchBox: true,
                                items: _pecasMaterialModel,
                                itemAsString: (PecasMaterialModel? value) => value!.material!.toUpperCase(),
                                onChanged: (value) {
                                  txtIdMaterial.text = value!.id_peca_material_fabricacao.toString();

                                  _pecasController.pecasModel.id_peca_material_fabricacao = value.id_peca_material_fabricacao;
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
                  onPressed: () async {
                    await criarPeca();
                    await criarProdutoPeca(context);

                    print('idPeca depois de inserido');
                    print(_pecasModelInserido!.id_peca.toString());
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
