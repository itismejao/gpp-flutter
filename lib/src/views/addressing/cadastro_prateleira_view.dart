import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_prateleira_cotroller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/views/addressing/cadastro_box_view.dart';
import 'package:gpp/src/views/home/home_view.dart';

import '../funcionalities_view.dart';

class CadastroPrateleiraView extends StatefulWidget {
  String? idEstante;
  CadastroPrateleiraView({this.idEstante});

  // int id;

  //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);
  //const CadastroPrateleiraView({Key? key}) : super(key: key);

  @override
  _CadastroPrateleiraViewState createState() => _CadastroPrateleiraViewState();
}

class _CadastroPrateleiraViewState extends State<CadastroPrateleiraView> {
  //late EnderecamentoPrateleiraController controller;
  String? idEstante;

  late EnderecamentoController enderecamentoController;

  fetchAll(idEstante) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaPrateleira = await enderecamentoController.repository.buscarPrateleira(idEstante);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoModel, String idEstante) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.criarPrateleira(prateleiraEnderecamentoModel, idEstante)) {
        Navigator.pop(context);
        fetchAll(widget.idEstante.toString());
        notify.sucess('Prateleira adicionada com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir a prateleira?")) {
        if (await enderecamentoController.excluirPrateleira(prateleiraEnderecamentoModel)) {
          // Navigator.pop(context); //volta para tela anterior

          fetchAll(widget.idEstante.toString());
          notify.sucess("Prateleira excluída!");
          //Atualiza a lista de motivos
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleEdit(context, PrateleiraEnderecamentoModel editaEstante) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.editar()) {
        notify.sucess("Prateleira editada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  openForm(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: prateleiraEnderecamentoReplacement.id_prateleira == null
                  ? Text("Cadastro da Prateleira")
                  : Text("Atualizar motivo de troca de peça"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Prateleira',
                        initialValue: prateleiraEnderecamentoReplacement.desc_prateleira,
                        hintText: 'Digite o nome da Prateleira',
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.desc_prateleira = value!;
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Estante',
                        initialValue: prateleiraEnderecamentoReplacement.id_prateleira.toString(),
                        hintText: 'Digite a Estante',
                        enable: false,
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.id_prateleira.toString();
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
                                  handleCreate(context, enderecamentoController.prateleiraModel, widget.idEstante.toString());
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

   openFormEdit(context, PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement) {
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
                        initialValue: prateleiraEnderecamentoReplacement.desc_prateleira,
                        hintText: 'Digite o nome do Piso',
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.desc_prateleira.toString();
                          });
                        },
                      ),
                      InputComponent(
                        label: 'Filial',
                        initialValue: prateleiraEnderecamentoReplacement.id_prateleira.toString(),
                        hintText: 'Digite a estante',
                        onChanged: (value) {
                          setState(() {
                            prateleiraEnderecamentoReplacement.id_prateleira.toString();
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
                                   handleEdit(context, prateleiraEnderecamentoReplacement);
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
    // controller = EnderecamentoPrateleiraController();
    enderecamentoController = EnderecamentoController();
    //Quando o widget for inserido na árvore chama o fetchAll
    fetchAll(widget.idEstante.toString());
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
                  Flexible(child: TitleComponent('Prateleira')),
                  ButtonComponent(
                      onPressed: () {
                        enderecamentoController.prateleiraModel.id_estante = int.parse(widget.idEstante.toString());
                        openForm(context, enderecamentoController.prateleiraModel);
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
                      itemCount: enderecamentoController.listaPrateleira.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaPrateleira[index].id_prateleira.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaPrateleira[index].desc_prateleira.toString()),
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
                                                    page: CadastroBoxView(
                                                      idPrateleira:
                                                          enderecamentoController.listaPrateleira[index].id_prateleira.toString(),
                                                    ),
                                                  ),
                                                ));
                                          },
                                          text: 'Box'),
                                       IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {                                            
                                          openFormEdit(context,  enderecamentoController.listaPrateleira[index]);
                                         },
                                      ),
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            handleDelete(context, enderecamentoController.listaPrateleira[index]);
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
