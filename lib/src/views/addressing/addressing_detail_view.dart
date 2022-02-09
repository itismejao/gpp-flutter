import 'dart:html';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/shared/components/button_component.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/components/text_component.dart';
import 'package:gpp/src/shared/components/title_component.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

import 'package:flutter/material.dart';

class AddressingDetailView extends StatefulWidget {
  const AddressingDetailView({
    Key? key,
  }) : super(key: key);


   @override
  _AddressingDetailViewState createState() => _AddressingDetailViewState();
}

 class _AddressingDetailViewState extends State<AddressingDetailView>  {
    int selected = 1;
 
 @override
   Widget build(BuildContext context) {
    return Row(
      children: [
      //  Expanded(
        //  child: _enderecoMenu(),
      //  ),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              _buildEnderecamentoList(MediaQuery.of(context)),
            ],
          ),
        )
      ],
    );
  }

     
  _buildEnderecamentoList(media) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Peças'),
                ],
              ),
              ButtonComponent(
                  color: secundaryColor,
                  onPressed: () {
      //              _buildDialogEndressing(context);
                  },
                  text: 'Adicionar')
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: 'Buscar',
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            children: [
              Expanded(
                child: const TextComponent('ID'),
              ),
              Expanded(
                child: const TextComponent('Nome'),
              ),
              Expanded(
                flex: 3,
                child: const TextComponent('Motivo'),
              ),
              Expanded(
                child: const TextComponent('Quantidade'),
              ),
              Expanded(
                child: const TextComponent('Ações'),
              ),
            ],
          ),
        ),
        Divider(),
        Container(
          height: media.size.height * 0.60,
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextComponent('0001'),
                      ),
                      Expanded(
                        child: TextComponent('Porta Esquerda'),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DropDownComponent(
                                items: <String>[
                                  'Peça com defeito',
                                  'Cor errada',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                hintText: 'Selecione o motivo',
                              ),
                            ),
                          )),
                      Expanded(
                        child: TextComponent('47'),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  // handleDelete(context, departament[index])
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Total: 7 peças selecionadas',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
 }