// import 'package:flutter/material.dart';
// import 'package:gpp/src/controllers/responsive_controller.dart';
// import 'package:gpp/src/models/user_model.dart';
// import 'package:gpp/src/routes/gpp_route_path.dart';
// import 'package:gpp/src/views/appbar_view.dart';
// import 'package:gpp/src/views/autenticacao/AutenticacaoView.dart';

// import 'package:gpp/src/views/departamentos/departament_view.dart';

// import 'package:gpp/src/views/funcionalities_view.dart';
// import 'package:gpp/src/views/not_found_view.dart';

// class GppRouterDelegate extends RouterDelegate<GppRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<GppRoutePath> {
//   final GlobalKey<NavigatorState> navigatorKey;

//   String _currentPage = "/home";
//   late ResponsiveController _responsive = ResponsiveController();
//   //Modelos
//   UsuarioModel? _user;

//   handleSelectUser(UsuarioModel user) {
//     _currentPage = "/users";
//     _user = user;
//     notifyListeners();
//   }

//   String get currentPage => _currentPage;

//   set currentPage(value) {
//     _currentPage = value;
//     notifyListeners();
//   }

//   bool _authenticated = false;

//   bool get authenticated => _authenticated;

//   set authenticated(value) {
//     _authenticated = value;
//     notifyListeners();
//   }

//   bool show404 = false;

//   GppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   GppRoutePath get currentConfiguration {
//     if (show404) {
//       return GppRoutePath.unknown();
//     }

//     if (!authenticated) {
//       return GppRoutePath.login();
//     } else if (currentPage == "/home") {
//       return GppRoutePath.home();
//     } else if (currentPage == "/departaments") {
//       return GppRoutePath.departaments();
//     } else if (currentPage == "/users") {
//       if (_user != null) {
//         return GppRoutePath.details(_user!.id);
//       } else {
//         return GppRoutePath.users();
//       }
//     }

//     return GppRoutePath.unknown();
//   }

//   void handleLogin() {
//     authenticated = true;
//     notifyListeners();
//   }

//   void handleLogout() {
//     print('te');
//     authenticated = false;
//     notifyListeners();
//   }

//   void handleCurrentPage(value) {
//     print(value);
//     currentPage = value;
//     _user = null;
//     notifyListeners();
//   }

//   @override
//   Future<void> setNewRoutePath(GppRoutePath path) async {
//     if (path.isUnknown) {
//       show404 = true;
//     } else if (path.isLoginPage) {
//       show404 = false;
//       authenticated = false;
//     } else if (path.isHomePage) {
//       show404 = false;

//       currentPage = "/home";
//     } else if (path.isDepartaments) {
//       show404 = false;

//       currentPage = "/departaments";
//     } else if (path.isUsers) {
//       show404 = false;
//       currentPage = "/users";
//       _user = null;
//     } else if (path.isUsersDetails) {
//       currentPage = "/users";
//       _user = UsuarioModel(id: path.id);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     var stack;

//     // ignore: unnecessary_null_comparison
//     if (!authenticated) {
//       stack = AutenticacaoView();
//     } else {
//       var subStack;

//       if (currentPage == "/home") {
//         // subStack = HomeView();
//       } else if (currentPage == "/departaments") {
//         subStack = DepartamentView();
//       } else if (currentPage == "/users" && _user == null) {
//         // subStack = UserListView(
//         //   //handleSelectUser: (value) => handleSelectUser(value),
//         // );
//       } else if (currentPage == "/users" && _user != null) {
//         // subStack = UserDetailView(
//         //   user: _user!,
//         // );
//       }

//       stack = LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//         if (_responsive.isMobile(constraints.maxWidth) ||
//             _responsive.isTable(constraints.maxWidth)) {
//           return Scaffold(
//             appBar: PreferredSize(
//               preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
//               child: AppBarView(
//                   //   handleLogout: handleLogout,
//                   ),
//             ),
//             drawer: Container(
//                 color: Colors.white,
//                 width: mediaQuery.size.width * 0.70,
//                 child: FuncionalitiesView(
//                     // handleCurrentPage: (value) => handleCurrentPage(value),
//                     )),
//             body: Row(
//               children: [
//                 Expanded(
//                     child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     color: Colors.white,
//                     child: subStack,
//                   ),
//                 ))
//               ],
//             ),
//           );
//         }

//         return Scaffold(
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
//             child: AppBarView(
//                 //  handleLogout: handleLogout,
//                 ),
//           ),
//           body: Row(
//             children: [
//               Expanded(
//                 child: FuncionalitiesView(
//                     //handleCurrentPage: (value) => handleCurrentPage(value),
//                     ),
//               ),
//               Expanded(
//                   flex: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       color: Colors.white,
//                       child: subStack,
//                     ),
//                   ))
//             ],
//           ),
//         );
//       });
//     }

//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//           child: stack,
//         ),
//         if (show404)
//           MaterialPage(key: ValueKey('UnknownPage'), child: NotFoundView())
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }

//         // Update the list of pages by setting _selectedBook to null

//         show404 = false;
//         notifyListeners();

//         return true;
//       },
//     );
//   }
// }
