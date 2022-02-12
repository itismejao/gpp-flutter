import 'dart:html';
import 'package:gpp/src/controllers/piso_enderecamento_controller.dart';
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
   late PisoEnderecamentoController _controllerPiso;

   
    int selected = 1;
//     late FocusNode myFocusNode;

// @override
// void initState(){
//   super.initState();

//    myFocusNode = FocusNode();
// }    

// @override
//   void dispose() {
    
//     myFocusNode.dispose();
//     super.dispose();
//   }
 
 @override
   Widget build(BuildContext context) {
    return Row(
      children: [
      //  Expanded(
        //  child: _enderecoMenu(),
      //  ),
        Expanded(
       //   flex: 4,
         
          child: Column(
            children: [
              _buildEnderecamentoList(MediaQuery.of(context)),
            ],
          ),
        ),
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
                    width: 6,
                  ),
                  TitleComponent('Pisos'),
                ],
              ),
              ButtonComponent(
                  color: secundaryColor,
                  onPressed: () {
                    _cadastroPisoDialogParts(context);
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
                child: const TextComponent('Nome'),
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
                        child: TextComponent('Porta A'),                        
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red.shade400,
                                ),
                               onPressed: () {
                                _deletePisoDialogParts(context);
                              },
                            )
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

   _cadastroPisoDialogParts(context) {
    MediaQueryData media = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
           return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Cadastro de Piso'),
                ],
              ),
              content: Container(
                width: media.size.width * 0.30,
                height: media.size.height * 0.50,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //    child: Row(
                    //     children: [
                    //       Text(
                    //         'Filial:',
                    //           style: TextStyle(
                    //           letterSpacing: 0.15,
                    //           fontSize: 20,
                    //           ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Piso:',
                    //           style: TextStyle(
                    //           letterSpacing: 0.15,
                    //           fontSize: 20,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Divider(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: InputComponent(
                      label: 'Filial',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: InputComponent(
                      label: 'Nº Asteca',
                      initialValue: '38135',
                    ),
                  ),
                  
                   Padding(padding: EdgeInsets.only(bottom: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           ButtonComponent(
                            color: Colors.grey,
                            onPressed: () {
                            },
                            text: 'Sair'),

                           Padding (padding:EdgeInsets.only(left: 20)),
                             ButtonComponent(
                            color: secundaryColor,
                            onPressed: () {
                            },
                            text: 'Adicionar')
                        ],
                      ),
                  ],
                ),
              ),
            );
        });
      });
    }

    _deletePisoDialogParts(context) {
    MediaQueryData media = MediaQuery.of(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
           return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Piso'),
                ],
              ),
              content: Container(
                width: media.size.width * 0.30,
                height: media.size.height * 0.20,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Text(
                            'Deseja excluir o Piso',
                            style: TextStyle(
                              letterSpacing: 0.15,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 40)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           ButtonComponent(
                            color: Colors.grey,
                            onPressed: () {
                            },
                            text: 'Sair'),

                           Padding (padding:EdgeInsets.only(left: 20)),
                             ButtonComponent(
                            color: Colors.red,
                            onPressed: () {
                            },
                            text: 'Excluir')
                        ],
                      ),
                  ],
                ),
              ),
             );
          });
        });
      }


      
   }
  
 