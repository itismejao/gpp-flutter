import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
import 'package:gpp/src/repositories/enderecamento_repository.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EnderecamentoController {
  EnderecamentoRepository repository = EnderecamentoRepository(api: gppApi);
  bool isLoaded = false;

  late PisoEnderecamentoModel pisoModel = PisoEnderecamentoModel();
  late List<PisoEnderecamentoModel> listaPiso;

  late CorredorEnderecamentoModel corredorModel = CorredorEnderecamentoModel();
  late List<CorredorEnderecamentoModel> listaCorredor;

  late EstanteEnderecamentoModel estanteModel = EstanteEnderecamentoModel();
  late List<EstanteEnderecamentoModel> listaEstante;

  late PrateleiraEnderecamentoModel prateleiraModel = PrateleiraEnderecamentoModel();
  late List<PrateleiraEnderecamentoModel> listaPrateleira;

  late BoxEnderecamentoModel boxModel = BoxEnderecamentoModel();
  late List<BoxEnderecamentoModel> listaBox;

  Future<List<PisoEnderecamentoModel>> buscarTodos() async {
    return await repository.buscarTodos();
  }

    Future<List<CorredorEnderecamentoModel>> buscarCorredor(String idPiso) async {
    return await repository.buscarCorredor(idPiso);
  }

    Future<List<EstanteEnderecamentoModel>> buscarEstante(String idCorredor) async {
    return await repository.buscarEstante(idCorredor);
  }

  Future<List<PrateleiraEnderecamentoModel>> buscarPrateleira(String idEstante) async {
    return await repository.buscarPrateleira(idEstante);
  }

   Future<List<BoxEnderecamentoModel>> buscarBox(String idPrateleira) async {
    return await repository.buscarBox(idPrateleira);
  }
}
