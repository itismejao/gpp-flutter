import 'package:gpp/src/models/reason_parts_replacement_model.dart';
import 'package:gpp/src/repositories/reason_parts_replacement_repository.dart';
import 'package:gpp/src/shared/services/gpp_api.dart';

class ReasonPartsReplacementController {
  ReasonPartsReplacementRepository repository =
      ReasonPartsReplacementRepository(api: gppApi);
  bool isLoaded = false;
  late List<ReasonPartsReplacementModel> reasonPartsReplacements;
}
