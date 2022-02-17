import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_cor_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_cor_model.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/pecas/menu_consultar_view.dart';

class CoresDetailView extends StatefulWidget {
  PecasCorModel? pecaCor;

  CoresDetailView({this.pecaCor});

  @override
  _CoresDetailViewState createState() => _CoresDetailViewState();
}

class _CoresDetailViewState extends State<CoresDetailView> {
  PecasCorController _pecasCorController = PecasCorController();
  PecasCorModel? pecaCor;

  @override
  void initState() {
    pecaCor = widget.pecaCor;
    if (pecaCor != null)
      _pecasCorController.pecasCorModel = pecaCor!;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(pecaCor == null ? Icons.add_box : Icons.edit),
            Padding(padding: EdgeInsets.only(right: 12)),
            TitleComponent(pecaCor == null ? 'Cadastrar Cores' : 'Editar Cor'),
          ],
        ),
      ),
      Divider(),
      Padding(padding: EdgeInsets.only(bottom: 20)),
      Column(
        children: [
          pecaCor == null ?
              Container()
          :
          Row(
              children: [
                Flexible(
                  child: InputComponent(
                    enable: false,
                    initialValue: pecaCor!.id_peca_cor.toString(),
                    label: 'ID',
                    onChanged: (value) {
                      _pecasCorController.pecasCorModel.id_peca_cor = value;
                    },
                  ),
                ),
              ]
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              Flexible(
                child: InputComponent(
                  initialValue: pecaCor == null ? '' : pecaCor!.cor,
                  label: 'Cor',
                  onChanged: (value) {
                    _pecasCorController.pecasCorModel.cor = value;
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                child: InputComponent(
                  initialValue: pecaCor == null ? '' : pecaCor?.sigla,
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
              pecaCor == null ?
              ButtonComponent(
                onPressed: () {
                  _pecasCorController.create();
                },
                text: 'Salvar',
              ) :
                ButtonComponent(
                  onPressed: () {
                    Navigator.pop(context);
                    _pecasCorController.edit();

                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuConsultarView(selected: 2),
                        ));*/
                  },
                  text: 'Editar',
                ),
              pecaCor == null ?
                  Container()
                  :
              ButtonComponent(
                onPressed: () {
                 Navigator.pop(context);
                },
                text: 'Cancelar',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
