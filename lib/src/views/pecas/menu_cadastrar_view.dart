import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/views/pecas/pecas_detail_view.dart';

import 'cores_detail_view.dart';
import 'linha_detail_view.dart';
import 'material_detail_view.dart';

class MenuCadastrarView extends StatefulWidget {
  const MenuCadastrarView({Key? key}) : super(key: key);

  @override
  _MenuCadastrarViewState createState() => _MenuCadastrarViewState();
}

class _MenuCadastrarViewState extends State<MenuCadastrarView> {
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
                  data: 'Linha e Espécie',
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
        return PecasDetailView();
      case 2:
        return CoresDetailView();
      case 3:
        return MaterialDetailView();
      case 4:
        return EspecieDetailView();
    }
  }
}
