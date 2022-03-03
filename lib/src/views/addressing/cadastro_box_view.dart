import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/addressing_floor_controller.dart';
import 'package:gpp/src/controllers/enderecamento_box_controller.dart';
import 'package:gpp/src/controllers/enderecamento_controller.dart';
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';
import 'package:gpp/src/controllers/notify_controller.dart';
import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/status_component.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/repositories/corredor_enderecamento_repository.dart';

import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/addressing/cadastro_corredor_view.dart';
import 'package:gpp/src/views/addressing/und_medida_box.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/home/home_view.dart';

class CadastroBoxView extends StatefulWidget {
  String? idPrateleira;
  CadastroBoxView({this.idPrateleira});

  // int id;

  //CadastroCorredorView({ Key? key, required this.id } ) : super(key: key);

  //const CadastroBoxView({Key? key}) : super(key: key);

  @override
  _CadastroBoxViewState createState() => _CadastroBoxViewState();
}

class _CadastroBoxViewState extends State<CadastroBoxView> {
  //late EnderecamentoPrateleiraController controller;
  String? idEstante;

  late EnderecamentoController enderecamentoController;

  UnidadeMedidaBox? _selectedUnidadeMedidaBox = UnidadeMedidaBox.Centimetros;

  fetchAll(String idPrateleira) async {
    //Carrega lista de motivos de defeito de peças
    enderecamentoController.listaBox = await enderecamentoController.buscarBox(idPrateleira);

    enderecamentoController.isLoaded = true;

    //Notifica a tela para atualizar os dados
    setState(() {
      enderecamentoController.isLoaded = true;
    });
  }

