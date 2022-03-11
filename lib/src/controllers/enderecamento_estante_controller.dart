import 'package:gpp/src/models/estante_enderecamento_model.dart';
import 'package:gpp/src/repositories/estante_enderacamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EnderecamentoEstanteController {
  EstanteEnderecamentoRepository repository =
      EstanteEnderecamentoRepository(api: gppApi);
  bool isLoaded = false;

  late EstanteEnderecamentoModel estanteEnderecamentoReplacement =
      EstanteEnderecamentoModel();

  late List<EstanteEnderecamentoModel> estanteEnderecamentoReplacements;
}
