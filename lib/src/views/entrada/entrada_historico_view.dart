import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:gpp/src/controllers/entrada/movimento_entrada_controller.dart';
import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/entrada/situacao_entrada.dart';
import 'package:intl/intl.dart';

import '../../shared/components/TitleComponent.dart';

class EntradaHistoricoView extends StatefulWidget {
  const EntradaHistoricoView({Key? key}) : super(key: key);

  @override
  _EntradaHistoricoViewState createState() => _EntradaHistoricoViewState();
}

class _EntradaHistoricoViewState extends State<EntradaHistoricoView> {
  late MovimentoEntradaController movimentoEntradaController;
  String? id_filial = null;

  @override
  void initState() {
    movimentoEntradaController = MovimentoEntradaController();
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
            const Padding(padding: EdgeInsets.only(left: 20)),
            const Icon(Icons.history),
            const Padding(padding: EdgeInsets.only(right: 12)),
            const TitleComponent('Histórico de Entrada'),
          ],
        ),
      ),
      const Divider(),
      const Padding(padding: EdgeInsets.only(bottom: 20)),
      FutureBuilder(
        future: movimentoEntradaController.buscarTodos(id_filial),
        builder: (BuildContext context,
            AsyncSnapshot<List<MovimentoEntradaModel>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Sem conexão!');
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
                  height: media.height,
                  child: ListView.builder(
                      primary: false,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 9,
                                  offset: Offset(0, 5), // changes position of shadow
                                ),
                              ],
                              border: Border(
                                left: BorderSide(
                                  color: snapshot.data![index].situacao == SituacaoEntrada.Cancelado ? Colors.red : secundaryColor,
                                  width: 7.0,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            TextComponent(
                                              'ID',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            TextComponent(
                                              'Data de Entrada',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: TextComponent(
                                            'Funcionário',
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      Expanded(
                                          child: TextComponent(
                                            'Nota Fiscal',
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Expanded(
                                          child: TextComponent(
                                            'Série',
                                            fontWeight: FontWeight.bold,
                                          ),),
                                      Expanded(
                                        child: TextComponent(
                                          'Situação',
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Expanded(
                                          child: TextComponent(
                                            'Custo',
                                            fontWeight: FontWeight.bold,
                                          ),),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextComponent(
                                          '#'+snapshot.data![index].id_movimento_entrada.toString(),
                                        ),),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            TextComponent(
                                              DateFormat('dd/MM/yyyy')
                                                  .format(snapshot.data![index].data_entrada ?? DateTime.now()),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: TextComponent(
                                            snapshot.data![index].id_funcionario.toString(),
                                          ),),
                                      Expanded(
                                          child: TextComponent(
                                            snapshot.data![index].num_nota_fiscal.toString(),
                                          ),),
                                      Expanded(
                                          child: TextComponent(
                                            snapshot.data![index].serie.toString(),
                                          )),
                                      Expanded(
                                          child:
                                          TextComponent(
                                            snapshot.data![index].situacao.toString().split('.').last,
                                          )
                                      ),
                                      Expanded(
                                          child:
                                          TextComponent(
                                            snapshot.data![index].custo_total.toString(),
                                          )
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                );
              }
          }
        },
      ),
    ]);
  }
}
