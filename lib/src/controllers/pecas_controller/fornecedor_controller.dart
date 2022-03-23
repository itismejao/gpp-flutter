import 'package:gpp/src/models/produto/fornecedor_model.dart';
import 'package:gpp/src/repositories/pecas_repository/fornecedor_repository.dart';

class FornecedorController {
  late final FornecedorRepository fornecedorRepository = FornecedorRepository();

  FornecedorModel fornecedorModel = FornecedorModel();

  Future<void> buscar(String id) async {
    fornecedorModel = await fornecedorRepository.buscar(id);
  }
}
