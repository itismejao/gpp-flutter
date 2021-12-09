// // Import the test package and Counter class

// import 'package:flutter_test/flutter_test.dart';
// import 'package:gpp/src/shared/controllers/user_controller.dart';
// //import 'package:integration_test/integration_test.dart';
// //import 'package:dotenv/dotenv.dart';

// Future<void> main() async {
//   load();
//   group('Autenticação - Login', () {
//     test(
//         'Verifica integração com endpoint de login com usuário e senha corretos',
//         () async {
//       var userController = UserController();
//       var userModel = await userController.login("9010000401", "Novo2021*");

//       expect(userModel, isNot(null));
//     });
//     test(
//         'Verifica integração com endpoint de login com usuário e senha incorretos',
//         () async {
//       var userController = UserController();
//       var userModel = await userController.login("9010000401", "Novo2021");

//       expect(userModel, null);
//     });
//   });

//   group('Autenticação - Token', () {
//     // test(
//     //     'Verifica integração com endpoint de criação de token com e-mail e senha corretos',
//     //     () async {
//     //   var userController = UserController();
//     //   await userController.login("9010000401", "Novo2021");

//     //   var tokenModel = await userController.createToken(
//     //       "9010000401@novomundo.com.br", "Novo2021*");

//     //   expect(tokenModel, isNot(null));
//     // });
//     // test(
//     //     'Verifica integração com endpoint de login com usuário e senha incorretos',
//     //     () async {
//     //   var userController = UserController();
//     //   var userModel = await userController.login("9010000401", "Novo2021");

//     //   expect(userModel, null);
//     // });
//   });
// }
