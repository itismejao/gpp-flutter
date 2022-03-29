import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/repositories/MotivoTrocaPecaRepository.dart';

class MotivoTrocaPecaController {
  MotivoTrocaPecaRepository repository = MotivoTrocaPecaRepository();
  bool isLoaded = false;

  late MotivoTrocaPecaModel motivoTrocaPeca = MotivoTrocaPecaModel();

  late List<MotivoTrocaPecaModel> motivoTrocaPecas = [];
}
