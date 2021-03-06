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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:gpp/src/controllers/UserController.dart';

import 'package:gpp/src/models/subfuncionalities_model.dart';

import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/auth.dart';

import 'package:gpp/src/views/asteca/AstecaView.dart';
import 'package:gpp/src/views/autenticacao/AutenticacaoView.dart';
import 'package:gpp/src/views/departamentos/departament_list_view.dart';
import 'package:gpp/src/views/enderecamento/cadastro_piso_view.dart';
import 'package:gpp/src/views/entrada/menu_entrada_view.dart';
import 'package:gpp/src/views/estoque/estoque_consulta_view.dart';
import 'package:gpp/src/views/home/filial_view.dart';
import 'package:gpp/src/views/motivos_troca_pecas/motivos_troca_peca_list_view.dart';

import 'package:gpp/src/views/peca/views/PecasListView.dart';
import 'package:gpp/src/views/pecas/menu_cadastrar_view.dart';

import 'package:gpp/src/views/pecas/peca_enderecamento_detail_view.dart';

import 'package:gpp/src/views/pedido_entrada/PedidoEntradaDetalheView.dart';
import 'package:gpp/src/views/pedido_entrada/PedidoEntradaListView.dart';
import 'package:gpp/src/views/pedido_saida/PedidoSaidaDetalheView.dart';
import 'package:gpp/src/views/pedido_saida/PedidoSaidaListView.dart';
import 'package:gpp/src/views/produto/views/produto_detalhe_view.dart';
import 'package:gpp/src/views/produto/views/produto_view.dart';

import 'package:gpp/src/views/users/user_list_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await dotenv.load(fileName: "env");

  runApp(GppApp());
}

class GppApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GppAppState();
}

class _GppAppState extends State<GppApp> {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'GPP - Gerenciamento de Peças e Pedidos',
      home: HomePageView(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primaryColor,
          fontFamily: 'Mada',
          inputDecorationTheme: const InputDecorationTheme(
            iconColor: Colors.grey,
            floatingLabelStyle: TextStyle(color: Color.fromRGBO(4, 4, 145, 1)),
          )),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  navegar(settings) {
    var builder;

    Uri uri = Uri.parse(settings.name);

//Se existe 1 parâmetros da url
    if (uri.pathSegments.length == 0) {
      builder = (BuildContext context) => AstecaView();
    } else if (uri.pathSegments.length == 1) {
      if (uri.pathSegments.first == 'astecas') {
        builder = (BuildContext context) => AstecaView();
      } else if (uri.pathSegments.first == 'departamentos') {
        builder = (BuildContext context) => DepartamentoListView();
      } else if (uri.pathSegments.first == 'usuarios') {
        builder = (BuildContext context) => UsuarioListView();
      } else if (uri.pathSegments.first == 'motivos-defeitos') {
        builder = (BuildContext context) => MotivosTrocaPecasListView();
      } else if (uri.pathSegments.first == 'logout') {
        builder = (BuildContext context) => AutenticacaoView();
      } else if (uri.pathSegments.first == 'pecas-cadastrar') {
        builder = (BuildContext context) => MenuCadastrarView();
      } else if (uri.pathSegments.first == 'pecas-consultar') {
        builder = (BuildContext context) => PecasListView();
      } else if (uri.pathSegments.first == 'pecas-enderecamento') {
        builder = (BuildContext context) => PecaEnderecamentoDetailView();
      } else if (uri.pathSegments.first == 'enderecamentos') {
        builder = (BuildContext context) => CadastroPisoView();
      } else if (uri.pathSegments.first == 'pedidos-entrada') {
        builder = (BuildContext context) => PedidoEntradaListView();
      } else if (uri.pathSegments.first == 'pedidos-saida') {
        builder = (BuildContext context) => PedidoSaidaListView();
      } else if (uri.pathSegments.first == 'estoque-entrada') {
        builder = (BuildContext context) => MenuEntradaView();
      } else if (uri.pathSegments.first == 'estoque-consulta') {
        builder = (BuildContext context) => EstoqueConsultaView();
      } else if (uri.pathSegments.first == 'produtos') {
        builder = (BuildContext context) => ProdutoView();
      } else if (uri.pathSegments.first == 'logout') {
        builder = (BuildContext context) => AutenticacaoView();
        ;
      }

      //Se existe 2 parâmetros da url
    } else if (uri.pathSegments.length == 2) {
      var id = int.parse(uri.pathSegments[1]);
      if (uri.pathSegments.first == 'astecas') {
        //      builder = (BuildContext context) => AstecaDetalheView(id: id);
      } else if (uri.pathSegments.first == 'pedidos-saida') {
        builder = (BuildContext context) => PedidoSaidaDetalheView(id: id);
      } else if (uri.pathSegments.first == 'pedidos-entrada') {
        builder = (BuildContext context) => PedidoEntradaDetalheView(id: id);
      } else if (uri.pathSegments.first == 'produtos') {
        builder = (BuildContext context) => ProdutoDetalheView(id: id);
      }
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: TextComponent(
          'gpp',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 4),
            child: FilialView(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                  'https://as1.ftcdn.net/v2/jpg/01/71/25/36/1000_F_171253635_8svqUJc0BnLUtrUOP5yOMEwFwA8SZayX.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 32),
            child: Icon(Icons.notifications_rounded),
          )
        ],
      ),
      drawer: media.size.width < 700 ? const Sidebar() : null,
      body: Row(children: [
        media.size.width > 700 ? const Sidebar() : Container(),
        Expanded(
            flex: 5,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                  child: Navigator(
                    key: Get.nestedKey(1),
                    onGenerateRoute: (RouteSettings settings) {
                      return navegar(settings);
                    },
                  ),
                ),
              ),
            )),
      ]),
    );
  }
}

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  UsuarioController controller = UsuarioController();

  buscarFuncionalidades() async {
    await controller.buscarFuncionalidades('32');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    buscarFuncionalidades();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.funcionalities.length);
    return Container(
      width: 240,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: controller.funcionalities
                      .map((e) => ItemSideBar(
                          e.nome ?? '',
                          IconData(int.parse(e.icone!),
                              fontFamily: 'MaterialIcons'),
                          e.subFuncionalidades ?? []))
                      .toList(),
                ),
              ),
            ),
            FooterSidebar()
          ],
        ),
      ),
    );
  }
}

