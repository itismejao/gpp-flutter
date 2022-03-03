import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

import '../../models/box_enderecamento_model.dart';

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

  late EnderecamentoController enderecamentoController;

  @override
  void initState() {
    pecaEnderecamento = widget.pecaEnderecamento;
    enderecamentoController = EnderecamentoController();
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
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarBox(pecaEnderecamento!.box!.id_prateleira.toString()),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text("Sem conexão!");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                                child:
                                new CircularProgressIndicator());
                          case ConnectionState.done:
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              child: DropdownSearch<BoxEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (BoxEnderecamentoModel? value) =>
                                    value!.desc_box!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    pecaEnderecamento!.box = value!;
                                  });

                                },
                                dropdownSearchDecoration:
                                InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione o Box:",
                                    labelText: "Box"
                                ),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: pecaEnderecamento!.box,
                                showClearButton: true,
                                clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){

                                  //limparBox();

                                },),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child:
                                    //_prateleiraSelected == null ?
                                    //Text('Selecione uma Prateleira!') :
                                    Text('Box não encontrado!')

                                ),
                              ),
                            );}})
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
