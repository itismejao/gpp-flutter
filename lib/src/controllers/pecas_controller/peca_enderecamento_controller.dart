import 'package:flutter/cupertino.dart';
import 'package:gpp/src/models/PaginaModel.dart';
import 'package:gpp/src/models/pecas_model/peca_enderecamento_model.dart';
import 'package:gpp/src/repositories/pecas_repository/peca_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class PecaEnderecamentoController{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PaginaModel pagina = PaginaModel(total: 0, atual: 1);

  late final PecaEnderecamentoRepository pecasEnderecamentoRepository = PecaEnderecamentoRepository(api: gppApi);

  Future<List<PecaEnderacamentoModel>> buscarTodos(int pagina_atual, int? id_filial, int? id_fornecedor, int? id_produto, int? id_peca,int? id_piso,int? id_corredor,int? id_estante,int? id_prateleira,int? id_box) async {
    List lista = await pecasEnderecamentoRepository.buscarTodos(pagina_atual, id_filial, id_fornecedor, id_produto, id_peca, id_piso, id_corredor, id_estante,id_prateleira, id_box);
    this.pagina = lista[1];
    return lista[0];
  }

  Future<bool> create(PecaEnderacamentoModel pe) async {
    return await pecasEnderecamentoRepository.create(pe);
  }

  Future<bool> editar(PecaEnderacamentoModel pe) async {
    return await pecasEnderecamentoRepository.editar(pe);
  }

  Future<bool> excluir(PecaEnderacamentoModel pe) async {
    return await pecasEnderecamentoRepository.excluir(pe);
  }


}