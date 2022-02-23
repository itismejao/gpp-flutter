import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/repositories/MotivoTrocaPecaRepository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class MotivoTrocaPecaController {
  MotivoTrocaPecaRepository repository = MotivoTrocaPecaRepository(api: gppApi);
  bool isLoaded = false;

  late MotivoTrocaPecaModel motivoTrocaPeca = MotivoTrocaPecaModel();

  late List<MotivoTrocaPecaModel> motivoTrocaPecas = [];
}
