
import 'package:gpp/src/models/prateleira_enderecamento_model.dart';
import 'package:gpp/src/repositories/prateleira_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class EnderecamentoPrateleiraController {
  PrateleiraEnderecamentoRepository repository = PrateleiraEnderecamentoRepository(api: gppApi);
  bool isLoaded = false;

  late PrateleiraEnderecamentoModel prateleiraEnderecamentoReplacement = PrateleiraEnderecamentoModel();

  late List<PrateleiraEnderecamentoModel> prateleiraEnderecamentoReplacements;
}
