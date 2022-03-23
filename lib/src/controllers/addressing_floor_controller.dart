import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class AddressingFloorController {
  PisoEnderecamentoRepository repository = PisoEnderecamentoRepository();
  bool isLoaded = false;

  late PisoEnderecamentoModel pisoEnderecamentoReplacement =
      PisoEnderecamentoModel();

  late List<PisoEnderecamentoModel> pisoEnderecamentoReplacements;
}
