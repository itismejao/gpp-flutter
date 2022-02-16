import 'package:gpp/src/models/corredor_enderecamento_model.dart';
import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/repositories/corredor_enderecamento_repository.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EnderecamentoCorredorController {
  CorredorEnderecamentoRepository repository = CorredorEnderecamentoRepository(api: gppApi);
  bool isLoaded = false;

  late CorredorEnderecamentoModel corredorEnderecamentoReplacement = CorredorEnderecamentoModel();

  late List<CorredorEnderecamentoModel> corredorEnderecamentoReplacements;
}
