import 'package:gpp/src/models/fornecedor_model.dart';
import 'package:gpp/src/repositories/pecas_repository/fornecedor_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class FornecedorController {
  late final FornecedorRepository fornecedorRepository = FornecedorRepository();

  FornecedorModel fornecedorModel = FornecedorModel();

  Future<void> buscar(String id) async {
    fornecedorModel = await fornecedorRepository.buscar(id);
  }
}
