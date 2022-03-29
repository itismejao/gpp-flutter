import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';

import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/utils/notificacao.dart';
import 'package:gpp/src/views/enderecamento/cadastro_estante_view.dart';
import 'package:gpp/src/views/widgets/button_acao_widget.dart';
import 'package:gpp/src/views/widgets/card_widget.dart';

// ignore: must_be_immutable
class CadastroCorredorView extends StatefulWidget {
  String? idPiso;
  CadastroCorredorView({this.idPiso});

  // int id;

  //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);
  // const CadastroCorredorView({Key? key}) : super(key: key);

  @override
  _CadastroCorredorViewState createState() => _CadastroCorredorViewState();
}

class _CadastroCorredorViewState extends State<CadastroCorredorView> {
  //late EnderecamentoCorredorController controller;
  // String? idPiso;

  late EnderecamentoController enderecamentoController;

  fetchAll(String idPiso) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaCorredor =
        await enderecamentoController.buscarCorredor(idPiso);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(
      context, CorredorEnderecamentoModel corredor, String idPiso) async {
    try {
      if (await enderecamentoController.criarCorredor(corredor, idPiso)) {
        Navigator.pop(context);
        fetchAll(widget.idPiso.toString());
        Notificacao.snackBar('Corredor adicionado com sucesso!');
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  handleDelete(context, CorredorEnderecamentoModel excluiCorredor) async {
    try {
      if (await Notificacao.confirmacao("você deseja excluir o corredor?")) {
        if (await enderecamentoController.repository
            .excluirCorredor(excluiCorredor)) {
          // Navigator.pop(context); //volta para tela anterior

          fetchAll(widget.idPiso.toString());
          Notificacao.snackBar("Corredor excluído!");
          //Atualiza a lista de motivos
        }
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  handleEdit(context, CorredorEnderecamentoModel editaCorredor) async {
    try {
      if (await enderecamentoController.editar()) {
        Notificacao.confirmacao("Corredor editado com sucesso!");
      }
    } catch (e) {
      Notificacao.snackBar(e.toString());
    }
  }

  openForm(
      context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro do Piso"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Corredor',
                        initialValue:
                            corredorEnderecamentoReplacement.desc_corredor,
                        hintText: 'Digite o nome do Corredor',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.desc_corredor =
                                value!;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Piso',
                        initialValue:
                            corredorEnderecamentoReplacement.id_piso.toString(),
                        hintText: 'Digite o piso',
                        enable: false,
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.id_piso.toString();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            ButtonComponent(
                                onPressed: () {
                                  handleCreate(
                                      context,
                                      enderecamentoController.corredorModel,
                                      widget.idPiso.toString());
                                },
                                text: 'Adicionar')
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  openFormEdit(
      context, CorredorEnderecamentoModel corredorEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro do Piso"),
              // pisoEnderecamentoReplacement.id_piso == null

              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Piso',
                        initialValue:
                            corredorEnderecamentoReplacement.desc_corredor,
                        hintText: 'Digite o nome do Piso',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.desc_corredor
                                .toString();
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: corredorEnderecamentoReplacement
                            .id_corredor
                            .toString(),
                        hintText: 'Digite a filial',
                        onChanged: (value) {
                          setState(() {
                            corredorEnderecamentoReplacement.id_corredor
                                .toString();
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            //  pisoEnderecamentoReplacement.id_piso == null
                            ButtonComponent(
                                onPressed: () {
                                  handleEdit(context,
                                      corredorEnderecamentoReplacement);
                                  // handleEdit(context);
                                  // Navigator.pop(context);
                                  // context,
                                  //           enderecamentoController.listaPiso[index],
                                },
                                text: 'Alterar')
                            // :ButtonComponent(
                            //     color: Colors.red,
                            //     onPressed: () {
                            //       handleCreate(context, pisoEnderecamentoReplacement);
                            //     },
                            //     text: 'Cancelar')
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //Iniciliza controlador
    enderecamentoController = EnderecamentoController();
    // corredorEnderecamentoModel = widget.corredorEnderecamentoModel;
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll(widget.idPiso.toString());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: TitleComponent('Corredor')),
                  ButtonComponent(
                      onPressed: () {
                        enderecamentoController.corredorModel.id_piso =
                            int.parse(widget.idPiso.toString());
                        openForm(
                            context, enderecamentoController.corredorModel);
                      },
                      text: 'Adicionar')
                ],
              ),
            ),
            enderecamentoController.isLoaded
                ? Container(
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: enderecamentoController.listaCorredor.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CardWidget(
                              widget: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: TextComponent('Id')),
                                  Expanded(child: TextComponent('Nome')),
                                  Expanded(child: TextComponent('Opções')),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextComponent(enderecamentoController
                                        .listaCorredor[index].id_corredor
                                        .toString()),
                                  ),
                                  Expanded(
                                    child: TextComponent(enderecamentoController
                                        .listaCorredor[index].desc_corredor
                                        .toString()),
                                  ),
                                  Expanded(
                                    child: Row(
                                      //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ButtonComponent(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CadastroEstanteView(
                                                    idCorredor:
                                                        enderecamentoController
                                                            .listaCorredor[
                                                                index]
                                                            .id_corredor
                                                            .toString(),
                                                  ),
                                                ),
                                              );
                                            },
                                            text: 'Estante'),
                                        Expanded(child: ButtonAcaoWidget(
                                          deletar: () {
                                            handleDelete(
                                              context,
                                              enderecamentoController
                                                  .listaCorredor[index],
                                            );
                                          },
                                        )),
                                        // IconButton(
                                        //   icon: Icon(
                                        //     Icons.edit,
                                        //     color: Colors.grey.shade400,
                                        //   ),
                                        //   onPressed: () {
                                        //     openFormEdit(
                                        //         context,
                                        //         enderecamentoController
                                        //             .listaCorredor[index]);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                        );
                      },
                    ),
                  )
                : LoadingComponent()
          ],
        ),
      ),
    );
  }
}
