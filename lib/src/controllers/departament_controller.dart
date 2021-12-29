import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/repositories/departament_repository.dart';
import 'package:gpp/src/shared/enumeration/departament_enum.dart';

class DepartamentController {
  DepartamentRepository repository;
  List<DepartamentModel> departaments = [];
  List<SubFuncionalities> subFuncionalities = [];
  DepartamentEnum state = DepartamentEnum.notDepartament;

  DepartamentController({
    required this.repository,
  });

  Future<void> changeDepartament() async {
    departaments = await repository.fetchDepartament();
  }

  Future<bool> updateUserSubFuncionalities(DepartamentModel departament,
      List<SubFuncionalities> subFuncionalities) async {
    return await repository.updateDepartmentSubFuncionalities(
        departament, subFuncionalities);
  }

  Future<void> changeDepartamentSubFuncionalities(
      DepartamentModel departament) async {
    subFuncionalities = await repository.fetchSubFuncionalities(departament);
  }

  // List<UserModel> usersSearch = [];

  // UserEnum state = UserEnum.notUser;

  // Future<void> changeUser() async {
  //   users = await repository.fetchUser();
  // }

  // void search(String value) {
  //   usersSearch = users
  //       .where((user) =>
  //           (user.name!.toLowerCase().contains(value.toLowerCase()) ||
  //               user.uid!.toLowerCase().contains(value.toLowerCase())))
  //       .toList();
  // }

}
