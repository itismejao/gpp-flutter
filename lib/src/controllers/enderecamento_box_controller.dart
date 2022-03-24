import 'package:gpp/src/models/box_enderecamento_model.dart';
import 'package:gpp/src/repositories/box_enderecamento_repository.dart';

class EnderecamentoBoxController {
  BoxEnderecamentoRepository repository = BoxEnderecamentoRepository();
  bool isLoaded = false;

  late BoxEnderecamentoModel boxEnderecamentoReplacement =
      BoxEnderecamentoModel();

  late List<BoxEnderecamentoModel> boxEnderecamentoReplacements;
}
