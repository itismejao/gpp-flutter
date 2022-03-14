import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/views/entrada/entrada_manual_view.dart';
import 'package:gpp/src/views/entrada/entrada_pedido_view.dart';

import 'entrada_historico_view.dart';

// ignore: must_be_immutable
class MenuEntradaView extends StatefulWidget {
  int? selected;

  MenuEntradaView({this.selected});

  @override
  _MenuEntradaViewState createState() => _MenuEntradaViewState();
}

class _MenuEntradaViewState extends State<MenuEntradaView> {
  int selected = 1;

  @override
  void initState() {
    if (widget.selected != null) selected = widget.selected!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _entradaMenu(),
        ),
        Padding(padding: EdgeInsets.only(left: 20)),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _entradaNavigator(),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(left: 20)),
      ],
    );
  }

  _entradaMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: const TitleComponent(
            'Entrada',
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
                  color:
                      selected == 1 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor:
                      selected == 1 ? secundaryColor : Colors.transparent,
                  data: 'Entrada via Pedido',
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
                  color:
                      selected == 2 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor:
                      selected == 2 ? secundaryColor : Colors.transparent,
                  data: 'Entrada Manual',
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
                  color:
                      selected == 3 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor:
                      selected == 3 ? secundaryColor : Colors.transparent,
                  data: 'Histórico',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _entradaNavigator() {
    switch (selected) {
      case 1:
        return EntradaPedidoView();
      case 2:
        return EntradaManualView();
      case 3:
        return EntradaHistoricoView();
    }
  }
}
