import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_especie_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';
import 'package:gpp/src/models/pecas_model/pecas_especie_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';
import 'package:gpp/src/repositories/pecas_repository/pecas_linha_repository.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EspecieDetailView extends StatefulWidget {
  PecasLinhaModel? pecasLinhaModel;
  PecasEspecieModel? pecasEspecieModel;

  EspecieDetailView({this.pecasLinhaModel, this.pecasEspecieModel});

  @override
  _EspecieDetailViewState createState() => _EspecieDetailViewState();
}

class _EspecieDetailViewState extends State<EspecieDetailView> {
  PecasLinhaController _pecasLinhaController = PecasLinhaController();
  PecasEspecieController _pecasEspecieController = PecasEspecieController();

  PecasLinhaModel? selectedLinha;
  List<PecasLinhaModel> _pecasLinha = [];

  PecasLinhaModel? pecasLinhaModel;
  PecasEspecieModel? pecasEspecieModel;

  @override
  void initState() {
    pecasLinhaModel = widget.pecasLinhaModel;
    pecasEspecieModel = widget.pecasEspecieModel;

    if (pecasLinhaModel != null) {
      _pecasLinhaController.pecasLinhaModel = pecasLinhaModel!;
    }

    if (pecasEspecieModel != null) {
      _pecasEspecieController.pecasEspecieModel = pecasEspecieModel!;
    }

    super.initState();
  }

  DropdownMenuItem<String> buildMenuItem(PecasLinhaModel pecasLinhaModel) => DropdownMenuItem(
        value: pecasLinhaModel.linha,
        child: Text(
          pecasLinhaModel.linha.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16),
        child: Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20)),
            Icon(Icons.add_box),
            Padding(padding: EdgeInsets.only(right: 12)),
            TitleComponent('Cadastrar Linha e Espécie'),
          ],
        ),
      ),
      Divider(),
      Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.only(bottom: 30)),
              Flexible(
                child: InputComponent(
                  label: 'Nome da Linha',
                  onChanged: (value) {
                    _pecasLinhaController.pecasLinhaModel.linha = value;
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonComponent(
                onPressed: () {
                  _pecasLinhaController.create();
                },
                text: 'Salvar',
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            children: [
              Text(
                'Cadastrar Espécie',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
          Divider(),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent('Selecione a linha'),
                  Padding(padding: EdgeInsets.only(bottom: 6)),
                  FutureBuilder(
                    future: _pecasLinhaController.buscarTodos(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else {
                        final List<PecasLinhaModel> _pecasLinha = snapshot.data;

                        return Container(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<PecasLinhaModel>(
                              hint: Text('Selecione'),
                              value: selectedLinha?.id_peca_linha == null
                                  ? selectedLinha
                                  : _pecasLinha.firstWhere((element) => element.id_peca_linha == selectedLinha!.id_peca_linha,
                                      orElse: () => _pecasLinha[0]),
                              items: _pecasLinha
                                  .map((dadosLinha) => DropdownMenuItem<PecasLinhaModel>(
                                        value: dadosLinha,
                                        child: Text(dadosLinha.linha!.toString().toUpperCase()),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedLinha = value!;
                                });
                                _pecasEspecieController.pecasEspecieModel.id_peca_linha = value!.id_peca_linha;
                              },
                              icon: Icon(
                                Icons.arrow_drop_down_rounded,
                                color: Colors.black,
                              ),
                              iconSize: 36,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(right: 30)),
              Flexible(
                child: InputComponent(
                  label: 'Nome da Espécie',
                  onChanged: (value) {
                    _pecasEspecieController.pecasEspecieModel.especie = value;
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonComponent(
                onPressed: () {
                  if (selectedLinha?.id_peca_linha == null) {
                    print('Selecione a linha');
                  } else {
                    _pecasEspecieController.create();
                  }
                },
                text: 'Salvar',
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
