import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class PecasDetailView extends StatefulWidget {
  const PecasDetailView({Key? key}) : super(key: key);

  @override
  _PecasDetailViewState createState() => _PecasDetailViewState();
}

class _PecasDetailViewState extends State<PecasDetailView> {
  int selected = 1;

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
      ],
    );
  }

  _pecasNavigator() {
    switch (selected) {
      case 1:
        return _selectedPeca();
      case 2:
        return _selectedCores();
    }
  }

  _selectedPeca() {
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
                  width: 50,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                    child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome Produto',
                  ),
                )),
                Padding(padding: EdgeInsets.only(right: 50)),
                // Fornecedor
                SizedBox(
                  width: 50,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nome Fornecedor',
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
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Descrição Peça',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                SizedBox(
                  width: 100,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Quantidade',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Número',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Código de Fabrica',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Custo R\$',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Unidade',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                Text(
                  'Medidas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Largura'),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Altura'),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Profundidade'),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Und. Medida'),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                Text(
                  'Linha e Espécie',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nome Linha',
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 50)),
                SizedBox(
                  width: 50,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'ID'),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Nome Espécie',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                Text(
                  'Material de Fabricação',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'ID',
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Descrição Material',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: ElevatedButton(onPressed: () {}, child: Text('Salvar')),
                ),
              ],
            ),
            // TESTES
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 50,
            //       child: Flexible(
            //         child: TextFormField(
            //           decoration: InputDecoration(
            //             hintText: 'ID',
            //           ),
            //         ),
            //       ),
            //     ),
            //     Padding(padding: EdgeInsets.only(right: 10)),
            //     Flexible(
            //       child: TextFormField(
            //         decoration: InputDecoration(
            //           hintText: 'Descrição Material',
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // FIM TESTES
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
