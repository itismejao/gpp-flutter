import 'dart:html';

import 'package:flutter/material.dart';
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
      children: [
        Expanded(
          child: _pecasMenu(),
        ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _pecasNavigator(),
            ],
          ),
        )
      ],
    );
  }

  _pecasMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
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
      children: [
        Text('Aba Peça'),
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
