import 'package:gpp/src/models/piso_enderecamento_model.dart';
import 'package:gpp/src/repositories/piso_enderecamento_repository.dart';

class AddressingFloorController {
  PisoEnderecamentoRepository repository = PisoEnderecamentoRepository();
  bool isLoaded = false;

  late PisoEnderecamentoModel pisoEnderecamentoReplacement =
      PisoEnderecamentoModel();

  late List<PisoEnderecamentoModel> pisoEnderecamentoReplacements;
}
