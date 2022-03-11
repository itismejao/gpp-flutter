import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/views/addressing/cadastro_prateleira_view.dart';
import 'package:gpp/src/views/home/home_view.dart';

import '../funcionalities_view.dart';

// ignore: must_be_immutable
// ignore: must_be_immutable
class CadastroEstanteView extends StatefulWidget {
  String? idCorredor;
  CadastroEstanteView({this.idCorredor});

  // int id;

  //CadastroEstanteView({ Key? key, required this.id } ) : super(key: key);

  //const CadastroEstanteView({Key? key}) : super(key: key);

  @override
  _CadastroEstanteViewState createState() => _CadastroEstanteViewState();
}

class _CadastroEstanteViewState extends State<CadastroEstanteView> {
  //late EnderecamentoEstanteController controller;
  String? idCorredor;

  late EnderecamentoController enderecamentoController;

  fetchAll(String idCorredor) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaEstante = await enderecamentoController.repository.buscarEstante(idCorredor);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(context, EstanteEnderecamentoModel estanteEnderecamentoModel, String idCorredor) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.criarEstante(estanteEnderecamentoModel, idCorredor)) {
        Navigator.pop(context);
        fetchAll(widget.idCorredor.toString());
        notify.sucess('Estante adicionada com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, EstanteEnderecamentoModel estanteEnderecamentoModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir a estante?")) {
        if (await enderecamentoController.excluirEstante(estanteEnderecamentoModel)) {
          // Navigator.pop(context); //volta para tela anterior

          fetchAll(widget.idCorredor.toString());
          notify.sucess("Estante excluída!");
          //Atualiza a lista de motivos
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleEdit(context, EstanteEnderecamentoModel editaEstante) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.editar()) {
        notify.sucess("Estante editada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  openForm(context, EstanteEnderecamentoModel estanteEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro da Estante"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Estante',
                        initialValue: estanteEnderecamentoReplacement.desc_estante,
                        hintText: 'Digite o nome da Estante',
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.desc_estante = value!;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Corredor',
                        initialValue: estanteEnderecamentoReplacement.id_corredor.toString(),
                        hintText: 'Digite a prateleira',
                        enable: false,
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.id_corredor.toString();
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
                                  handleCreate(context, enderecamentoController.estanteModel, widget.idCorredor.toString());
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

  openFormEdit(context, EstanteEnderecamentoModel estanteEnderecamentoReplacement) {
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
                        initialValue: estanteEnderecamentoReplacement.desc_estante,
                        hintText: 'Digite o nome do Piso',
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.desc_estante.toString();
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: estanteEnderecamentoReplacement.id_estante.toString(),
                        hintText: 'Digite a estante',
                        onChanged: (value) {
                          setState(() {
                            estanteEnderecamentoReplacement.id_estante.toString();
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
                                  handleEdit(context, estanteEnderecamentoReplacement);
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
    // controller = EnderecamentoEstanteController();
    enderecamentoController = EnderecamentoController();
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll(widget.idCorredor.toString());
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
                  Flexible(child: TitleComponent('Estante')),
                  ButtonComponent(
                      onPressed: () {
                        enderecamentoController.estanteModel.id_corredor = int.parse(widget.idCorredor.toString());
                        openForm(context, enderecamentoController.estanteModel);
                      },
                      text: 'Adicionar')
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Expanded(child: TextComponent('Id')),
                Expanded(child: TextComponent('Nome')),
                Expanded(child: TextComponent('Opções')),
              ],
            ),
            Divider(),
            enderecamentoController.isLoaded
                ? Container(
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: enderecamentoController.listaEstante.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaEstante[index].id_estante.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaEstante[index].desc_estante.toString()),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      ButtonComponent(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => HomeView(
                                                    funcionalities: FuncionalitiesView(),
                                                    page: CadastroPrateleiraView(
                                                      idEstante:
                                                          enderecamentoController.listaEstante[index].id_estante.toString(),
                                                    ),
                                                  ),
                                                ));
                                          },
                                          text: 'Prateleira'),
                                      // IconButton(
                                      //   icon: Icon(
                                      //     Icons.edit,
                                      //     color: Colors.grey.shade400,
                                      //   ),
                                      //   onPressed: () {
                                      //     openFormEdit(
                                      //         context,
                                      //         enderecamentoController
                                      //             .listaEstante[index]);
                                      //   },
                                      // ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            handleDelete(context, enderecamentoController.listaEstante[index]);
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
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