class FooterSidebar extends StatelessWidget {
  const FooterSidebar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
                height: 40,
                width: 40,
                color:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: Center(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextComponent(
                      '${getUsuario().nome!.split(' ').first[0].toUpperCase()}',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    TextComponent(
                      '${getUsuario().nome!.split(' ').last[0].toUpperCase()}',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ))),
          ),
          TextComponent(
            '${getUsuario().nome!.split(' ').first} ${getUsuario().nome!.split(' ').last}',
            fontWeight: FontWeight.bold,
          ),
          IconButton(
              onPressed: () => {
                    // Navigator.of(context, rootNavigator: true)
                    //     .pushReplacementNamed('/logout')
                    Get.to(AutenticacaoView())
                  },
              icon: Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}

class ItemSideBar extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<SubFuncionalidadeModel> subFuncionalidades;
  const ItemSideBar(
    this.label,
    this.icon,
    this.subFuncionalidades, {
    Key? key,
  }) : super(key: key);

  @override
  State<ItemSideBar> createState() => _ItemSideBarState();
}

class _ItemSideBarState extends State<ItemSideBar> {
  bool expandido = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: (() => setState(() {
                  expandido = !expandido;
                })),
            child: Container(
              child: Row(
                children: [
                  Icon(widget.icon),
                  SizedBox(
                    width: 8,
                  ),
                  TextComponent(
                    widget.label,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.20,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            height: expandido ? null : 0,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: widget.subFuncionalidades
                    .map((e) => SubItemSidebar(e.nome ?? '', e.rota ?? ''))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubItemSidebar extends StatefulWidget {
  final String label;
  final String rota;
  const SubItemSidebar(
    this.label,
    this.rota, {
    Key? key,
  }) : super(key: key);

  @override
  State<SubItemSidebar> createState() => _SubItemSidebarState();
}

class _SubItemSidebarState extends State<SubItemSidebar> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.keys[1]!.currentState!.pushNamed(widget.rota),
      child: MouseRegion(
        onHover: (value) => setState(() {
          onHover = true;
        }),
        onExit: (value) => setState(() {
          onHover = false;
        }),
        child: Container(
          decoration: BoxDecoration(
              color: onHover ? Colors.grey.shade200 : Colors.transparent,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
            child: Row(
              children: [
                TextComponent(widget.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
