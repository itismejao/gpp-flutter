import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/fornecedor_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/peca_enderecamento_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/produto_controller.dart';

import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/views/pecas/endereco_detail_view.dart';
import 'package:gpp/src/views/pecas/pop_up_editar.dart';

class PecaEnderecamentoDetailView extends StatefulWidget {
  const PecaEnderecamentoDetailView({Key? key}) : super(key: key);

  @override
  _PecaEnderecamentoDetailViewState createState() =>
      _PecaEnderecamentoDetailViewState();
}

class _PecaEnderecamentoDetailViewState
    extends State<PecaEnderecamentoDetailView> {
  late PecaEnderecamentoController pecaEnderecamentoController;
  late EnderecamentoController enderecamentoController;
  late PecasController _pecasController;
  late ProdutoController _produtoController;
  PecasModel? peca;

  TextEditingController _controllerIdFilial = new TextEditingController();
  TextEditingController _controllerNomeFilial = new TextEditingController();

  TextEditingController _controllerIdFornecedor = new TextEditingController();
  TextEditingController _controllerNomeFornecedor = new TextEditingController();

  TextEditingController _controllerIdProduto = new TextEditingController();
  TextEditingController _controllerNomeProduto = new TextEditingController();

  TextEditingController _controllerIdPeca = new TextEditingController();
  TextEditingController _controllerNomePeca = new TextEditingController();

  int? id_filial, id_fornecedor, id_produto, id_peca;

  PisoEnderecamentoModel? _pisoSelected;
  CorredorEnderecamentoModel? _corredorSelected;
  PrateleiraEnderecamentoModel? _prateleiraSelected;
  EstanteEnderecamentoModel? _estanteSelected;
  BoxEnderecamentoModel? _boxSelected;

  bool abrirFiltro = false;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 20)),
            const Icon(Icons.add_box),
            const Padding(padding: EdgeInsets.only(right: 12)),
            const TitleComponent('Endereçar Peças'),
            new Spacer(),
            ButtonComponent(
                icon: Icon(Icons.tune, color: Colors.white),
                color: secundaryColor,
                onPressed: () {
                  setState(() {
                    abrirFiltro = !abrirFiltro;
                  });
                },
                text: 'Gerenciar filtros'),
            const Padding(padding: EdgeInsets.only(right: 5)),
          ],
        ),
      ),
      const Divider(),
      const Padding(padding: EdgeInsets.only(bottom: 20)),
      Container(
        height: abrirFiltro ? null : 0,
        child: Column(children: [
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 5)),
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerIdFilial,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Filial',
                      labelText: 'Filial',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          //await buscaProduto(txtIdProduto.text);

                          //txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                          //txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                          // txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                        },
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              // Fim Produto
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerNomeFilial,
                    enabled: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nome Filial',
                      labelText: 'Nome Filial',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerIdFornecedor,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                        hintText: 'ID',
                        labelText: 'ID',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_controllerIdFornecedor.text == '') {
                              limparFieldsPeca();
                            } else {
                              buscarFornecedor(_controllerIdFornecedor.text);
                            }
                          },
                          icon: Icon(Icons.search),
                        )),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerNomeFornecedor,
                    enabled: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nome Fornecedor',
                      labelText: 'Nome Fornecedor',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    ),
                  ),
                ),
              ),
              // Fim Fornecedor
              const Padding(padding: EdgeInsets.only(right: 5)),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 5)),
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerIdProduto,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'ID',
                      labelText: 'ID',
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (_controllerIdProduto.text == '') {
                            limparFieldsPeca();
                          } else {
                            buscarProduto(_controllerIdProduto.text);
                          }
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              // Fim Produto
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerNomeProduto,
                    enabled: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nome Produto',
                      labelText: 'Nome Produto',
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerIdPeca,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                        hintText: 'ID',
                        labelText: 'ID',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_controllerIdPeca.text == '') {
                              limparFieldsPeca();
                            } else {
                              buscarPeca(_controllerIdPeca.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                        )),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextFormField(
                    controller: _controllerNomePeca,
                    enabled: false,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nome Peça',
                      labelText: 'Nome Peça',
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    ),
                  ),
                ),
              ),
              // Fim Fornecedor
              const Padding(padding: EdgeInsets.only(right: 5)),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
        ]),
      ),
      Column(
        children: [
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
                          showSearchBox: true,
                          items: snapshot.data,
                          itemAsString:
                              (PisoEnderecamentoModel? value) =>
                              value?.id_filial == null ? value!.desc_piso!.toUpperCase() :
                              value!.desc_piso!.toUpperCase() + " (" + value.id_filial.toString() + ")",
                            onChanged: (value) {
                              setState(() {
                                limparCorredor();
                                _pisoSelected = value!;
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
                            selectedItem: _pisoSelected,
                            showClearButton: true,
                            clearButton: IconButton(icon: Icon(Icons.clear),onPressed: (){
                               limparFieldsLoc();
                            },),
                            emptyBuilder: (context, searchEntry) => Center(child: Text('Nenhum piso encontrado!')),
                      ),
                        );}})
                  ),

              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarCorredor(
                          _pisoSelected?.id_piso.toString() ?? ''),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text("Sem conexão!");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                                child: new CircularProgressIndicator());
                          case ConnectionState.done:
                            return Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
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
                                    limparEstante();
                                    _corredorSelected = value!;
                                  });
                                },
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione o Corredor:",
                                    labelText: "Corredor"),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: _corredorSelected,
                                showClearButton: true,
                                clearButton: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    limparCorredor();
                                  },
                                ),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child: _pisoSelected == null
                                        ? Text('Selecione um Piso!')
                                        : Text('Corredor não encontrado!')),
                              ),
                            );
                        }
                      })),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarEstante(
                          _corredorSelected?.id_corredor.toString() ?? ''),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text("Sem conexão!");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                                child: new CircularProgressIndicator());
                          case ConnectionState.done:
                            return Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
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
                                    limparPrateleira();
                                    _estanteSelected = value!;
                                  });
                                },
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione a Estante:",
                                    labelText: "Estante"),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: _estanteSelected,
                                showClearButton: true,
                                clearButton: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    limparEstante();
                                  },
                                ),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child: _corredorSelected == null
                                        ? Text('Selecione um Corredor!')
                                        : Text('Estante não encontrado!')),
                              ),
                            );
                        }
                      })),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarPrateleira(
                          _estanteSelected?.id_estante.toString() ?? ''),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text("Sem conexão!");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                                child: new CircularProgressIndicator());
                          case ConnectionState.done:
                            return Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child:
                                  DropdownSearch<PrateleiraEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString:
                                    (PrateleiraEnderecamentoModel? value) =>
                                        value!.desc_prateleira!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    limparBox();
                                    _prateleiraSelected = value!;
                                  });
                                },
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione a Prateleira:",
                                    labelText: "Prateleira"),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: _prateleiraSelected,
                                showClearButton: true,
                                clearButton: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    limparPrateleira();
                                  },
                                ),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child: _estanteSelected == null
                                        ? Text('Selecione uma Estante!')
                                        : Text('Prateleira não encontrado!')),
                              ),
                            );
                        }
                      })),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Flexible(
                  flex: 1,
                  child: FutureBuilder(
                      future: enderecamentoController.buscarBox(
                          _prateleiraSelected?.id_prateleira.toString() ?? ''),
                      builder: (context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text("Sem conexão!");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                                child: new CircularProgressIndicator());
                          case ConnectionState.done:
                            return Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownSearch<BoxEnderecamentoModel>(
                                mode: Mode.MENU,
                                showSearchBox: true,
                                items: snapshot.data,
                                itemAsString: (BoxEnderecamentoModel? value) =>
                                    value!.desc_box!.toUpperCase(),
                                onChanged: (value) {
                                  setState(() {
                                    _boxSelected = value!;
                                  });
                                },
                                dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    hintText: "Selecione o Box:",
                                    labelText: "Box"),
                                dropDownButton: Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: Colors.black,
                                ),
                                showAsSuffixIcons: true,
                                selectedItem: _boxSelected,
                                showClearButton: true,
                                clearButton: IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    limparBox();
                                  },
                                ),
                                emptyBuilder: (context, searchEntry) => Center(
                                    child: _prateleiraSelected == null
                                        ? Text('Selecione uma Prateleira!')
                                        : Text('Box não encontrado!')),
                              ),
                            );
                        }
                      })),
              const Padding(padding: EdgeInsets.only(right: 5)),
            ],
          ),
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 20)),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(padding: EdgeInsets.only(left: 5)),
          Flexible(
            child: ButtonComponent(
                onPressed: () {
                  setState(() {
                    abrirFiltro = false;
                    id_filial = _controllerIdFilial.text != ''
                        ? int.parse(_controllerIdFilial.text)
                        : null;
                    id_fornecedor = _controllerIdFornecedor.text != ''
                        ? int.parse(_controllerIdFornecedor.text)
                        : null;
                    id_produto = _controllerIdProduto.text != ''
                        ? int.parse(_controllerIdProduto.text)
                        : null;
                    id_peca = _controllerIdPeca.text != ''
                        ? int.parse(_controllerIdPeca.text)
                        : null;
                  });
                },
                text: 'Pesquisar'),
          ),
          const Padding(padding: EdgeInsets.only(right: 5)),
        ],
      ),
      const Padding(padding: EdgeInsets.only(top: 30)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const TitleComponent('Endereços'),
                ],
              ),
              Row(
                children: [
                  ButtonComponent(
                      color: primaryColor,
                      onPressed: () {
                        limparFields();
                      },
                      text: 'Limpar Filtros')
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: const TextComponent(
                  'Filial',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: const TextComponent(
                  'Piso',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: const TextComponent('Endereço'),
              ),
              Expanded(
                child: const TextComponent(
                  'Medida Box',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: const TextComponent(
                  'Cod. Peça',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: const TextComponent('Descrição Peça'),
              ),
              Expanded(
                flex: 2,
                child: const TextComponent('Fornecedor'),
              ),
              Expanded(
                child: const TextComponent(
                  'Disp.',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: const TextComponent(
                  'Reserv.',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: const TextComponent(
                  'Ações',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        FutureBuilder(
          future: pecaEnderecamentoController.buscarTodos(
              pecaEnderecamentoController.pagina.atual,
              id_filial,
              id_fornecedor,
              id_produto,
              id_peca,
              _pisoSelected?.id_piso,
              _corredorSelected?.id_corredor,
              _estanteSelected?.id_estante,
              _prateleiraSelected?.id_prateleira,
              _boxSelected?.id_box),
          builder:
              (context, AsyncSnapshot<List<PecaEnderacamentoModel>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('none');
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Text('');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container(
                    height: media.height/2,
                    child: ListView.builder(
                      primary: false,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(padding: EdgeInsets.only(left: 10)),
                              // CheckboxComponent(),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].peca_estoque == null ? snapshot.data![index].box!.prateleira!.estante!.corredor!.piso!.id_filial.toString() : snapshot.data![index].peca_estoque!.filial.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].descPiso ?? '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].endereco,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].box?.calcularMedida() ?? '-',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].peca_estoque?.pecasModel
                                          ?.id_peca
                                          .toString() ??
                                      '-',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(snapshot.data![index].peca_estoque
                                        ?.pecasModel?.descricao ??
                                    '-'),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    snapshot.data![index].nomeFornecedor ??
                                        '-'),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].peca_estoque
                                          ?.saldo_disponivel
                                          .toString() ??
                                      '-',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![index].peca_estoque
                                          ?.saldo_reservado
                                          .toString() ??
                                      '-',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: IconButton(
                                        tooltip: snapshot.data![index]
                                                    .id_peca_estoque ==
                                                null
                                            ? 'Endereçar Peça'
                                            : 'Transferir Peça',
                                        icon: Icon(
                                          snapshot.data![index]
                                                      .id_peca_estoque ==
                                                  null
                                              ? Icons.location_on_outlined
                                              : Icons.sync_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () async {
                                          await PopUpEditar.popUpPeca(
                                              context,
                                              EnderecoDetailView(
                                                  pecaEnderecamento:
                                                      snapshot.data![index]));
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                        tooltip: 'Etiqueta',
                                        icon: Icon(
                                          Icons.local_offer_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () => {
                                          //PopUpEditar.popUpPeca(context,EnderecoDetailView(pecaEnderecamento: snapshot.data![index]))
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
        Container(
          height: media.height * 0.10,
          width: media.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent('Total de páginas: ' +
                  pecaEnderecamentoController.pagina.total.toString()),
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.first_page),
                      onPressed: () {
                        setState(() {
                          pecaEnderecamentoController.pagina.atual = 1;
                        });

                        //buscarTodas();
                      }),
                  IconButton(
                      icon: const Icon(
                        Icons.navigate_before_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          if (pecaEnderecamentoController.pagina.atual > 1) {
                            pecaEnderecamentoController.pagina.atual =
                                pecaEnderecamentoController.pagina.atual - 1;
                            //buscarTodas();
                          }
                        });
                      }),
                  TextComponent(
                      pecaEnderecamentoController.pagina.atual.toString()),
                  IconButton(
                      icon: Icon(Icons.navigate_next_rounded),
                      onPressed: () {
                        setState(() {
                          if (pecaEnderecamentoController.pagina.atual !=
                              pecaEnderecamentoController.pagina.total) {
                            pecaEnderecamentoController.pagina.atual =
                                pecaEnderecamentoController.pagina.atual + 1;
                          }
                        });

                        //buscarTodas();
                      }),
                  IconButton(
                      icon: Icon(Icons.last_page),
                      onPressed: () {
                        setState(() {
                          pecaEnderecamentoController.pagina.atual =
                              pecaEnderecamentoController.pagina.total;
                        });

                        //buscarTodas();
                      }),
                ],
              )
            ],
          ),
        )
      ])
    ]);
  }

  @override
  void initState() {
    pecaEnderecamentoController = PecaEnderecamentoController();
    enderecamentoController = EnderecamentoController();
    _pecasController = PecasController();
    _produtoController = ProdutoController();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  limparFieldsLoc() {
    setState(() {
      _pisoSelected = null;
    });
    limparCorredor();
  }

  limparCorredor() {
    setState(() {
      _corredorSelected = null;
    });
    limparEstante();
  }

  limparEstante() {
    setState(() {
      _estanteSelected = null;
    });

    limparPrateleira();
  }

  limparPrateleira() {
    setState(() {
      _prateleiraSelected = null;
    });
    limparBox();
  }

  limparBox() {
    setState(() {
      _boxSelected = null;
    });
  }

  limparFieldsPeca() {
    _controllerIdFornecedor.clear();
    _controllerNomeFornecedor.clear();

    _controllerIdProduto.clear();
    _controllerNomeProduto.clear();

    _controllerIdPeca.clear();
    _controllerNomePeca.clear();

    id_fornecedor = null;
    id_produto = null;
    id_peca = null;

  }

  limparFields() {
    limparFieldsPeca();
    limparFieldsLoc();
  }

  buscarPeca(String id) async {
    peca = await _pecasController.buscar(id);
    _controllerNomePeca.text = peca?.descricao ?? '';
    if (peca?.produto_peca?[0].id_produto != null)
      buscarProduto(peca!.produto_peca![0].id_produto.toString());
  }

  buscarProduto(String id) async {
    await _produtoController.buscar(id);
    _controllerNomeProduto.text =
        _produtoController.produtoModel.resumida ?? '';
    _controllerIdProduto.text =
        _produtoController.produtoModel.id_produto.toString();
    buscarFornecedor(_produtoController.produtoModel.id_fornecedor.toString());
  }

  buscarFornecedor(String id) async {
    FornecedorController _fornecedorController = FornecedorController();
    await _fornecedorController.buscar(id);
    _controllerNomeFornecedor.text = _fornecedorController.fornecedorModel.cliente?.nome ?? '';
    _controllerIdFornecedor.text = _fornecedorController.fornecedorModel.idFornecedor.toString();
  }
}
