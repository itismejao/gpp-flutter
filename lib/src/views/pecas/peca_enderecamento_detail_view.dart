import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/titleComponent.dart';
import 'package:gpp/src/shared/components/inputComponent.dart';
import 'package:gpp/src/shared/components/buttonComponent.dart';

class PecaEnderecamentoDetailView extends StatefulWidget {
  const PecaEnderecamentoDetailView({Key? key}) : super(key: key);

  @override
  _PecaEnderecamentoDetailViewState createState() =>
      _PecaEnderecamentoDetailViewState();
}

class _PecaEnderecamentoDetailViewState
    extends State<PecaEnderecamentoDetailView> {
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
            TitleComponent('Endereçar Peças'),
          ],
        ),
      ),
      Divider(),
      Padding(padding: EdgeInsets.only(bottom: 30)),
      Column(children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtIdProduto,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Filial',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        //await buscaProduto(txtIdProduto.text);

                        //txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                        //txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                        // txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            // Fim Produto
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtNomeProduto,
                  enabled: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nome Filial',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtIdFornecedor,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                      hintText: 'ID',
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          //await buscaProduto(txtIdProduto.text);

                          //txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                          //txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                          // txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                        },
                        icon: Icon(Icons.search),
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtNomeFornecedor,
                  enabled: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nome Fornecedor',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            // Fim Fornecedor
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtIdProduto,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'ID',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        //await buscaProduto(txtIdProduto.text);

                        //txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                        //txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                        // txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            // Fim Produto
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtNomeProduto,
                  enabled: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nome Produto',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 30)),
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtIdFornecedor,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                      hintText: 'ID',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.only(top: 15, bottom: 10, left: 10),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          //await buscaProduto(txtIdProduto.text);

                          //txtNomeProduto.text = _produtoController.produtoModel.resumida.toString();
                          //txtIdFornecedor.text = _produtoController.produtoModel.id_fornecedor.toString();
                          // txtNomeFornecedor.text = _produtoController.produtoModel.fornecedor![0].cliente!.nome.toString();
                        },
                        icon: Icon(Icons.search),
                      )),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  //controller: txtNomeFornecedor,
                  enabled: false,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Nome Peça',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(top: 15, bottom: 10, left: 10),
                  ),
                ),
              ),
            ),
            // Fim Fornecedor
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        Row(
          children: [
            Flexible(
              flex: 1,
               child: InputComponent(
                  label: 'Piso',
                    ),
                ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: InputComponent(
                  label: 'Corredor',
                ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: InputComponent(
                  label: 'Estante',
                ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
              child: InputComponent(
                  label: 'Prateleira',
                ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
            Flexible(
              flex: 1,
                child: InputComponent(
                  label: 'Box',
                ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        ButtonComponent(
            onPressed: (){

            },
            text: 'Pesquisar'
        )
      ])
    ]);
  }
}
