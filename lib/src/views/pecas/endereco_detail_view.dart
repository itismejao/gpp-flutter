import 'package:flutter/material.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

class EnderecoDetailView extends StatefulWidget {
  PecaEnderacamentoModel? pecaEnderecamento;

  EnderecoDetailView({
    this.pecaEnderecamento
});

  @override
  _EnderecoDetailViewState createState() => _EnderecoDetailViewState();
}

class _EnderecoDetailViewState extends State<EnderecoDetailView> {

  PecaEnderacamentoModel? pecaEnderecamento;

  @override
  void initState() {
    pecaEnderecamento = widget.pecaEnderecamento;

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
            Icon(pecaEnderecamento == null ? Icons.add_box : Icons.edit),
            Padding(padding: EdgeInsets.only(right: 12)),
            TitleComponent(pecaEnderecamento == null ? 'Endereçar' : 'Editar Endereço'),
          ],
        ),
      ),
      Divider(),
      Padding(padding: EdgeInsets.only(bottom: 20)),
      Column(
        children: [
          pecaEnderecamento == null
              ? Container()
              : Row(
            children: [
              Flexible(
                child: InputComponent(
                  enable: true,
                  initialValue: pecaEnderecamento?.peca_estoque?.pecasModel?.id_peca.toString(),
                  label: 'ID Peça',
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                flex: 4,
                child: InputComponent(
                  enable: false,
                  initialValue: pecaEnderecamento?.peca_estoque?.pecasModel?.descricao ?? '',
                  label: 'Nome Peça',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Flexible(
                    child: InputComponent(
                      initialValue: pecaEnderecamento?.descPiso ?? '',
                      label: 'Piso',
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 10)),

          Row(
            children: [
              Flexible(
                child: InputComponent(
                  initialValue: pecaEnderecamento?.descPiso ?? '',
                  label: 'Corredor',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              Flexible(
                child: InputComponent(
                  initialValue: pecaEnderecamento?.descPiso ?? '',
                  label: 'Estante',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              Flexible(
                child: InputComponent(
                  initialValue: pecaEnderecamento?.descPiso ?? '',
                  label: 'Prateleira',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              Flexible(
                child: InputComponent(
                  initialValue: pecaEnderecamento?.descPiso ?? '',
                  label: 'Box',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              pecaEnderecamento == null
                  ? ButtonComponent(
                onPressed: () {
                  //create(context);
                },
                text: 'Endereçar',
              )
                  : Row(
                children: [
                  ButtonComponent(
                    onPressed: () {
                      // _pecasCorController.editar();
                      //editar(context);
                      Navigator.pop(context);
                    },
                    text: 'Editar',
                  ),
                  Padding(padding: EdgeInsets.only(right: 20)),
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
        ],
      ),
    ]);
  }
}
