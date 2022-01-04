import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/departament_model.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/not_found/repositories/not_found.dart';
import 'package:gpp/src/views/appbar_view.dart';
import 'package:gpp/src/views/departament_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_form_create_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_form_update_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_home_view.dart';
import 'package:gpp/src/views/funcionalities/funcionalities_list_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/user_view.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ResponsiveController _responsive = ResponsiveController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    Widget page = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (_responsive.isMobile(constraints.maxWidth)) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
            child: AppBarView(),
          ),
          drawer: Container(
              color: Colors.white,
              width: mediaQuery.size.width * 0.70,
              child: const FuncionalitiesView()),
          body: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        child: _buildNavigator(mediaQuery),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
          child: AppBarView(),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.white, child: const FuncionalitiesView()),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildNavigator(mediaQuery),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });

    return page;
  }

  Container _buildNavigator(MediaQueryData mediaQuery) {
    return Container(
      color: Colors.white,
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (settings) {
          var route = settings.name;
          Widget page;
          switch (route) {
            case '/users':
              page = const UserView();
              break;
            case '/departaments':
              page = const DepartamentView();
              break;
            case '/departament_detail':
              final departament = settings.arguments as DepartamentModel;

              page = DepartamentDetailView(
                departament: departament,
              );
              break;
            case '/user_detail':
              final user = settings.arguments as UserModel;

              page = UserDetailView(user: user);
              break;
            case '/funcionalities':
              page = FuncionalitiesHomeView();
              break;
            case 'funcionalitie_list':
              page = FuncionalitiesView();
              break;
            case '/funcionalitie_update':
              final funcionalitie = settings.arguments as FuncionalitieModel;

              page = FuncionalitieFormUpdateView(funcionalitie: funcionalitie);
              break;
            case '/funcionalitie_create':
              page = FuncionalitieFormCreateView();
              break;
            default:
              page = FuncionalitiesHomeView();
          }

          return MaterialPageRoute(
              builder: (context) => page, settings: settings);
        },
      ),
    );
  }
}
