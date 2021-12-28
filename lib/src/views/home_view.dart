import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/views/appbar_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/user_view.dart';

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        height: 1000,
                        child: Navigator(
                          onGenerateRoute: (settings) {
                            var route = settings.name;
                            Widget page;
                            switch (route) {
                              case '/users':
                                page = const UserView();
                                break;
                              case '/user_detail':
                                final user = settings.arguments as UserModel;

                                page = UserDetailView(user: user);
                                break;
                              default:
                                page = const UserView();
                            }

                            return MaterialPageRoute(
                                builder: (context) => page, settings: settings);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
          child: AppBarView(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: Colors.white,
                        height: 1000,
                        child: const FuncionalitiesView()),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.white,
                      height: 1000,
                      child: Navigator(
                        onGenerateRoute: (settings) {
                          var route = settings.name;
                          Widget page;
                          switch (route) {
                            case '/users':
                              page = const UserView();
                              break;
                            case '/user_detail':
                              final user = settings.arguments as UserModel;

                              page = UserDetailView(user: user);
                              break;
                            default:
                              page = const UserView();
                          }

                          return MaterialPageRoute(
                              builder: (context) => page, settings: settings);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });

    return page;
  }
}
