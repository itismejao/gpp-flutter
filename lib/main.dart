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
import 'package:gpp/src/controllers/enderecamento_corredor_controller.dart';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/views/addressing/addressing_list_view.dart';
import 'package:gpp/src/views/addressing/cadastro_corredor_view.dart';
import 'package:gpp/src/views/addressing/cadastro_estante_view.dart';
import 'package:gpp/src/views/addressing/cadastro_prateleira_view.dart';
import 'package:gpp/src/views/addressing/cadastro_box_view.dart';
import 'package:gpp/src/controllers/AutenticacaoController.dart';
import 'package:gpp/src/repositories/AutenticacaoRepository.dart';

import 'package:gpp/src/shared/services/auth.dart';
import 'package:gpp/src/views/asteca/AstecaDetalheView.dart';
import 'package:gpp/src/views/asteca/AstecaListView.dart';

import 'package:gpp/src/views/authenticated/authenticate_view.dart';

import 'package:gpp/src/views/departamentos/departament_list_view.dart';

import 'package:gpp/src/views/funcionalities_view.dart';

import 'package:gpp/src/views/home/home_view.dart';
import 'package:gpp/src/views/not_found_view.dart';
import 'package:gpp/src/views/pedido/PedidoDetalheView.dart';
import 'package:gpp/src/views/pedido/PedidoListView.dart';
import 'package:gpp/src/views/pecas/menu_cadastrar_view.dart';
import 'package:gpp/src/views/pecas/pecas_detail_view.dart';
import 'package:gpp/src/views/pecas/menu_consultar_view.dart';
import 'package:gpp/src/views/rearson_parts/rearson_parts_form_view.dart';

import 'package:gpp/src/views/rearson_parts/reason_parts_replacement_list_view.dart';

import 'package:gpp/src/views/users/user_list_view.dart';

void main() async {
  await dotenv.load(fileName: "env");
  runApp(GppApp());
}

class GppApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GppAppState();
}

class _GppAppState extends State<GppApp> {
  obterRota(settings) {
    Widget pagina = NotFoundView();
    if (isAuthenticated()) {
      //Autenticação

      Uri uri = Uri.parse(settings.name);

//Se existe 1 parâmetros da url
      if (uri.pathSegments.length == 0) {
        pagina = PedidoListView();
      } else if (uri.pathSegments.length == 1) {
        if (uri.pathSegments.first == 'astecas') {
          pagina = AstecaListView();
        } else if (uri.pathSegments.first == 'pedidos') {
          pagina = PedidoListView();
        } else if (uri.pathSegments.first == 'departamentos') {
          pagina = DepartamentoListView();
        } else if (uri.pathSegments.first == 'usuarios') {
          pagina = UsuarioListView();
        } else if (uri.pathSegments.first == 'motivos-defeitos') {
          pagina = MotivosTrocaPecasListView();
        } else if (uri.pathSegments.first == 'logout') {
          pagina = AuthenticateView();
        } else if (uri.pathSegments.first == 'pecas-cadastrar') {
          pagina = MenuCadastrarView();
        } else if (uri.pathSegments.first == 'pecas-consultar') {
          pagina = MenuConsultarView();
        } else if (uri.pathSegments.first == 'pecas-enderecamento') {
          pagina = Container();
        }
        //Se existe 2 parâmetros da url
      } else if (uri.pathSegments.length == 2) {
        var id = int.parse(uri.pathSegments[1]);

        if (uri.pathSegments.first == 'astecas') {
          pagina = AstecaDetalheView(id: id);
        } else if (uri.pathSegments.first == 'pedidos') {
          pagina = PedidoDetalheView(id: id);
        }
      }
    } else {
      return MaterialPageRoute(builder: (context) => AuthenticateView());
    }
    return MaterialPageRoute(builder: (context) => HomeView(funcionalities: const FuncionalitiesView(), page: pagina));
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GPP - Gerenciamento de Peças e Pedidos',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Mada',
            inputDecorationTheme: const InputDecorationTheme(iconColor: Colors.grey)),
        onGenerateRoute: (settings) {
          // Handle '/'
          //return MaterialPageRoute(builder: (context) => Scaffold(body: AstecaListView()));

          return obterRota(settings);
        });
  }
}
