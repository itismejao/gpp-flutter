import 'package:get/get.dart';
import 'package:gpp/src/models/produto/produto_model.dart';
import 'package:gpp/src/models/produto_peca_model.dart';
import 'package:gpp/src/repositories/pecas_repository/produto_repositoy.dart';
import 'package:gpp/src/views/produto/produto_detalhe_view.dart';

class ProdutoController extends GetxController {
  var count = 0;
  var carregado = false.obs;
  late ProdutoRepository produtoRepository;
  late List<ProdutoModel> produtos;
  late List<ProdutoPecaModel> produtoPecas;

  ProdutoController() {
    produtoRepository = ProdutoRepository();
    produtos = [];
    produtoPecas = [];
  }

  @override
  void onInit() async {
    buscarProdutos();
    super.onInit();
  }

  buscarProdutos() async {
    this.produtos = await produtoRepository.buscarProdutos();
    carregado(true);
  }

  buscarProdutoPecas(int idProduto) async {
    this.produtoPecas = await produtoRepository.buscarProdutoPecas(idProduto);
  }

  exibirProdutoDetalhe(ProdutoModel produto) async {
    await buscarProdutoPecas(560);

    Get.dialog(ProdutoDetalheView(
        // produto: produto,
        ));
  }
}
