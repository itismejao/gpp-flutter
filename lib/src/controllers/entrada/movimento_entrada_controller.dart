
import 'package:gpp/src/models/entrada/movimento_entrada_model.dart';
import 'package:gpp/src/repositories/entrada/movimento_entrada_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class MovimentoEntradaController{

  late final MovimentoEntradaRepository movimentoEntradaRepository = MovimentoEntradaRepository(api: gppApi);

  Future<List<MovimentoEntradaModel>> buscarTodos(String? id_filial, {String? id_funcionario}) async{
    return await movimentoEntradaRepository.buscarTodos(id_filial,id_funcionario: id_funcionario);
  }

}