  handleCreate(context, BoxEnderecamentoModel boxEnderecamentoModel, String idPrateleira) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.criarBox(boxEnderecamentoModel, idPrateleira)) {
        Navigator.pop(context);
        fetchAll(widget.idPrateleira.toString());
        notify.sucess('Box adicionado com sucesso!');
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleDelete(context, BoxEnderecamentoModel boxEnderecamentoModel) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await notify.alert("você deseja excluir o Box?")) {
        if (await enderecamentoController.excluirBox(boxEnderecamentoModel)) {
          // Navigator.pop(context); //volta para tela anterior

          fetchAll(widget.idPrateleira.toString());
          notify.sucess("Box excluído!");
          //Atualiza a lista de motivos
        }
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  handleEdit(context, BoxEnderecamentoModel editaBox) async {
    NotifyController notify = NotifyController(context: context);
    try {
      if (await enderecamentoController.editar()) {
        notify.sucess("Box editada com sucesso!");
      }
    } catch (e) {
      notify.error(e.toString());
    }
  }

  openForm(context, BoxEnderecamentoModel boxEnderecamentoModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro de Box"),
              insetPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: InputComponent(
                              label: 'Box',
                              initialValue: boxEnderecamentoModel.desc_box,
                              hintText: 'Digite o nome do Box',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.desc_box = value;
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            flex: 2,
                            child: InputComponent(
                              label: 'Prateleira',
                              initialValue: boxEnderecamentoModel.id_prateleira.toString(),
                              hintText: 'Digite a Prateleira',
                              enable: false,
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.id_prateleira.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: [
                          Flexible(
                            child: InputComponent(
                              label: 'Altura',
                              hintText: 'Digite a altura',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.altura = double.parse(value);
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            child: InputComponent(
                              label: 'Largura',
                              hintText: 'Digite a largura',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.largura = double.parse(value);
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            child: InputComponent(
                              label: 'Profundidade',
                              hintText: 'Digite a profundidade',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.profundidade = double.parse(value);
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextComponent('Und. Medida'),
                              Padding(padding: EdgeInsets.only(top: 6)),
                              Container(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<UnidadeMedidaBox>(
                                    value: UnidadeMedidaBox.values[_selectedUnidadeMedidaBox!.index],
                                    onChanged: (UnidadeMedidaBox? value) {
                                      setState(() {
                                        _selectedUnidadeMedidaBox = value;

                                        boxEnderecamentoModel.unidade_medida = value!.index;
                                      });
                                    },
                                    items: UnidadeMedidaBox.values.map((UnidadeMedidaBox? unidadeMedidaBox) {
                                      return DropdownMenuItem<UnidadeMedidaBox>(
                                          value: unidadeMedidaBox, child: Text(unidadeMedidaBox!.name));
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                                  if (boxEnderecamentoModel.unidade_medida == null) {
                                    boxEnderecamentoModel.unidade_medida = _selectedUnidadeMedidaBox!.index;
                                  }
                                  handleCreate(context, enderecamentoController.boxModel, widget.idPrateleira.toString());
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

 openFormEdit(context, BoxEnderecamentoModel boxEnderecamentoModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cadastro de Box"),
              insetPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 6,
                            child: InputComponent(
                              label: 'Box',
                              initialValue: boxEnderecamentoModel.desc_box,
                              hintText: 'Digite o nome do Box',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.desc_box.toString();
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            flex: 2,
                            child: InputComponent(
                              label: 'Prateleira',
                              initialValue: boxEnderecamentoModel.id_prateleira.toString(),
                              hintText: 'Digite a Prateleira',
                              enable: false,
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.id_prateleira.toString();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        children: [
                          Flexible(
                            child: InputComponent(
                              label: 'Altura',
                              hintText: 'Digite a altura',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.altura.toString();
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            child: InputComponent(
                              label: 'Largura',
                              hintText: 'Digite a largura',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.largura.toString();
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Flexible(
                            child: InputComponent(
                              label: 'Profundidade',
                              hintText: 'Digite a profundidade',
                              onChanged: (value) {
                                setState(() {
                                  boxEnderecamentoModel.profundidade.toString();
                                });
                              },
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextComponent('Und. Medida'),
                              Padding(padding: EdgeInsets.only(top: 6)),
                              Container(
                                padding: EdgeInsets.only(left: 12, right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<UnidadeMedidaBox>(
                                    value: UnidadeMedidaBox.values[_selectedUnidadeMedidaBox!.index],
                                    onChanged: (UnidadeMedidaBox? value) {
                                      setState(() {
                                        _selectedUnidadeMedidaBox = value;

                                        boxEnderecamentoModel.unidade_medida = value!.index;
                                      });
                                    },
                                    items: UnidadeMedidaBox.values.map((UnidadeMedidaBox? unidadeMedidaBox) {
                                      return DropdownMenuItem<UnidadeMedidaBox>(
                                          value: unidadeMedidaBox, child: Text(unidadeMedidaBox!.name));
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
                                   handleEdit(context, boxEnderecamentoModel);
                                },
                                text: 'Alterar')
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
    fetchAll(widget.idPrateleira.toString());
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
                  Flexible(child: TitleComponent('Box')),
                  ButtonComponent(
                      onPressed: () {
                        enderecamentoController.boxModel.id_prateleira = int.parse(widget.idPrateleira.toString());
                        openForm(context, enderecamentoController.boxModel);
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
                Expanded(child: TextComponent('Altura')),
                Expanded(child: TextComponent('Largura')),
                Expanded(child: TextComponent('Profundidade')),
                Expanded(child: TextComponent('Und. Medida')),
                Expanded(child: TextComponent('Opções')),
              ],
            ),
            Divider(),
            enderecamentoController.isLoaded
                ? Container(
                    height: media.size.height * 0.5,
                    child: ListView.builder(
                      itemCount: enderecamentoController.listaBox.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].id_box.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].desc_box.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].altura == null
                                      ? ''
                                      : enderecamentoController.listaBox[index].altura.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].largura == null
                                      ? ''
                                      : enderecamentoController.listaBox[index].largura.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].profundidade == null
                                      ? ''
                                      : enderecamentoController.listaBox[index].profundidade.toString()),
                                ),
                                Expanded(
                                  child: TextComponent(enderecamentoController.listaBox[index].unidade_medida == null
                                      ? ''
                                      : enderecamentoController.listaBox[index].unidade_medida == 0
                                          ? UnidadeMedidaBox.Milimetros.name
                                          : enderecamentoController.listaBox[index].unidade_medida == 1
                                              ? UnidadeMedidaBox.Centimetros.name
                                              : enderecamentoController.listaBox[index].unidade_medida == 2
                                                  ? UnidadeMedidaBox.Metros.name
                                                  : enderecamentoController.listaBox[index].unidade_medida == 3
                                                      ? UnidadeMedidaBox.Polegadas.name
                                                      : ''),
                                ),
                                   IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {                                            
                                          openFormEdit(context,  enderecamentoController.listaBox[index]);
                                         },
                                      ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.grey.shade400,
                                          ),
                                          onPressed: () {
                                            handleDelete(context, enderecamentoController.listaBox[index]);
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
