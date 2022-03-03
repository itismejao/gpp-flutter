import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/peca_enderecamento_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/produto_controller.dart';
import 'package:gpp/src/models/PecaEstoqueModel.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_estoque_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/models/pecas_model/produto_model.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/titleComponent.dart';
import 'package:gpp/src/shared/components/inputComponent.dart';
import 'package:gpp/src/shared/components/buttonComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/views/pecas/endereco_detail_view.dart';
import 'package:gpp/src/views/pecas/pop_up_editar.dart';
import 'package:gpp/src/views/pecas/cores_detail_view.dart';

class PecaEnderecamentoDetailView extends StatefulWidget {
  const PecaEnderecamentoDetailView({Key? key}) : super(key: key);

  @override
  _PecaEnderecamentoDetailViewState createState() =>
      _PecaEnderecamentoDetailViewState();
}

class _PecaEnderecamentoDetailViewState
    extends State<PecaEnderecamentoDetailView> {

  late PecaEnderecamentoController pecaEnderecamentoController;
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

  TextEditingController _controllerIdPiso = new TextEditingController();
  TextEditingController _controllerIdCorredor = new TextEditingController();
  TextEditingController _controllerIdEstante= new TextEditingController();
  TextEditingController _controllerIdPrateleira = new TextEditingController();
  TextEditingController _controllerIdBox = new TextEditingController();


  int? id_filial, id_fornecedor, id_produto, id_peca, id_piso, id_corredor, id_estante,id_prateleira, id_box;

  @override
  void initState() {
    pecaEnderecamentoController = PecaEnderecamentoController();
    _pecasController = PecasController();
    _produtoController = ProdutoController();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(Icons.add_box),
            Padding(padding: EdgeInsets.only(right: 12)),
            TitleComponent('Endereçar Peças'),
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
            Padding(padding: EdgeInsets.only(right: 10)),
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
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
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
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {

                        },
                        icon: Icon(Icons.search),
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
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
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            // Fim Fornecedor
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          children: [
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
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (_controllerIdProduto.text == '') {
                          limparFieldsPeca();
                        } else {
                          buscarProduto(_controllerIdProduto.text);
                        }
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
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
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
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
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (_controllerIdPeca.text == '') {
                            limparFieldsPeca();
                          } else {
                            buscarPeca(_controllerIdPeca.text);
                          }
                        },
                        icon: Icon(Icons.search),
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
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
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            // Fim Fornecedor
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controllerIdPiso,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Piso',
                      labelText: 'Piso',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: TextFormField(
                controller: _controllerIdCorredor,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Corredor',
                  labelText: 'Corredor',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(top: 15, bottom: 10, left: 10),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: TextFormField(
                controller: _controllerIdEstante,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Estante',
                  labelText: 'Estante',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(top: 15, bottom: 10, left: 10),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: TextFormField(
                controller: _controllerIdPrateleira,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Prateleira',
                  labelText: 'Prateleira',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(top: 15, bottom: 10, left: 10),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: TextFormField(
                controller: _controllerIdBox,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Box',
                  labelText: 'Box',
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.only(top: 15, bottom: 10, left: 10),
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        ButtonComponent(onPressed: () {
          setState(() {
            id_filial = _controllerIdFilial.text != '' ? int.parse(_controllerIdFilial.text) : null;
            id_fornecedor = _controllerIdFornecedor.text != '' ? int.parse(_controllerIdFornecedor.text) : null;
            id_produto = _controllerIdProduto.text != '' ? int.parse(_controllerIdProduto.text) : null;
            id_peca = _controllerIdPeca.text != '' ? int.parse(_controllerIdPeca.text) : null;
            id_piso = _controllerIdPiso.text != '' ? int.parse(_controllerIdPiso.text) : null;
            id_corredor = _controllerIdCorredor.text != '' ? int.parse(_controllerIdCorredor.text) : null;
            id_estante = _controllerIdEstante.text != '' ? int.parse(_controllerIdEstante.text) : null;
            id_prateleira = _controllerIdPrateleira.text != '' ? int.parse(_controllerIdPrateleira.text) : null;
            id_box = _controllerIdBox.text != '' ? int.parse(_controllerIdBox.text) : null;
          });
        }, text: 'Pesquisar')
      ]),
      Padding(padding: EdgeInsets.only(top: 30)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Endereços'),
                ],
              ),
              Row(
                children: [
                  ButtonComponent(
                      color: primaryColor,
                      onPressed: () {},
                      text: 'Salvar'),
                  SizedBox(
                    width: 12,
                  ),
                  ButtonComponent(
                      color: secundaryColor,
                      onPressed: () {
                        limparFields();
                      },
                      text: 'Limpar')
                ],
              ),


            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InputComponent(
        //           prefixIcon: Icon(
        //             Icons.search,
        //           ),
        //           hintText: 'Buscar',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: const TextComponent('Filial',textAlign: TextAlign.center,),
              ),
              Expanded(
                child: const TextComponent('Piso', textAlign: TextAlign.center,),
              ),
              Expanded(
                child: const TextComponent('Endereço'),
              ),
              Expanded(
                child: const TextComponent('Medida Box', textAlign: TextAlign.center,),
              ),
              Expanded(
                child: const TextComponent('Cod. Peça', textAlign: TextAlign.center,),
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
                child: const TextComponent('Disp.', textAlign: TextAlign.center,),
              ),
              Expanded(
                child: const TextComponent('Reserv.', textAlign: TextAlign.center,),
              ),
              Expanded(
                child: const TextComponent('Ações', textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
        const Divider(),
        FutureBuilder(
          future: pecaEnderecamentoController.buscarTodos(pecaEnderecamentoController.pagina.atual,id_filial,id_fornecedor,id_produto,id_peca,id_piso, id_corredor, id_estante,id_prateleira, id_box),
          builder: (context, AsyncSnapshot<List<PecaEnderacamentoModel>> snapshot) {

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
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Container(
                    height: 500,
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
                                  snapshot.data![index].peca_estoque!.filial.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].descPiso ?? '',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].endereco,
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                child: Text('?'+'x'+'?'+'x'+'?',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].peca_estoque!.pecasModel!.id_peca.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(snapshot.data![index].peca_estoque!.pecasModel!.descricao ?? ''),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(snapshot.data![index].nomeFornecedor ?? ''),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].peca_estoque!.saldo_disponivel.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(snapshot.data![index].peca_estoque!.saldo_reservado.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade400,
                                      ),
                                      onPressed: () => {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return PopUpEditar.popUpPeca(context,EnderecoDetailView(pecaEnderecamento: snapshot.data![index]));
                                            }).then((value) => setState(() {}))
                                      },
                                    ),
                                    IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.grey.shade400,
                                        ),
                                        onPressed: () {

                                        }),
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
                  TextComponent(pecaEnderecamentoController.pagina.atual.toString()),
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

  limparFieldsLoc(){
    _controllerIdPiso.clear();
    _controllerIdCorredor.clear();
    _controllerIdEstante.clear();
    _controllerIdPrateleira.clear();
    _controllerIdBox.clear();
  }

  limparFieldsPeca(){
    _controllerIdFornecedor.clear();
    _controllerNomeFornecedor.clear();

    _controllerIdProduto.clear();
    _controllerNomeProduto.clear();

    _controllerIdPeca.clear();
    _controllerNomePeca.clear();
  }

  limparFields(){
     limparFieldsPeca();
     limparFieldsLoc();
  }

  buscarPeca(String id) async{
    peca = await _pecasController.buscar(id);
    _controllerNomePeca.text = peca?.descricao ?? '';
    if (peca?.produto_peca?[0].id_produto != null)
      buscarProduto(peca!.produto_peca![0].id_produto
          .toString());
  }

  buscarProduto(String id) async{
    await _produtoController.buscar(id);
    _controllerNomeProduto.text = _produtoController.produtoModel.resumida ?? '';
    _controllerIdProduto.text = _produtoController.produtoModel.id_produto
            .toString();
    _controllerNomeFornecedor.text =
        _produtoController.produtoModel.fornecedor?[0]
            .cliente!.nome ?? '';
    _controllerIdFornecedor.text =
        _produtoController.produtoModel.id_fornecedor
            .toString();
  }

  buscarFornecedor(String id){

  }

}
