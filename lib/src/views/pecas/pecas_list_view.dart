import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/views/pecas/pecas_detail_view.dart';
import 'package:gpp/src/views/pecas/pecas_edit_view.dart';
import 'package:gpp/src/views/pecas/pop_up_editar.dart';

class PecasListView extends StatefulWidget {
  const PecasListView({Key? key}) : super(key: key);

  @override
  _PecasListViewState createState() => _PecasListViewState();
}

class _PecasListViewState extends State<PecasListView> {
  PecasController _pecasController = PecasController();

  excluir(PecasModel pecasModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await _pecasController.excluir(pecasModel)) {
        notify.sucess("Peça excluída com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  editar() async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await true) {
        notify.sucess("Peça alterada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  buscarTodasPecas() async {
    List pecasRetornadas = await _pecasController.buscarTodos(_pecasController.pecasPagina.paginaAtual!);

    _pecasController.listaPecas = pecasRetornadas[0];
    _pecasController.pecasPagina = pecasRetornadas[1];

    setState(() {
      _pecasController.carregado = true;
      _pecasController.listaPecas;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    buscarTodasPecas();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleComponent(
                      'Peças',
                    ),
                  ],
                ),
              ),
              // _buildState()
            ],
          ),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // CheckboxComponent(),
            Expanded(
              child: TextComponent(
                'ID',
              ),
            ),
            Expanded(
              child: TextComponent('Número'),
            ),
            Expanded(
              child: TextComponent('Cod. Fabrica'),
            ),
            Expanded(
              child: TextComponent('Descrição'),
            ),
            Expanded(
              child: Text(
                'Opções',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                // textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Divider(),
        _pecasController.carregado
            ? Column(
                children: [
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: _pecasController.listaPecas.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Padding(padding: EdgeInsets.only(left: 10)),
                              // CheckboxComponent(),
                              Expanded(
                                child: Text(
                                  _pecasController.listaPecas[index].id_peca.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  // textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(_pecasController.listaPecas[index].id_peca.toString()),
                              ),
                              Expanded(
                                child: Text(_pecasController.listaPecas[index].codigo_fabrica == null
                                    ? ''
                                    : _pecasController.listaPecas[index].codigo_fabrica.toString()),
                              ),
                              Expanded(
                                child: Text(_pecasController.listaPecas[index].descricao.toString()),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.visibility),
                                      color: Colors.grey.shade400,
                                      onPressed: () {
                                        PopUpEditar.popUpPeca(
                                                context,
                                                PecasEditAndView(
                                                    pecasEditPopup: _pecasController.listaPecas[index], enabled: false))
                                            .then((value) => setState(() {}));
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey.shade400,
                                      ),
                                      onPressed: () {
                                        PopUpEditar.popUpPeca(
                                                context,
                                                PecasEditAndView(
                                                    pecasEditPopup: _pecasController.listaPecas[index], enabled: true))
                                            .then((value) => setState(() {
                                                  buscarTodasPecas();
                                                }));
                                      },
                                    ),
                                    // IconButton(
                                    //   icon: Icon(
                                    //     Icons.delete,
                                    //     color: Colors.grey.shade400,
                                    //   ),
                                    //   onPressed: () {
                                    //     // _pecasController.excluir(snapshot.data![index]).then((value) => setState(() {}));
                                    //     setState(() {
                                    //       excluir(snapshot.data![index]);
                                    //     });
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 50, //media.height * 0.10,
                    // width: media.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextComponent('Total de páginas: ' + _pecasController.pecasPagina.paginaTotal.toString()),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.first_page),
                                onPressed: () {
                                  _pecasController.pecasPagina.paginaAtual = 1;
                                  buscarTodasPecas();
                                }),
                            IconButton(
                                icon: const Icon(
                                  Icons.navigate_before_rounded,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  if (_pecasController.pecasPagina.paginaAtual! > 0) {
                                    _pecasController.pecasPagina.paginaAtual = _pecasController.pecasPagina.paginaAtual! - 1;
                                    buscarTodasPecas();
                                  }
                                }),
                            TextComponent(_pecasController.pecasPagina.paginaAtual.toString()),
                            IconButton(
                                icon: Icon(Icons.navigate_next_rounded),
                                onPressed: () {
                                  if (_pecasController.pecasPagina.paginaAtual != _pecasController.pecasPagina.paginaTotal) {
                                    _pecasController.pecasPagina.paginaAtual = _pecasController.pecasPagina.paginaAtual! + 1;
                                  }

                                  buscarTodasPecas();
                                }),
                            IconButton(
                                icon: Icon(Icons.last_page),
                                onPressed: () {
                                  _pecasController.pecasPagina.paginaAtual = _pecasController.pecasPagina.paginaTotal;
                                  buscarTodasPecas();
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(),
        // FutureBuilder(
        //   future: _pecasController.buscarTodos(),
        //   builder: (context, AsyncSnapshot<List<PecasModel>> snapshot) {
        //     // List<PecasModel> _pecas = snapshot.data ?? [];

        //     switch (snapshot.connectionState) {
        //       case ConnectionState.none:
        //         return Text('none');
        //       case ConnectionState.waiting:
        //         return Center(child: CircularProgressIndicator());
        //       case ConnectionState.active:
        //         return Text('');
        //       case ConnectionState.done:
        //         if (snapshot.hasError) {
        //           return Text(
        //             '${snapshot.error}',
        //             style: TextStyle(color: Colors.red),
        //           );
        //         } else {
        //           return Column(
        //             children: [
        //               Container(
        //                 height: 400,
        //                 child: ListView.builder(
        //                   itemCount: snapshot.data?.length,
        //                   itemBuilder: (context, index) {
        //                     return Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                         children: [
        //                           // Padding(padding: EdgeInsets.only(left: 10)),
        //                           // CheckboxComponent(),
        //                           Expanded(
        //                             child: Text(
        //                               snapshot.data![index].id_peca.toString(),
        //                               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        //                               // textAlign: TextAlign.start,
        //                             ),
        //                           ),
        //                           Expanded(
        //                             child: Text(snapshot.data![index].numero.toString()),
        //                           ),
        //                           Expanded(
        //                             child: Text(snapshot.data![index].codigo_fabrica == null
        //                                 ? ''
        //                                 : snapshot.data![index].codigo_fabrica.toString()),
        //                           ),
        //                           Expanded(
        //                             child: Text(snapshot.data![index].descricao.toString()),
        //                           ),

        //                           Expanded(
        //                             child: Row(
        //                               children: [
        //                                 IconButton(
        //                                   icon: Icon(Icons.visibility),
        //                                   color: Colors.grey.shade400,
        //                                   onPressed: () {
        //                                     PopUpEditar.popUpPeca(context,
        //                                             PecasEditAndView(pecasEditPopup: snapshot.data![index], enabled: false))
        //                                         .then((value) => setState(() {}));
        //                                   },
        //                                 ),
        //                                 IconButton(
        //                                   icon: Icon(
        //                                     Icons.edit,
        //                                     color: Colors.grey.shade400,
        //                                   ),
        //                                   onPressed: () {
        //                                     PopUpEditar.popUpPeca(context,
        //                                             PecasEditAndView(pecasEditPopup: snapshot.data![index], enabled: true))
        //                                         .then((value) => setState(() {}));
        //                                   },
        //                                 ),
        //                                 // IconButton(
        //                                 //   icon: Icon(
        //                                 //     Icons.delete,
        //                                 //     color: Colors.grey.shade400,
        //                                 //   ),
        //                                 //   onPressed: () {
        //                                 //     // _pecasController.excluir(snapshot.data![index]).then((value) => setState(() {}));
        //                                 //     setState(() {
        //                                 //       excluir(snapshot.data![index]);
        //                                 //     });
        //                                 //   },
        //                                 // ),
        //                               ],
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     );
        //                   },
        //                 ),
        //               ),
        //               Container(
        //                 height: 50, //media.height * 0.10,
        //                 // width: media.width,
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     TextComponent('Total de páginas: ' + '100'),
        //                     Row(
        //                       children: [
        //                         IconButton(
        //                             icon: Icon(Icons.first_page),
        //                             onPressed: () {
        //                               // pedidoController.pagina.atual = 1;
        //                               // buscarTodas();
        //                             }),
        //                         IconButton(
        //                             icon: const Icon(
        //                               Icons.navigate_before_rounded,
        //                               color: Colors.black,
        //                             ),
        //                             onPressed: () {
        //                               // if (pedidoController.pagina.atual > 0) {
        //                               //   pedidoController.pagina.atual = pedidoController.pagina.atual - 1;
        //                               //   buscarTodas();
        //                               // }
        //                             }),
        //                         TextComponent('1'),
        //                         IconButton(
        //                             icon: Icon(Icons.navigate_next_rounded),
        //                             onPressed: () {
        //                               // if (pedidoController.pagina.atual != pedidoController.pagina.total) {
        //                               //   pedidoController.pagina.atual = pedidoController.pagina.atual + 1;
        //                               // }

        //                               // buscarTodas();
        //                             }),
        //                         IconButton(
        //                             icon: Icon(Icons.last_page),
        //                             onPressed: () {
        //                               // pedidoController.pagina.atual = pedidoController.pagina.total;
        //                               // buscarTodas();
        //                             }),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           );
        //         }
        //     }
        //   },
        // ),
      ],
    );
  }
}
