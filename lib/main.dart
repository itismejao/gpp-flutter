// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:gpp/src/models/user_model.dart';

// import 'package:gpp/src/views/not_found_view.dart';
// import 'package:gpp/src/shared/services/auth.dart';
// import 'package:gpp/src/views/authenticated/authenticate_view.dart';
// import 'package:gpp/src/views/departaments/departament_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_form_create_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_home_view.dart';
// import 'package:gpp/src/views/funcionalities/funcionalities_list_view.dart';
// import 'package:gpp/src/views/funcionalities_view.dart';
// import 'package:gpp/src/views/home_view.dart';
// import 'package:gpp/src/views/users/user_detail.view.dart';
// import 'package:gpp/src/views/users/user_view.dart';

// main() async {
//   await dotenv.load(fileName: "env");

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   Widget checkAuthenticate(Widget page) {
//     if (isAuthenticated()) {
//       return page;
//     } else {
//       return const AuthenticateView();
//     }
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GPP - Gerenciamento de Peças e Pedidos',
//       theme: ThemeData(
//           primarySwatch: Colors.blue,
//           fontFamily: 'Mada',
//           inputDecorationTheme:
//               const InputDecorationTheme(iconColor: Colors.grey)),
//       // home: const AuthenticateView(),
//       home: Scaffold(body: HomeView()),
//       routes: {
//         '/home': (context) => checkAuthenticate(const HomeView()),
//         '/login': (context) => const AuthenticateView(),
//         '/users': (context) => const UserView(),
//         '/user_detail': (context) => UserDetailView(
//               user: UserModel(),
//             ),
//         '/not_found': (context) => checkAuthenticate(const NotFoundView()),
//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/views/astecas/asteca_list_view.dart';
import 'package:gpp/src/views/authenticated/authenticate_view.dart';
import 'package:gpp/src/views/departaments/departament_detail_view.dart';
import 'package:gpp/src/views/departaments/departament_form_view.dart';
import 'package:gpp/src/views/departaments/departament_list_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_detail_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_form_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_list_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';

import 'package:gpp/src/views/home/home_view.dart';
import 'package:gpp/src/views/not_found_view.dart';
import 'package:gpp/src/views/subfuncionalities/subfuncionalities_form_view.dart';
import 'package:gpp/src/views/users/user_detail.view.dart';
import 'package:gpp/src/views/users/user_list_view.dart';

import 'src/views/funcionalities/funcionalities_form_view.dart';

void main() async {
  await dotenv.load(fileName: "env");
  runApp(GppApp());
  // runApp(MaterialApp(
  //   home: Scaffold(body: DepartamentListView()),
  // ));
}

class GppApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GppAppState();
}

class _GppAppState extends State<GppApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPP - Gerenciamento de Peças e Pedidos',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Mada',
          inputDecorationTheme:
              const InputDecorationTheme(iconColor: Colors.grey)),
      onGenerateRoute: (settings) {
        // Handle '/'
        if (isAuthenticated()) {
          if (settings.name == '/') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                    ));
          }

          if (settings.name == '/logout') {
            return MaterialPageRoute(builder: (context) => AuthenticateView());
          }

          //Handle '/users
          if (settings.name == '/users') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: UserListView(),
                    ));
          }

          //Handle '/departaments
          if (settings.name == '/departaments') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: DepartamentListView(),
                    ));
          }

          if (settings.name == '/funcionalities') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: FuncionalitiesListView(),
                    ));
          }

          // if (settings.name == '/subfuncionalities') {
          //   return MaterialPageRoute(
          //       builder: (context) => HomeView(
          //             funcionalities: FuncionalitiesView(),
          //             page: SubFuncionalitiesListView(),
          //           ));
          // }

          if (settings.name == '/funcionalities/register') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: FuncionalitiesFormView(),
                    ));
          }

          if (settings.name == '/departamento/register') {
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: DepartamentFormView(),
                    ));
          }

          // Handle '/departaments/:id'

          var uri = Uri.parse(settings.name!);
          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'departaments') {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: DepartamentDetailView(
                        id: id,
                      ),
                    ));
          }

          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'funcionalities') {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: FuncionalitiesDetailView(
                        id: id,
                      ),
                    ));
          }

          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'subfuncionalities') {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: SubFuncionalitiesFormView(
                        id: id,
                      ),
                    ));
          }

          // Handle '/users/:id'

          if (uri.pathSegments.length == 2 &&
              uri.pathSegments.first == 'users') {
            var id = uri.pathSegments[1];
            return MaterialPageRoute(
                builder: (context) => HomeView(
                      funcionalities: FuncionalitiesView(),
                      page: UserDetailView(
                        id: id,
                      ),
                    ));
          }
        } else {
          return MaterialPageRoute(builder: (context) => AuthenticateView());
        }

        if (settings.name == '/astecas') {
          return MaterialPageRoute(
              builder: (context) => HomeView(
                funcionalities: FuncionalitiesView(),
                page: AstecaListView(),
              ));
        }

        return MaterialPageRoute(builder: (context) => NotFoundView());
      },
    );
  }
}
