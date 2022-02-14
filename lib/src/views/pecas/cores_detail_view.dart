import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_cor_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class CoresDetailView extends StatefulWidget {
  const CoresDetailView({Key? key}) : super(key: key);

  @override
  _CoresDetailViewState createState() => _CoresDetailViewState();
}

class _CoresDetailViewState extends State<CoresDetailView> {
  PecasCorController _pecasCorController = PecasCorController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(Icons.add_box),
            Padding(padding: EdgeInsets.only(right: 12)),
            TitleComponent('Cadastrar Cores'),
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
                child: InputComponent(
                  label: 'Cor',
                  onChanged: (value) {
                    _pecasCorController.pecasCorModel.cor = value;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                child: InputComponent(
                  label: 'Sigla',
                  onChanged: (value) {
                    _pecasCorController.pecasCorModel.sigla = value;
                  },
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonComponent(
                onPressed: () {
                  _pecasCorController.create();
                },
                text: 'Salvar',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
