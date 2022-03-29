import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/main.dart';
import 'package:gpp/src/controllers/EmailPedidoEntradaController.dart';
import 'package:gpp/src/controllers/pedido_entrada_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/produto_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/ItemPedidoEntradaModel.dart';
import 'package:gpp/src/models/ItemPedidoSaidaModel.dart';
import 'package:gpp/src/models/PecaEstoqueModel.dart';
import 'package:gpp/src/models/PecaModel.dart';
import 'package:gpp/src/models/pecas_model/peca_model.dart';
import 'package:gpp/src/models/pedido_entrada_model.dart';
import 'package:gpp/src/models/pedido_saida_model.dart';
import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/shared/utils/GerarPedidoEntradaPDF.dart';
import 'package:gpp/src/shared/utils/GerarPedidoSaidaPDF.dart';
import 'package:intl/intl.dart';

import 'package:gpp/src/controllers/MotivoTrocaPecaController.dart';
import 'package:gpp/src/controllers/asteca_controller.dart';

import 'package:gpp/src/models/asteca/asteca_model.dart';
import 'package:gpp/src/models/asteca/asteca_tipo_pendencia_model.dart';
import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/shared/components/ButtonComponent.dart';
import 'package:gpp/src/shared/components/CheckboxComponent.dart';
import 'package:gpp/src/shared/components/drop_down_component.dart';
import 'package:gpp/src/shared/components/InputComponent.dart';
import 'package:gpp/src/shared/components/loading_view.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/utils/MaskFormatter.dart';
import 'package:gpp/src/views/asteca/components/item_menu.dart';

class ItemProdutoPeca {
  bool marcado = false;
  late ProdutoPecaModel produtoPeca;
  ItemProdutoPeca({
    required this.marcado,
    required this.produtoPeca,
  });
}

class AstecaDetalheView extends StatefulWidget {
  final int id;
  const AstecaDetalheView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _AstecaDetalheViewState createState() => _AstecaDetalheViewState();
}

class _AstecaDetalheViewState extends State<AstecaDetalheView> {
  late AstecaController astecaController;
  late ProdutoController produtoController;
  late PedidoEntradaController pedidoEntracaController;
  late EmailPedidoEntradaController emailPedidoEntracaController;
  List<ItemProdutoPeca> itemsProdutoPeca = [];
  List<ItemProdutoPeca> itemsProdutoPecaBusca = [];
  int marcados = 0;
  bool abrirFiltro = false;
  late MotivoTrocaPecaController motivoTrocaPecaController;

  late ResponsiveController _responsive;
  late MaskFormatter maskFormatter;
  late String selecionado;
  late PecaEstoqueModel pecaEstoque;
  bool error = false;

  buscar() async {
    setState(() {
      astecaController.carregado = false;
    });
    astecaController.asteca = await astecaController.repository.buscarAsteca(widget.id);

    setState(() {
      astecaController.carregado = true;
    });
  }

  buscarAstecaTipoPendencias() async {
    setState(() {
      astecaController.carregado = false;
    });

    astecaController.astecaTipoPendencias = await astecaController.astecaTipoPendenciaRepository.buscarAstecaTIpoPendencias();

    setState(() {
      astecaController.carregado = true;
    });
  }

  buscarMotivosTrocaPeca() async {
    setState(() {
      astecaController.carregado = false;
    });

    motivoTrocaPecaController.motivoTrocaPecas = await motivoTrocaPecaController.repository.buscarTodos();

    setState(() {
      astecaController.carregado = true;
    });
  }

  handlePendencia(AstecaModel asteca, AstecaTipoPendenciaModel pendencia) async {
    await astecaController.astecaTipoPendenciaRepository.inserirAstecaPendencia(asteca.idAsteca!, pendencia);
    //Atualiza asteca
    await buscar();
  }

  gerarProdutoPeca() {
    produtoController.produto.produtoPecas!.forEach((element) {
      itemsProdutoPeca.add(ItemProdutoPeca(marcado: false, produtoPeca: element));
    });
  }

  /**
   * Função utilizada para marcar todas as checkbox das pecas
   */
  marcarTodosCheckbox(bool value) {
    if (value) {
      marcados = itemsProdutoPeca.length;
    } else {
      marcados = 0;
    }
    for (var itemPeca in itemsProdutoPeca) {
      itemPeca.marcado = value;
    }
  }

  //Nova lógica
  marcarCheckbox(index, value) {
    if (value) {
      marcados++;
    } else {
      marcados--;
    }
    itemsProdutoPeca[index].marcado = value;
  }

  /**
   * Adicionar pecas ao carrinho
   */

