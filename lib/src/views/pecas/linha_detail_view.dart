import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';

class EspecieDetailView extends StatefulWidget {
  const EspecieDetailView({Key? key}) : super(key: key);

  @override
  _EspecieDetailViewState createState() => _EspecieDetailViewState();
}

class _EspecieDetailViewState extends State<EspecieDetailView> {
  PecasLinhaController _pecasLinhaController = PecasLinhaController();

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
            TitleComponent('Cadastrar Linha e Espécie'),
          ],
        ),
      ),
      Divider(),
      Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Flexible(
                child: InputComponent(
                  label: 'Linha',
                  onChanged: (value) {
                    _pecasLinhaController.pecasLinhaModel.linha = value;
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonComponent(
                onPressed: () {
                  _pecasLinhaController.create();
                },
                text: 'Salvar',
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            children: [
              Text(
                'Cadastrar Espécie',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Divider(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            children: [
              SizedBox(
                width: 180,
                child: InputComponent(
                  label: 'Selecione a Linha',
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                child: InputComponent(
                  label: 'Espécie',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonComponent(
                onPressed: () {},
                text: 'Salvar',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
