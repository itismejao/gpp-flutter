import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
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
    print('id_corredor');
    print(pecaEnderecamento!.box!.prateleira!.estante!.corredor!.id_corredor?.toString());
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
              const Padding(padding: EdgeInsets.only(left: 5)),
              Flexible(
                flex: 1,
                child: InputComponent(
                  enable: true,
                  initialValue: pecaEnderecamento?.peca_estoque?.pecasModel?.id_peca.toString(),
                  label: 'ID Peça',
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
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
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 5)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarTodos(),
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
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                BorderRadius.circular(5),
                              ),
                              child: DropdownSearch<PisoEnderecamentoModel>(
                                mode: Mode.MENU,
                                enabled: false,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (PisoEnderecamentoModel? value) =>
                                value?.id_filial == null ? value!.desc_piso!.toUpperCase() :
                                value!.desc_piso!.toUpperCase() + " (" + value.id_filial.toString() + ")",
                                onChanged: (value) {
                                  setState(() {
                                    //limparCorredor();
                                    pecaEnderecamento!.box!.prateleira!.estante!.corredor!.piso = value!;

                                  });
                                },
                                dropdownSearchDecoration:
                                InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione o Piso:",
                                    labelText: "Piso"
                                ),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: pecaEnderecamento!.box!.prateleira!.estante!.corredor!.piso,
                                showClearButton: true,
                                clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){
                                 // limparFieldsLoc();
                                },),
                                emptyBuilder: (context, searchEntry) => Center(child: Text('Nenhum piso encontrado!')),
                              ),
                            );}})
              ),

              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarCorredor(pecaEnderecamento!.box!.prateleira!.estante!.corredor!.piso!.id_piso?.toString() ?? ''),
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
                              child: DropdownSearch<CorredorEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (CorredorEnderecamentoModel? value) =>
                                    value!.desc_corredor!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    //limparEstante();
                                    pecaEnderecamento!.box!.prateleira!.estante!.corredor = value!;
                                  });

                                },
                                dropdownSearchDecoration:
                                InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione o Corredor:",
                                    labelText: "Corredor"
                                ),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: pecaEnderecamento!.box!.prateleira!.estante!.corredor,
                                showClearButton: true,
                                clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){

                                  //limparCorredor();

                                },),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child:
                                    pecaEnderecamento!.box!.prateleira!.estante!.corredor!.piso == null ?
                                    Text('Selecione um Piso!') :
                                    Text('Corredor não encontrado!')

                                ),
                              ),
                            );}})

              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarEstante(pecaEnderecamento!.box!.prateleira!.estante!.corredor!.id_corredor?.toString() ?? ''),
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
                              child: DropdownSearch<EstanteEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (EstanteEnderecamentoModel? value) =>
                                    value!.desc_estante!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    //limparPrateleira();
                                    pecaEnderecamento!.box!.prateleira!.estante = value!;
                                  });

                                },
                                dropdownSearchDecoration:
                                InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione a Estante:",
                                    labelText: "Estante"
                                ),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: pecaEnderecamento!.box!.prateleira!.estante,
                                showClearButton: true,
                                clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){

                                  //limparEstante();

                                },),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child:
                                    pecaEnderecamento!.box!.prateleira!.estante!.corredor == null ?
                                    Text('Selecione um Corredor!') :
                                    Text('Estante não encontrado!')

                                ),
                              ),
                            );}})
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarPrateleira(pecaEnderecamento!.box!.prateleira!.id_estante.toString()),
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
                              child: DropdownSearch<PrateleiraEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (PrateleiraEnderecamentoModel? value) =>
                                    value!.desc_prateleira!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    pecaEnderecamento!.box!.prateleira = value!;
                                  });

                                },
                                dropdownSearchDecoration:
                                InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione a Prateleira:",
                                    labelText: "Prateleira"
                                ),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: pecaEnderecamento!.box!.prateleira,
                                showClearButton: true,
                                clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){

                                  //limparPrateleira();

                                },),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child:
                                    pecaEnderecamento!.box!.prateleira!.estante == null ?
                                    Text('Selecione uma Estante!') :
                                    Text('Prateleira não encontrado!')

                                ),
                              ),
                            );}})
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarBox(pecaEnderecamento!.box!.prateleira!.id_prateleira.toString()),
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
                                    pecaEnderecamento!.box!.prateleira == null ?
                                    Text('Selecione uma Prateleira!') :
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
