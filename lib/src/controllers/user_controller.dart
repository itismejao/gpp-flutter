import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/repositories/user_repository.dart';
import 'package:gpp/src/shared/enumeration/user_enum.dart';
import 'package:gpp/src/shared/repositories/global.dart';

class UserController {
  UserRepository repository;
  List<UserModel> users = [];
  List<UserModel> usersSearch = [];
  List<SubFuncionalities> subFuncionalities = [];
  UserEnum state = UserEnum.notUser;
  List<FuncionalitieModel> funcionalities = [];
  List<FuncionalitieModel> funcionalitiesSearch = [];

  UserController({
    required this.repository,
  });

  Future<void> changeUser() async {
    users = await repository.fetchUser();
  }

  Future<void> changeUserFuncionalities() async {
    UserModel user = UserModel();
    user.uid = "1";
    subFuncionalities = await repository.fetchSubFuncionalities(user);
  }

  void search(String value) {
    usersSearch = users
        .where((user) =>
            (user.name!.toLowerCase().contains(value.toLowerCase()) ||
                user.uid!.toLowerCase().contains(value.toLowerCase())))
        .toList();
  }

  Future<bool> updateUserSubFuncionalities(
      List<SubFuncionalities> subFuncionalities) async {
    UserModel user = UserModel();
    user.uid = "1";

    return await repository.updateUserSubFuncionalities(
        user, subFuncionalities);
  }

  Future<void> changeFuncionalities() async {
    UserModel user = UserModel();
    user.uid = authenticateUser!.id.toString();

    funcionalities = await repository.fetchFuncionalities(user);
  }

  void searchFuncionalities(String value) {
    funcionalitiesSearch = [];

    for (var funcionalitie in funcionalities) {
      if (funcionalitie.name.toLowerCase().contains(value.toLowerCase())) {
        funcionalitie.isExpanded = true;
        funcionalitiesSearch.add(funcionalitie);
      }
    }
  }
}
