import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/pecas/cores_detail_view.dart';
import 'package:gpp/src/views/pecas/especie_detail_view.dart';
import 'package:gpp/src/views/pecas/material_detail_view.dart';

class PecasDetailView extends StatefulWidget {
  const PecasDetailView({Key? key}) : super(key: key);

  @override
  _PecasDetailViewState createState() => _PecasDetailViewState();
}

class _PecasDetailViewState extends State<PecasDetailView> {
  PecasController _pecasController = PecasController();

  int selected = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _pecasMenu(),
        ),
        Padding(padding: EdgeInsets.only(left: 20)),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _pecasNavigator(),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 20)),
      ],
    );
  }

  _pecasMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: const TitleComponent(
            'Cadastros',
          ),
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 1;
                  });
                },
                child: ItemMenu(
                  color: selected == 1 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: selected == 1 ? secundaryColor : Colors.transparent,
                  data: 'Peça',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 2;
                  });
                },
                child: ItemMenu(
                  color: selected == 2 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: selected == 2 ? secundaryColor : Colors.transparent,
                  data: 'Cores',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 3;
                  });
                },
                child: ItemMenu(
                  color: selected == 3 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: selected == 3 ? secundaryColor : Colors.transparent,
                  data: 'Fabricação',
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selected = 4;
                  });
                },
                child: ItemMenu(
                  color: selected == 4 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: selected == 4 ? secundaryColor : Colors.transparent,
                  data: 'Espécie',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _pecasNavigator() {
    switch (selected) {
      case 1:
        return _pecas();
      case 2:
        return CoresDetailView();
      case 3:
        return MaterialDetailView();
      case 4:
        return EspecieDetailView();
    }
  }

  _pecas() {
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
            Padding(padding: EdgeInsets.only(top: 20)),
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
                      _pecasController.pecasModel.volumes = 1;
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
            Padding(padding: EdgeInsets.only(top: 20)),
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
            Padding(padding: EdgeInsets.only(top: 20)),
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
                          Flexible(
                            child: InputComponent(
                              hintText: 'Nome Linha',
                              onChanged: (value) {},
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
                          Flexible(
                            child: InputComponent(
                              hintText: 'Nome Espécie',
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
            Padding(padding: EdgeInsets.only(top: 20)),
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
                          Flexible(
                            child: InputComponent(
                              hintText: 'Descrição Material',
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

  _selectedCores() {
    return Column(
      children: [
        Text('Aba Cores'),
      ],
    );
  }
}
