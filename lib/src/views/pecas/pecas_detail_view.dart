import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_especie_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_grupo_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_material_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_grupo_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
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

  @override
  void initState() {
    _pecasLinhaController.buscarEspecieVinculada(1);
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
                // Produto
                SizedBox(
                  width: 80,
                  child: Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          // _pecasController.pecasModel.id_produto = int.parse(value);
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
                // Fim Produto
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
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
                    onChanged: (value) {
                      _pecasController.pecasModel.numero = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Código de Fabrica',
                    onChanged: (value) {
                      _pecasController.pecasModel.codigo_fabrica = value;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Custo R\$',
                    onChanged: (value) {
                      _pecasController.pecasModel.custo = double.parse(value);
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  child: InputComponent(
                    label: 'Unidade',
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
                Flexible(
                  child: InputComponent(
                    label: 'Und. Medida',
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
                                future: _pecasLinhaController.buscarEspecieVinculada(1),
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
                    _pecasController.create();
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
