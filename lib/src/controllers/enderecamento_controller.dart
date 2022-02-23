import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/repositories/enderecamento_repository.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EnderecamentoController {
  EnderecamentoRepository repository = EnderecamentoRepository(api: gppApi);
  bool isLoaded = false;

  late PisoEnderecamentoModel pisoModel = PisoEnderecamentoModel();

  late List<PisoEnderecamentoModel> listaPiso;

  Future<List<PisoEnderecamentoModel>> buscarTodos() async {
    return await repository.buscarTodos();
  }
}
