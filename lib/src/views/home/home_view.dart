import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/views/appbar_view.dart';
import 'package:gpp/src/views/funcionalities_view.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  Widget funcionalities;
  Widget? page;
  final ResponsiveController _responsive = ResponsiveController();
  HomeView({
    Key? key,
    required this.funcionalities,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Widget home;
    if (page == null) {
      home = LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (_responsive.isMobile(constraints.maxWidth) ||
            _responsive.isTable(constraints.maxWidth)) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
              child: AppBarView(),
            ),
            drawer: Container(
                color: Colors.white,
                width: mediaQuery.size.width * 0.70,
                child: FuncionalitiesView()),
            backgroundColor: Colors.white,
            body: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Gerenciamento de peças e Pedidos",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Divider(),
                            Image.network(
                                'https://thumbs.dreamstime.com/b/ilustra%C3%A7%C3%A3o-da-constru%C3%A7%C3%A3o-de-sistema-115562214.jpg')
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        }

        return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
              child: AppBarView(),
            ),
            backgroundColor: Colors.white,
            body: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(child: funcionalities),
                    Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: Row(
                                children: [
                                  Text(
                                    "Gerenciamento de peças e Pedidos",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Image.network(
                                'https://thumbs.dreamstime.com/b/ilustra%C3%A7%C3%A3o-da-constru%C3%A7%C3%A3o-de-sistema-115562214.jpg')
                          ],
                        ))
                  ],
                ),
              ),
            ));
      });
    } else {
      home = LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (_responsive.isMobile(constraints.maxWidth) ||
            _responsive.isTable(constraints.maxWidth)) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
              child: AppBarView(),
            ),
            drawer: Container(
                color: Colors.white,
                width: mediaQuery.size.width * 0.70,
                child: FuncionalitiesView()),
            backgroundColor: Colors.white,
            body: Container(
              child: Row(
                children: [Expanded(flex: 4, child: page!)],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
            child: AppBarView(),
          ),
          backgroundColor: Colors.grey.shade100,
          body: Container(
            child: Row(
              children: [
                Expanded(child: funcionalities),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: mediaQuery.size.height * 0.95,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [page!],
                              ),
                            ),
                          )),
                    ))
              ],
            ),
          ),
        );
      });
    }
    return Scaffold(body: SafeArea(child: home));

    //Página inicial
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: Size.fromHeight(mediaQuery.size.height * 0.10),
    //     child: AppBarView(),
    //   ),
    //   backgroundColor: Colors.white,
    //   body: home,
    // );
  }
}