  adicionarPeca() {
    setState(() {
      for (var itemPeca in itemsProdutoPeca) {
        //Verifica se o item está marcado
        if (itemPeca.marcado) {
          //Verifica se já existe item com o mesmo id adicionado na lista
          int index = astecaController.pedidoSaida.itemsPedidoSaida!
              .indexWhere((element) => element.peca!.id_peca == itemPeca.produtoPeca.peca!.id_peca);
          //Se não existe item adiciona na lista
          if (index < 0) {
            astecaController.pedidoSaida.itemsPedidoSaida!.add(ItemPedidoSaidaModel(
              peca: itemPeca.produtoPeca.peca,
              valor: itemPeca.produtoPeca.peca!.custo!,
              quantidade: 1,
            ));
          } else {
            //Caso exista item na lista incrementa a quantidade;
            astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade++;
            astecaController.pedidoSaida.itemsPedidoSaida![index].valor += itemPeca.produtoPeca.peca!.custo!;
            //  astecaController.pedidoSaida.itemsPedidoSaida![index].valor += 0;
          }
          //Soma o total
          calcularValorTotal();
        }
        itemPeca.marcado = false;
      }
      marcados = 0;
    });

    print(astecaController.pedidoSaida.itemsPedidoSaida!.length);
  }

/**
   * Remover peça
   */
  removerPeca(index) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida!.removeAt(index);
    });
    calcularValorTotal();
  }

  calcularValorTotal() {
    setState(() {
      astecaController.pedidoSaida.valorTotal = 0.0;
      for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
        astecaController.pedidoSaida.valorTotal = astecaController.pedidoSaida.valorTotal! + item.quantidade * item.valor;
      }
    });
  }

  selecionarMotivoTrocaPeca(index, value) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida![index].motivoTrocaPeca = value;
    });
  }

  void adicionarQuantidade(index) {
    setState(() {
      astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade++;
    });
    calcularValorTotal();
  }

  void removerQuantidade(index) {
    if (astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade > 1) {
      setState(() {
        astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade--;
      });
      calcularValorTotal();
    } else {
      removerPeca(index);
    }
  }

  bool verificaEstoque() {
    bool verificaEstoque = true;
    if (!pedidoEntracaController.pedidoEntradaCriado) {
      for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
        if (item.peca!.estoqueUnico == null) {
          verificaEstoque = false;
          break;
        } else {
          if (item.quantidade > item.peca!.estoqueUnico!.saldoDisponivel) {
            verificaEstoque = false;
            break;
          }
        }
      }
    } else {
      for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
        item.pendenciaItem = true;
      }
    }
    return verificaEstoque;
  }

  verificarSelecaoMotivoTrocaPeca() {
    bool verificaSelecaoMotivoTrocaPeca = true;
    for (var item in astecaController.pedidoSaida.itemsPedidoSaida!) {
      if (item.motivoTrocaPeca == null) {
        verificaSelecaoMotivoTrocaPeca = false;
        break;
      }
    }
    return verificaSelecaoMotivoTrocaPeca;
  }

  myShowDialog(String text) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[
            Padding(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber, color: Colors.amber, size: 45.0),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        TextComponent(
                          text,
                          fontSize: 20.0,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonComponent(
                            color: primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Ok'),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0))
          ]);
        });
  }

  /**
   * Função destinada a finalizar o pedido
   */

  finalizarPedido() async {
    try {
      if (verificaEstoque()) {
        if (!verificarSelecaoMotivoTrocaPeca()) {
          myShowDialog('Selecione o motivo de troca da peça');
        }
        //Criar o pedido
        astecaController.pedidoSaida.cpfCnpj = astecaController.asteca.documentoFiscal!.cpfCnpj.toString();
        astecaController.pedidoSaida.filialVenda = astecaController.asteca.documentoFiscal!.idFilialVenda;
        astecaController.pedidoSaida.numDocFiscal = astecaController.asteca.documentoFiscal!.numDocFiscal;
        astecaController.pedidoSaida.serieDocFiscal = astecaController.asteca.documentoFiscal!.serieDocFiscal;

        astecaController.pedidoSaida.situacao = 1;
        astecaController.pedidoSaida.asteca = astecaController.asteca;
        astecaController.pedidoSaida.funcionario = astecaController.asteca.funcionario;
        astecaController.pedidoSaida.cliente = astecaController.asteca.documentoFiscal!.cliente;
        //Solicita o endpoint a criação do pedido

        PedidoSaidaModel pedidoComprovante = await astecaController.pedidoSaidaRepository.criar(astecaController.pedidoSaida);
        exibirComprovantePedidoSaida(pedidoComprovante);
      } else {
        exibirDialogPedidoEntrada();
      }
    } catch (e) {
      print(e);
    }
  }

  exibirComprovantePedidoSaida(pedidoConfirmacao) {
    //Notificação

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[
            Row(
              children: [
                Padding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextComponent(
                            'Nº Pedido: #${pedidoConfirmacao.idPedidoSaida}',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextComponent('Nome do cliente: ${pedidoConfirmacao.cliente!.nome}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextComponent('Filial venda: ${pedidoConfirmacao.filialVenda}'),
                        )
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                ButtonComponent(
                    color: primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                      navigatorKey2.currentState!.pushReplacementNamed('/pedidos-saida');
                    },
                    text: 'Ok'),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                    icon: Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      GerarPedidoSaidaPDF(pedido: pedidoConfirmacao).imprimirPDF();
                    },
                    text: 'Imprimir')
              ],
            )
          ]);
        });
  }

  exibirComprovantePedidoEntrada(PedidoEntradaModel pedidoConfirmacao) {
    //Notificação
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(actions: <Widget>[
            Row(
              children: [
                Padding(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextComponent(
                            'Nº Pedido: #${pedidoConfirmacao.idPedidoEntrada}',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: TextComponent(
                              'Nome do fornecedor: ${pedidoConfirmacao.asteca!.compEstProd!.first.produto!.fornecedores!.first.cliente!.nome}'),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0))
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                ButtonComponent(
                    color: primaryColor,
                    onPressed: () async {
                      Navigator.pop(context);
                      error ? error = false : await finalizarPedido();

                      navigatorKey2.currentState!.pushReplacementNamed('/pedidos-entrada');
                    },
                    text: 'Ok'),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                    icon: Icon(
                      Icons.print,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      GerarPedidoEntradaPDF(pedidoEntrada: pedidoConfirmacao).imprimirPDF();
                    },
                    text: 'Imprimir'),
                SizedBox(
                  width: 8,
                ),
                ButtonComponent(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      enviarEmailPedidoEntrada(pedidoConfirmacao);
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    text: 'Enviar e-mail')
              ],
            )
          ]);
        });
  }

  enviarEmailPedidoEntrada(pedidoConfirmacao) async {
    try {
      if (await emailPedidoEntracaController.repository.criar(pedidoConfirmacao)) {
        myShowDialog('E-mail enviado com sucesso');
        await Future.delayed(Duration(seconds: 3));
        navigatorKey2.currentState!.pushReplacementNamed('/pedidos-entrada');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  exibirDialogPedidoEntrada() {
    // set up the buttons
    Widget cancelarButton = TextButton(
      child: Text("Não"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget confirmarButton = TextButton(
      child: Text("Sim"),
      onPressed: () {
        Navigator.pop(context);
        criarPedidoEntrada();
        print('teste');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Aviso"),
      content: Text("Existem peças adicionadas que não possui  estoque disponível, gostaria de criar um pedido de entrada ?"),
      actions: [
        cancelarButton,
        confirmarButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<ItemPedidoEntradaModel> criarItensPedidoEntrada() {
    List<ItemPedidoEntradaModel> itensPedidoEntrada = [];

    astecaController.pedidoSaida.itemsPedidoSaida!.forEach((e) {
      itensPedidoEntrada.add(ItemPedidoEntradaModel(quantidade: e.quantidade, custo: e.valor, peca: e.peca));
    });

    return itensPedidoEntrada;
  }

  criarPedidoEntrada() async {
    if (!verificarSelecaoMotivoTrocaPeca()) {
      myShowDialog('Selecione o motivo de troca da peça');
    } else {
      //Criar o pedido de entrada
      PedidoEntradaModel pedidoEntrada = new PedidoEntradaModel(
          situacao: 1, //Em aberto,
          valorTotal: astecaController.pedidoSaida.valorTotal,
          //dataEmissao: DateTime.now(),
          funcionario: astecaController.pedidoSaida.funcionario,
          asteca: astecaController.asteca,
          itensPedidoEntrada: criarItensPedidoEntrada());
      //Solicita a criação do pedido de entrada
      try {
        var pedidoConfirmacao = await pedidoEntracaController.repository.criar(pedidoEntrada);
        pedidoEntracaController.pedidoEntradaCriado = true;

        //Atualiza a pendência da asteca
        var pendencia = new AstecaTipoPendenciaModel(idTipoPendencia: 651);

        await astecaController.astecaTipoPendenciaRepository.inserirAstecaPendencia(astecaController.asteca.idAsteca!, pendencia);

        //Exibi comprovante
        await exibirComprovantePedidoEntrada(pedidoConfirmacao);
      } catch (e) {
        pedidoEntracaController.pedidoEntradaCriado = false;
        error = true;
        print(e.toString());
      }
    }
  }

  pesquisarPecas(value) {
    itemsProdutoPecaBusca = itemsProdutoPeca
        .where((element) =>
            element.produtoPeca.peca!.descricao!.toLowerCase().contains(value.toString().toLowerCase()) ||
            element.produtoPeca.peca!.id_peca.toString().contains(value))
        .toList();
    print('as');
  }

  pesquisarPendencia(value) {
    setState(() {
      astecaController.astecaTipoPendenciasBuscar = astecaController.astecaTipoPendencias
          .where((element) =>
              element.descricao!.toLowerCase().contains(value.toString().toLowerCase()) ||
              element.idTipoPendencia.toString().contains(value))
          .toList();
    });
  }

  buscarProdutoPecas() async {
    setState(() {
      astecaController.carregaProdutoPeca = false;
    });
    produtoController.produto.produtoPecas = await produtoController.produtoRepository
        .buscarProdutoPecas(astecaController.asteca.compEstProd!.first.produto!.idProduto!.toString());
    setState(() {
      astecaController.carregaProdutoPeca = true;
    });
    //gerarItemPeca
    gerarProdutoPeca();
  }

  estoqueTotal(PecasModel peca) {
    int qtdTotal = 0;
    peca.estoque!.forEach((element) {
      qtdTotal += element.saldoDisponivel;
    });
    return qtdTotal.toString();
  }

  @override
  void initState() {
    super.initState();

    selecionado = '';

    //Inicializa asteca controller
    astecaController = AstecaController();

    //Inicializa produto controller
    produtoController = new ProdutoController();

    //Pedido de entrada controller
    pedidoEntracaController = PedidoEntradaController();

    //E-mail pedido de entrada controller
    emailPedidoEntracaController = EmailPedidoEntradaController();
    _responsive = ResponsiveController();

    //Instância máscaras
    maskFormatter = MaskFormatter();

    //Instância motivo de troca de peca controller
    motivoTrocaPecaController = MotivoTrocaPecaController();

    //Busca a asteca, utilizando o id como parâmetro
    buscar();

    //Busca lista de pendências
    buscarAstecaTipoPendencias();

    //Buscar motivos de troca de peças
    buscarMotivosTrocaPeca();
  }

  inserirQuantidade(index, value) {
    int quantidade = int.parse(value);

    if (quantidade == 0) {
      removerPeca(index);
    } else if (quantidade > 0) {
      setState(() {
        astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade = quantidade;
      });
      calcularValorTotal();
    }
  }

  _buildSituacaoEstoque(index) {
    if (astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico == null) {
      return Colors.red.shade100;
    } else {
      if (astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico!.saldoDisponivel <
          astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade) {
        return Colors.red.shade100;
      } else {
        return Colors.white;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    if (_responsive.isMobile(media.size.width)) {
      return Scaffold(
        body: Container(
            child: Column(
          children: [
            Container(
              height: media.size.height * 0.10,
              child: _buildAstecaMenu(media),
            ),
            Container(
              height: media.size.height * 0.90,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAstecaNavigator(media),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          astecaController.step > 1
                              ? ButtonComponent(
                                  color: primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      astecaController.step--;
                                    });
                                  },
                                  text: 'Voltar')
                              : Container(),
                          Row(
                            children: [
                              astecaController.step != 4
                                  ? ButtonComponent(
                                      color: primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          astecaController.step++;
                                        });
                                      },
                                      text: 'Avançar')
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      );
    } else {
      return astecaController.carregado
          ? Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: const TitleComponent(
                                  'Asteca',
                                ),
                              ),
                              // Expanded(
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: Colors.pink,
                              //         borderRadius: BorderRadius.circular(5)),
                              //     child: DropdownButtonFormField<String>(
                              //       icon: Visibility(
                              //           visible: false,
                              //           child: Icon(Icons.arrow_downward)),
                              //       hint: Row(
                              //         children: [
                              //           TextComponent(
                              //             'A FAZER',
                              //             color: Colors.white,
                              //           ),
                              //         ],
                              //       ),
                              //       decoration: InputDecoration(
                              //           contentPadding: EdgeInsets.only(
                              //               left: 16, top: 6, bottom: 6),
                              //           border: InputBorder.none),
                              //       items: <String>['A', 'B', 'C', 'D']
                              //           .map((String value) {
                              //         return DropdownMenuItem<String>(
                              //           value: value,
                              //           child: Row(
                              //             children: [
                              //               Container(
                              //                 width: 16,
                              //                 height: 16,
                              //                 decoration: BoxDecoration(
                              //                     color: Colors.pink,
                              //                     borderRadius:
                              //                         BorderRadius.circular(2)),
                              //               ),
                              //               SizedBox(
                              //                 width: 8,
                              //               ),
                              //               TextComponent(value),
                              //             ],
                              //           ),
                              //         );
                              //       }).toList(),
                              //       onChanged: (_) {},
                              //     ),
                              //   ),
                              // ),
                              astecaController.carregado
                                  ? Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            astecaController.abrirDropDownButton = !astecaController.abrirDropDownButton;
                                          });
                                        },
                                        child: Container(
                                          decoration:
                                              BoxDecoration(color: secundaryColor, borderRadius: BorderRadius.circular(5)),
                                          child: Padding(
                                              padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
                                              child: astecaController.asteca.astecaPendencias!.isNotEmpty
                                                  ? TextComponent(
                                                      astecaController
                                                              .asteca.astecaPendencias!.last.astecaTipoPendencia!.idTipoPendencia
                                                              .toString() +
                                                          ' - ' +
                                                          astecaController
                                                              .asteca.astecaPendencias!.last.astecaTipoPendencia!.descricao
                                                              .toString(),
                                                      color: Colors.white)
                                                  : const TextComponent('Aguardando Pendência', color: Colors.white)),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildAstecaMenu(media)),
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    _buildAstecaNavigator(media),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [],
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              astecaController.asteca.pedidoSaida == null
                                  ? ButtonComponent(
                                      color: primaryColor,
                                      onPressed: () {
                                        finalizarPedido();
                                      },
                                      text: 'Finalizar pedido')
                                  : Container(),
                              const SizedBox(
                                width: 8,
                              ),
                              ButtonComponent(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Fechar')
                            ],
                          ),
                        )
                      ],
                    ),
                    astecaController.abrirDropDownButton
                        ? Positioned(
                            top: 60,
                            right: 14,
                            child: Container(
                              height: 240,
                              width: 600,
                              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InputComponent(
                                          onChanged: (value) {
                                            pesquisarPendencia(value);
                                          },
                                          hintText: 'Buscar',
                                        ),
                                      )
                                    ],
                                  ),
                                  astecaController.carregado
                                      ? Expanded(
                                          child: astecaController.astecaTipoPendenciasBuscar.isEmpty
                                              ? ListView.builder(
                                                  itemCount: astecaController.astecaTipoPendencias.length,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          handlePendencia(astecaController.asteca,
                                                              astecaController.astecaTipoPendencias[index]);

                                                          astecaController.abrirDropDownButton = false;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 16,
                                                              height: 16,
                                                              decoration: BoxDecoration(
                                                                  color: secundaryColor, borderRadius: BorderRadius.circular(2)),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            TextComponent(
                                                              astecaController.astecaTipoPendencias[index].idTipoPendencia
                                                                      .toString() +
                                                                  ' - ' +
                                                                  astecaController.astecaTipoPendencias[index].descricao
                                                                      .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : ListView.builder(
                                                  itemCount: astecaController.astecaTipoPendenciasBuscar.length,
                                                  itemBuilder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          handlePendencia(astecaController.asteca,
                                                              astecaController.astecaTipoPendenciasBuscar[index]);

                                                          astecaController.abrirDropDownButton = false;
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 16,
                                                              height: 16,
                                                              decoration: BoxDecoration(
                                                                  color: secundaryColor, borderRadius: BorderRadius.circular(2)),
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            TextComponent(
                                                              astecaController.astecaTipoPendenciasBuscar[index].idTipoPendencia
                                                                      .toString() +
                                                                  ' - ' +
                                                                  astecaController.astecaTipoPendenciasBuscar[index].descricao
                                                                      .toString(),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ))
                        : Container()
                  ],
                ),
              ],
            )
          : Container(height: media.size.height * 0, child: LoadingComponent());
    }
  }

  _buildAstecaMenu(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 1;
                });
              },
              child: Container(
                color: astecaController.step == 1 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Informações',
                          color: astecaController.step == 1 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 2;
                });
              },
              child: Container(
                color: astecaController.step == 2 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Endereço',
                          color: astecaController.step == 2 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 3;
                });
              },
              child: Container(
                color: astecaController.step == 3 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Produto',
                          color: astecaController.step == 3 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  astecaController.step = 4;
                });
              },
              child: Container(
                color: astecaController.step == 4 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextComponent('Peças',
                          color: astecaController.step == 4 ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 1;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Informações',
                  color: astecaController.step == 1 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 1 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 2;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Endereço',
                  color: astecaController.step == 2 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 2 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 3;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Produto',
                  color: astecaController.step == 3 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 3 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 4;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Peças',
                  color: astecaController.step == 4 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 4 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    astecaController.step = 5;
                    astecaController.abrirDropDownButton = false;
                  });
                },
                child: ItemMenu(
                  data: 'Histórico de pendências',
                  color: astecaController.step == 5 ? Colors.grey.shade50 : Colors.transparent,
                  borderColor: astecaController.step == 5 ? secundaryColor : Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        astecaController.asteca.pedidoSaida != null
            ? Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/pedidos-saida/' + astecaController.asteca.pedidoSaida!.idPedidoSaida.toString());
                      },
                      child: ItemMenu(
                        data: 'Pedido de saída',
                        color: astecaController.step == 1 ? Colors.grey.shade50 : Colors.transparent,
                        borderColor: astecaController.step == 1 ? secundaryColor : Colors.transparent,
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  _buildAstecaNavigator(MediaQueryData media) {
    switch (astecaController.step) {
      case 1:
        return _buildAstecaInformation(media);

      case 2:
        return _buildAstecaAndress(media);

      case 3:
        return _buildAstecaProduct(media);
      case 4:
        return _buildAstecaParts(media);
      case 5:
        return historicoPendencias();
    }
  }

  historicoPendencias() {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.history_rounded,
                size: 32,
              ),
              SizedBox(
                width: 8,
              ),
              TitleComponent('Histórico de pendências')
            ],
          ),
          SizedBox(
            height: 8,
          ),
          astecaController.carregado
              ? Container(
                  height: 700,
                  child: ListView.builder(
                    itemCount: astecaController.asteca.astecaPendencias!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: (index % 2) == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 340,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey.shade100),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextComponent(
                                      'Pendência:  ${astecaController.asteca.astecaPendencias![index].astecaTipoPendencia!.idTipoPendencia} - ${astecaController.asteca.astecaPendencias![index].astecaTipoPendencia!.descricao}',
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              : LoadingComponent()
        ],
      ),
    );
  }

  _buildAstecaInformation(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Informações'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Nº Asteca',
                initialValue: astecaController.asteca.idAsteca.toString(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'CPF/CNPJ',
                initialValue: '001.463.861-40',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Nº Fiscal',
                initialValue: astecaController.asteca.idAsteca.toString(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Filial de saída',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Tipo',
                initialValue: 'Cliente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Nome',
                initialValue: 'Maria Angela Rocha da Fonseca',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Série',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Filial venda',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Data de abertura',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Data de compra',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Filial Asteca',
                initialValue: '500',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.badge,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Funcionário (a)'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'RE',
                initialValue: '1032445',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Nome',
                initialValue: 'Kesley Alves de Oliveira',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.build,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  TitleComponent('Defeito'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                enable: false,
                label: 'Defeito',
                initialValue: 'Defeito de fabricação',
              ),
            ),
            Container(
              child: InputComponent(
                enable: false,
                label: 'Observação',
                initialValue: 'Solicitado pelo técnico, enviar 30 unidades de adesivos/ tapa furos.',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.description,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Informações'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nº Asteca',
                  initialValue: astecaController.asteca.idAsteca.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  initialValue: astecaController.asteca.documentoFiscal!.cpfCnpj == null
                      ? ''
                      : maskFormatter
                          .cpfCnpjFormatter(value: astecaController.asteca.documentoFiscal!.cpfCnpj.toString())!
                          .getMaskedText(),
                  label: 'CPF/CNPJ',
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue: astecaController.camelCaseAll(
                      astecaController.asteca.documentoFiscal!.nome == null ? '' : astecaController.asteca.documentoFiscal!.nome),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nº Fiscal',
                  initialValue: astecaController.asteca.documentoFiscal!.numDocFiscal == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.numDocFiscal.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Série',
                  initialValue: astecaController.asteca.documentoFiscal!.serieDocFiscal == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.serieDocFiscal,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Filial de saída',
                  initialValue: astecaController.asteca.documentoFiscal!.idFilialSaida == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.idFilialSaida.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Filial venda',
                  initialValue: astecaController.asteca.documentoFiscal!.idFilialVenda == null
                      ? ''
                      : astecaController.asteca.documentoFiscal!.idFilialVenda.toString(),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Tipo',
                  initialValue: 'Cliente',
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Data de abertura',
                  initialValue: astecaController.asteca.dataEmissao == null
                      ? ''
                      : DateFormat('yyyy/MM/dd').format(astecaController.asteca.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Data de compra',
                  initialValue: astecaController.asteca.documentoFiscal!.dataEmissao == null
                      ? ''
                      : DateFormat('yyyy/MM/dd').format(astecaController.asteca.documentoFiscal!.dataEmissao!),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Filial Asteca',
                  initialValue:
                      astecaController.asteca.idFilialRegistro == null ? '' : astecaController.asteca.idFilialRegistro.toString(),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.badge,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Funcionário (a)'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'RE',
                  initialValue: astecaController.asteca.funcionario!.idFuncionario == null
                      ? ''
                      : astecaController.asteca.funcionario!.idFuncionario.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue: astecaController.camelCaseAll(
                      astecaController.asteca.funcionario!.clienteFunc!.cliente!.nome == null
                          ? ''
                          : astecaController.asteca.funcionario!.clienteFunc!.cliente!.nome),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.build,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Defeito ou motivo'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Defeito',
                  initialValue: astecaController.camelCaseFirst(
                      astecaController.asteca.defeitoEstadoProd == null ? '' : astecaController.asteca.defeitoEstadoProd!),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  maxLines: 5,
                  label: 'Observação',
                  initialValue: astecaController
                      .camelCaseFirst(astecaController.asteca.observacao == null ? '' : astecaController.asteca.observacao),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaAndress(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Endereço',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Logradouro',
                  initialValue: 'Avenida Perimental Norte NR 1 AP 1903  Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Complemento',
                  initialValue: 'AP 1903 Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Bairro',
                  initialValue: 'Setor Candida de Morais',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Referência',
                  initialValue: 'Cond. Borges Landeiro',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Número',
                  initialValue: '01',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Cidade',
                  initialValue: ' Goiânia',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Estado',
                  initialValue: 'GO',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Telefone para contato',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Telefone',
                  initialValue: '(62) 99999-9999',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Endereço',
                style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Logradouro',
                  initialValue: astecaController.camelCaseFirst(astecaController.asteca.astecaEndCliente?.logradouro == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.logradouro.toString()),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 3,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Complemento',
                  initialValue: astecaController.camelCaseFirst(astecaController.asteca.astecaEndCliente?.complemento == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.complemento.toString()),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Número',
                  initialValue: astecaController.asteca.astecaEndCliente?.numero == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.numero.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Bairro',
                  initialValue: astecaController.camelCaseAll(astecaController.asteca.astecaEndCliente?.bairro == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.bairro.toString()),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'CEP',
                  initialValue: astecaController.asteca.astecaEndCliente?.cep == null
                      ? ''
                      : maskFormatter.cepInputFormmater(astecaController.asteca.astecaEndCliente?.cep.toString()).getMaskedText(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Cidade',
                  initialValue: astecaController.camelCaseAll(astecaController.asteca.astecaEndCliente?.localidade == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.localidade.toString()),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Estado',
                  initialValue: astecaController.asteca.astecaEndCliente?.uf == null
                      ? ''
                      : astecaController.asteca.astecaEndCliente?.uf.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Referência',
                  initialValue: astecaController.camelCaseFirst(astecaController.asteca.astecaEndCliente!.pontoReferencia1 ?? ''),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.call,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                'Telefone para contato',
                style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Telefone',
                  initialValue: astecaController.asteca.astecaEndCliente?.ddd == null ||
                          astecaController.asteca.astecaEndCliente?.telefone == null
                      ? ''
                      : maskFormatter
                          .telefoneInputFormmater(
                              '${astecaController.asteca.astecaEndCliente?.ddd.toString()} ${astecaController.asteca.astecaEndCliente?.telefone.toString()}')
                          .getMaskedText(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaProduct(MediaQueryData media) {
    if (_responsive.isMobile(media.size.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Produto',
                      style: TextStyle(letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'ID',
                  initialValue: '121245',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Nome',
                  initialValue: 'Coz Jazz 3 Pçs IPLDA IP2 IPH1G BEGE',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'LD',
                  initialValue: '02',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Fornecedor',
                  style: TextStyle(letterSpacing: 0.15, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'ID',
                  initialValue: '4545',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  enable: false,
                  label: 'Nome',
                  initialValue: 'Itatiaia',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.shopping_bag,
                size: 32,
              ),
              SizedBox(
                width: 12,
              ),
              TitleComponent('Produto'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'ID',
                  initialValue: astecaController.asteca.compEstProd!.first.produto!.idProduto == null
                      ? ''
                      : astecaController.asteca.compEstProd!.first.produto!.idProduto.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue: astecaController.camelCaseFirst(
                      astecaController.asteca.compEstProd!.first.produto!.resumida == null
                          ? ''
                          : astecaController.asteca.compEstProd!.first.produto!.resumida),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'LD',
                  initialValue: astecaController.asteca.documentoFiscal?.itemDocFiscal?.idLd == null
                      ? ''
                      : astecaController.asteca.documentoFiscal?.itemDocFiscal?.idLd.toString(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              const Icon(
                Icons.local_shipping,
              ),
              const SizedBox(
                width: 12,
              ),
              const TitleComponent('Fornecedor'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'ID',
                  initialValue: astecaController.asteca.compEstProd!.first.produto!.fornecedores!.first.idFornecedor == null
                      ? ''
                      : astecaController.asteca.compEstProd!.first.produto!.fornecedores!.first.idFornecedor.toString(),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 2,
                child: InputComponent(
                  enable: false,
                  key: UniqueKey(),
                  label: 'Nome',
                  initialValue: astecaController.camelCaseAll(
                      astecaController.asteca.compEstProd!.first.produto!.fornecedores!.first.cliente?.nome == null
                          ? ''
                          : astecaController.asteca.compEstProd!.first.produto!.fornecedores!.first.cliente?.nome),
                ),
              ),
              SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAstecaParts(media) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  color: primaryColor,
                  onPressed: () {
                    exibirPecas(context);
                  },
                  text: 'Adicionar peças')
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 16.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: InputComponent(
        //           prefixIcon: Icon(
        //             Icons.search,
        //           ),
        //           hintText: 'Buscar',
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: const TextComponent('ID'),
              ),
              Expanded(
                child: const TextComponent('Nome'),
              ),
              Expanded(
                flex: 2,
                child: const Center(
                  child: TextComponent('Quantidade'),
                ),
              ),
              Expanded(
                child: const TextComponent('Valor R\$'),
              ),
              Expanded(
                child: const Center(
                  child: TextComponent('Subtotal R\$'),
                ),
              ),
              Expanded(
                flex: 3,
                child: const Center(
                  child: TextComponent('Motivo'),
                ),
              ),
              Expanded(
                child: const TextComponent('Ações'),
              ),
              Expanded(
                flex: 1,
                child: const TextComponent('Endereço'),
              ),
              Expanded(
                flex: 1,
                child: const TextComponent('Saldo'),
              ),
            ],
          ),
        ),
        const Divider(),
        Container(
          height: media.size.height * 0.40,
          child: astecaController.asteca.pedidoSaida == null
              ? ListView.builder(
                  itemCount: astecaController.pedidoSaida.itemsPedidoSaida!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: _buildSituacaoEstoque(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child:
                                  TextComponent(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.id_peca.toString()),
                            ),
                            Expanded(
                              child: TextComponent(astecaController
                                  .camelCaseFirst(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.descricao)),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      removerQuantidade(index);
                                    },
                                    icon: Icon(
                                      Icons.remove_circle_outlined,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InputComponent(
                                      key: UniqueKey(),
                                      maxLines: 1,
                                      initialValue: astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade.toString(),
                                      onFieldSubmitted: (value) {
                                        inserirQuantidade(index, value);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    color: Colors.green,
                                    onPressed: () {
                                      adicionarQuantidade(index);
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TextComponent(
                                  astecaController.formatter.format(astecaController.pedidoSaida.itemsPedidoSaida![index].valor)),
                            ),
                            Expanded(
                              child: TextComponent('R\$: ' +
                                  astecaController.formatter.format(
                                      (astecaController.pedidoSaida.itemsPedidoSaida![index].quantidade *
                                          astecaController.pedidoSaida.itemsPedidoSaida![index].valor))),
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                    child: DropDownComponent(
                                      onChanged: (value) {
                                        selecionarMotivoTrocaPeca(index, value);
                                      },
                                      items: motivoTrocaPecaController.motivoTrocaPecas.map((value) {
                                        return DropdownMenuItem<MotivoTrocaPecaModel>(
                                          value: value,
                                          child: Text(astecaController.camelCaseFirst(value.nome.toString())),
                                        );
                                      }).toList(),
                                      hintText: 'Selecione o motivo',
                                    ),
                                  ),
                                )),
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
                                        removerPeca(index);
                                      }),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico != null
                                  ? astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico!.endereco.toString()
                                  : '-'),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico != null
                                  ? astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoqueUnico!.saldoDisponivel
                                      .toString()
                                  : '-'),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Container(
                            //     padding: EdgeInsets.all(5),
                            //     child: DropdownSearch<PecaEstoqueModel>(
                            //       mode: Mode.MENU,
                            //       showSearchBox: false,
                            //       onChanged: (value) {
                            //         print(value!.saldoDisponivel);

                            //         setState(() {
                            //           astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoque!.remove(value);
                            //           astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoque!.add(value);
                            //         });
                            //       },
                            //       emptyBuilder: (context, searchEntry) => Center(child: Text('Não existe estoque!')),
                            //       items: astecaController.pedidoSaida.itemsPedidoSaida![index].peca!.estoque,
                            //       //produtoController.produto.produtoPecas![index].peca!.estoque!,
                            //       itemAsString: (PecaEstoqueModel? value) {
                            //         return "End: ${value!.endereco} / Qtd: ${value.saldoDisponivel}";
                            //       },
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container(
                  child: ListView.builder(
                    itemCount: astecaController.asteca.pedidoSaida!.itemsPedidoSaida!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextComponent(
                                  astecaController.asteca.pedidoSaida!.itemsPedidoSaida?[index].idItemPedidoSaida.toString() ??
                                      ''),
                            ),
                            Expanded(
                              child: TextComponent(astecaController.camelCaseFirst(
                                      astecaController.asteca.pedidoSaida!.itemsPedidoSaida![index].peca!.descricao) ??
                                  ''),
                            ),
                            Expanded(
                              flex: 2,
                              child: TextComponent(
                                  astecaController.asteca.pedidoSaida!.itemsPedidoSaida?[index].quantidade.toString() ?? ''),
                            ),
                            Expanded(
                              child: TextComponent(astecaController.formatter
                                  .format(astecaController.asteca.pedidoSaida!.itemsPedidoSaida![index].valor)),
                            ),
                            Expanded(
                                child: TextComponent(
                              astecaController.formatter.format(
                                  astecaController.asteca.pedidoSaida!.itemsPedidoSaida![index].quantidade *
                                      astecaController.asteca.pedidoSaida!.itemsPedidoSaida![index].valor),
                            )),
                            Expanded(
                              flex: 3,
                              child: TextComponent(astecaController.camelCaseFirst(astecaController
                                  .asteca.pedidoSaida!.itemsPedidoSaida![index].motivoTrocaPeca!.nome
                                  .toString())),
                            ),
                            Expanded(
                              child: const TextComponent(''),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ${astecaController.pedidoSaida.itemsPedidoSaida!.length} peças selecionadas',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              'Valor total R\$: ' + astecaController.formatter.format(astecaController.pedidoSaida.valorTotal),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  exibirPecas(context) async {
    try {
      //Carrega peças
      await buscarProdutoPecas();

      MediaQueryData media = MediaQuery.of(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: Row(
                  children: [
                    const Icon(
                      Icons.settings,
                      size: 32,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const TitleComponent('Peças'),
                  ],
                ),
                content: Container(
                  width: media.size.width * 0.80,
                  height: media.size.height * 0.80,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const TextComponent(
                              'Selecione uma ou mais peças para realizar a manutenção do produto',
                              letterSpacing: 0.15,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InputComponent(
                                onChanged: (value) {
                                  setState(() {
                                    pesquisarPecas(value);
                                  });
                                },
                                maxLines: 1,
                                prefixIcon: const Icon(
                                  Icons.search,
                                ),
                                hintText: 'Buscar',
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ButtonComponent(
                                icon: Icon(Icons.tune_rounded, color: Colors.white),
                                color: secundaryColor,
                                onPressed: () {
                                  setState(() {
                                    abrirFiltro = !abrirFiltro;
                                  });
                                },
                                text: 'Adicionar filtro')
                          ],
                        ),
                      ),
                      Container(
                        height: abrirFiltro ? null : 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              Container(
                                width: 220,
                                child: DropDownComponent(
                                  icon: const Icon(
                                    Icons.swap_vert,
                                  ),
                                  items: <String>['Ordem crescente', 'Ordem decrescente'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hintText: 'Nome',
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 220,
                                child: DropDownComponent(
                                  icon: const Icon(
                                    Icons.swap_vert,
                                  ),
                                  items: <String>['Ordem crescente', 'Ordem decrescente'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hintText: 'Estoque disponível',
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                width: 220,
                                child: DropDownComponent(
                                  icon: const Icon(
                                    Icons.swap_vert,
                                  ),
                                  items: <String>[
                                    'Último dia',
                                    'Último 15 dias',
                                    'Último 30 dias',
                                    'Último semestre',
                                    'Último ano'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  hintText: 'Período',
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey.shade50,
                        height: astecaController.abrirFiltro ? null : 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InputComponent(
                                  label: 'Data de criação:',
                                  hintText: 'Digite a data de criação da peça',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: InputComponent(
                                  label: 'Data de criação:',
                                  hintText: 'Digite a data de criação da peça',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          CheckboxComponent(
                            value: marcados == itemsProdutoPeca.length,
                            onChanged: (bool value) {
                              setState(() {
                                marcarTodosCheckbox(value);
                              });
                            },
                          ),
                          Expanded(
                            child: const TextComponent('ID'),
                          ),
                          Expanded(
                            child: const TextComponent('Nome'),
                          ),
                          Expanded(
                            child: const TextComponent(
                              'Valor R\$',
                            ),
                          ),
                          Expanded(
                            child: const TextComponent('Endereço'),
                          ),
                          Expanded(
                            child: const TextComponent('Saldo'),
                          ),
                        ],
                      ),
                      const Divider(),
                      Expanded(
                        child: itemsProdutoPecaBusca.length == 0
                            ? ListView.builder(
                                itemCount: itemsProdutoPeca.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                                    child: Row(
                                      children: [
                                        CheckboxComponent(
                                            value: itemsProdutoPeca[index].marcado,
                                            onChanged: (bool value) => {
                                                  setState(() {
                                                    marcarCheckbox(index, value);
                                                  })
                                                }),
                                        Expanded(
                                          child: TextComponent(
                                              produtoController.produto.produtoPecas![index].peca?.id_peca.toString() ?? ''),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                              produtoController.produto.produtoPecas?[index].peca!.descricao! ?? ''),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                              produtoController.produto.produtoPecas![index].peca!.custo.toString()),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                            produtoController.produto.produtoPecas![index].peca!.estoqueUnico != null
                                                ? "${produtoController.produto.produtoPecas![index].peca!.estoqueUnico!.endereco}"
                                                : '-',
                                          ),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                            produtoController.produto.produtoPecas![index].peca!.estoqueUnico != null
                                                ? "${produtoController.produto.produtoPecas![index].peca!.estoqueUnico!.saldoDisponivel}"
                                                : '-',
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: Container(
                                        //     padding: EdgeInsets.all(5),
                                        //     child: DropdownSearch<PecaEstoqueModel>(
                                        //       mode: Mode.MENU,
                                        //       showSearchBox: false,
                                        //       onChanged: (value) {},
                                        //       items: produtoController.produto.produtoPecas![index].peca!.estoque!,
                                        //       itemAsString: (PecaEstoqueModel? value) {
                                        //         return "Endereço: ${value!.endereco} / Estoque: ${value.saldoDisponivel}";
                                        //       },
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  );
                                })
                            : ListView.builder(
                                itemCount: itemsProdutoPecaBusca.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    color: (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                                    child: Row(
                                      children: [
                                        CheckboxComponent(
                                            value: itemsProdutoPecaBusca[index].marcado,
                                            onChanged: (bool value) => {
                                                  setState(() {
                                                    marcarCheckbox(index, value);
                                                  })
                                                }),
                                        Expanded(
                                          child: TextComponent(itemsProdutoPecaBusca[index].produtoPeca.peca!.id_peca.toString()),
                                        ),
                                        Expanded(
                                          child: TextComponent(itemsProdutoPecaBusca[index].produtoPeca.peca!.descricao!),
                                        ),
                                        Expanded(
                                          child: TextComponent(itemsProdutoPecaBusca[index].produtoPeca.peca!.custo.toString()),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                            itemsProdutoPecaBusca[index].produtoPeca.peca!.estoqueUnico != null
                                                ? "${itemsProdutoPecaBusca[index].produtoPeca.peca!.estoqueUnico!.endereco}"
                                                : '-',
                                          ),
                                        ),
                                        Expanded(
                                          child: TextComponent(
                                            itemsProdutoPecaBusca[index].produtoPeca.peca!.estoqueUnico != null
                                                ? "${itemsProdutoPecaBusca[index].produtoPeca.peca!.estoqueUnico!.saldoDisponivel}"
                                                : '-',
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent('Total de peças selecionadas: ${marcados}'),
                          Row(
                            children: [
                              ButtonComponent(
                                  color: Colors.red,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancelar'),
                              const SizedBox(
                                width: 12,
                              ),
                              ButtonComponent(
                                  color: secundaryColor,
                                  onPressed: () {
                                    adicionarPeca();
                                    Navigator.pop(context);
                                  },
                                  text: 'Adicionar')
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
          });
    } catch (e) {
      myShowDialog(e.toString());
    }
  }
}
