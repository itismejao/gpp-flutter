import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class EstoqueConsultaView extends StatefulWidget {
  const EstoqueConsultaView({Key? key}) : super(key: key);

  @override
  _EstoqueConsultaViewState createState() => _EstoqueConsultaViewState();
}

class _EstoqueConsultaViewState extends State<EstoqueConsultaView> {

  TextEditingController _controllerIdFilial = new TextEditingController();
  TextEditingController _controllerNomeFilial = new TextEditingController();

  TextEditingController _controllerIdFornecedor = new TextEditingController();
  TextEditingController _controllerNomeFornecedor = new TextEditingController();

  TextEditingController _controllerIdProduto = new TextEditingController();
  TextEditingController _controllerNomeProduto = new TextEditingController();

  TextEditingController _controllerIdPeca = new TextEditingController();
  TextEditingController _controllerNomePeca = new TextEditingController();

  TextEditingController _controllerCorredor = new TextEditingController();
  TextEditingController _controllerPrateleira = new TextEditingController();
  TextEditingController _controllerEstante = new TextEditingController();
  TextEditingController _controllerBox = new TextEditingController();

  bool? disponivel;


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
              const Icon(Icons.grid_view_outlined),
              const Padding(padding: EdgeInsets.only(right: 12)),
              const TitleComponent('Consultar Estoque'),
              const Padding(padding: EdgeInsets.only(right: 5)),
            ],
          ),
        ),
        const Divider(),
        const Padding(padding: EdgeInsets.only(bottom: 20)),
        Container(
          child: Column(children: [
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdFilial,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Filial',
                        labelText: 'Filial',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                          },
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeFilial,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Filial',
                        labelText: 'Nome Filial',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdFornecedor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                          hintText: 'ID',
                          labelText: 'ID',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            onPressed: () async {},
                            icon: Icon(Icons.search),
                          )),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeFornecedor,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Fornecedor',
                        labelText: 'Nome Fornecedor',
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                // Fim Fornecedor
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              children: [
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdProduto,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'ID',
                        labelText: 'ID',
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (_controllerIdProduto.text == '') {
                              //limparFieldsPeca();
                            } else {
                              //buscarProduto(_controllerIdProduto.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                // Fim Produto
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomeProduto,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Produto',
                        labelText: 'Nome Produto',
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30)),
                Flexible(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerIdPeca,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                          hintText: 'ID',
                          labelText: 'ID',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_controllerIdPeca.text == '') {
                                //limparFieldsPeca();
                              } else {
                                //buscarPeca(_controllerIdPeca.text);
                              }
                            },
                            icon: const Icon(Icons.search),
                          )),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerNomePeca,
                      enabled: false,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Nome Peça',
                        labelText: 'Nome Peça',
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                // Fim Fornecedor
                const Padding(padding: EdgeInsets.only(right: 5)),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
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
                    child: TextFormField(
                      controller: _controllerCorredor,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerPrateleira,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerEstante,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                Text('-'),
                const Padding(padding: EdgeInsets.only(left: 5)),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      controller: _controllerBox,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 5)),
                new Spacer(),
                Flexible(
                  child: ListTile(
                    title: const Text('Disponível'),
                    leading: Radio(
                      groupValue: disponivel,
                      value: true,
                      onChanged: (value){
                        disponivel = value as bool?;
                      },
                    ),

                ),),
                Flexible(
                  child: ListTile(
                    title: const Text('Reservado'),
                    leading: Radio(
                      groupValue: disponivel,
                      value: false,
                      onChanged: (value){
                        disponivel = value as bool?;
                      },
                    ),

                  ),),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
          ]),
        ),
      ],
    );
  }
}
