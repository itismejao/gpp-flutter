import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/shared/utils/CurrencyPtBrInputFormatter.dart';


import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/components/TitleComponent.dart';
import '../../shared/repositories/styles.dart';


class EntradaPedidoView extends StatefulWidget {
  const EntradaPedidoView({Key? key}) : super(key: key);

  @override
  _EntradaPedidoViewState createState() => _EntradaPedidoViewState();
}

class _EntradaPedidoViewState extends State<EntradaPedidoView> {
  GlobalKey<FormState> filtroFormKey = GlobalKey<FormState>();
  List<String> pedidos = [];

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16, bottom: 16),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Icon(Icons.input),
              const Padding(padding: EdgeInsets.only(right: 12)),
              const TitleComponent('Entrada via Pedido'),
            ],
          ),
        ),
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 5)),
            Flexible(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nota Fiscal',
                    labelText: 'Nota Fiscal',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Série',
                    labelText: 'Série',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 5)),
          ],
        ),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 10)),
        Row(
          children: [
            const Padding(padding: EdgeInsets.only(left: 5)),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Form(
                  key: filtroFormKey,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      setState(() {
                        pedidos.add(value);
                      });

                      filtroFormKey.currentState!.reset();
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Pedido',
                        labelText: 'Digite o número do pedido',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () {

                            filtroFormKey.currentState!.reset();
                          },
                          icon: Icon(Icons.search),
                        ),),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 5)),
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  enabled: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Fornecedor',
                    labelText: 'Fornecedor',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 5)),
          ],
        ),
        const Padding(padding: EdgeInsets.only(top: 5)),
        pedidos.isEmpty ? Container () :
          Container(
            height: 50,
            width: media.width,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: pedidos.length,
                itemBuilder: (context,index){
                  return Container(
                    width: 100,
                    child: Card(
                        color: secundaryColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                  'Pedido\n'+pedidos[index],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                          ],
                        ),
                    ),
                  );
          },
          ),
          ),
        const Padding(padding: EdgeInsets.only(top: 25)),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                const Icon(
                  Icons.handyman,
                  size: 32,
                ),
                const SizedBox(
                  width: 12,
                ),
                const TitleComponent('Peças'),
                new Spacer(),
                ButtonComponent(
                    onPressed: (){

                    },
                    text: 'Adicionar Peça'),
            
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const TextComponent(
                    'Cod. Peça',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: const TextComponent('Descrição Peça'),
                ),
                Expanded(
                  child: const TextComponent(
                    'Qtd. Pedida',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: const TextComponent(
                    'Qtd. Recebida',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: const TextComponent(
                    'Valor Unitário',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: const TextComponent(
                    'Ações',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            height: 450,
            child: ListView.builder(
            primary: false,
            itemCount: 10,
            itemBuilder: (context,index){
              return Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: const TextComponent(
                          'Cod. Peça',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: const TextComponent('Descrição Peça'),
                      ),
                      Expanded(
                        child: const TextComponent(
                          'Qtd. Pedida',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Qtd',
                              border: InputBorder.none,
                              contentPadding:
                              EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                            ),
                          ),

                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 5)),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly,
                              CurrencyPtBrInputFormatter()],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                  hintText: '0,00',
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                                  prefixText: 'R\$ ',
                              ),
                            ),

                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: IconButton(
                                  tooltip: 'Excluir Item',
                                  icon: Icon(Icons.delete_outlined,color: Colors.grey.shade400,),
                                  onPressed: (){

                                  },
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            ),
          )
        ],
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        const Divider(),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(padding: EdgeInsets.only(left: 5)),
            Flexible(
              child: ButtonComponent(onPressed: () {

              }, text: 'Lançar Entrada', color: primaryColor,),
            ),
            const Padding(padding: EdgeInsets.only(right: 5)),
          ],
        ),
      ],
    );
  }
}
