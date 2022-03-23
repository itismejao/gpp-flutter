import 'package:gpp/src/models/produto/fornecedor_model.dart';
import 'package:gpp/src/repositories/pecas_repository/fornecedor_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class FornecedorController {
  late final FornecedorRepository fornecedorRepository =
      FornecedorRepository(api: gppApi);

  FornecedorModel fornecedorModel = FornecedorModel();

  Future<void> buscar(String id) async {
    fornecedorModel = await fornecedorRepository.buscar(id);
  }
}
