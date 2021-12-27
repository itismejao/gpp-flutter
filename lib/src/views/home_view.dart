import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/app_bar.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:gpp/src/views/user_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: primaryColor, title: const Text('GPP')),
              drawer: const Drawer(
                  child:
                      FuncionalitiesView() // Populate the Drawer in the next step.
                  ),
              body: Container(
                color: backgroundColor,
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: AppBarView(),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                            height: mediaQuery.size.height * 0.90,
                            child: FuncionalitiesView()),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            child: SizedBox(
                                height: mediaQuery.size.height * 0.85,
                                child: UserView()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );

        // return Scaffold(
        //   body: Row(
        //     children: [
        //       const Expanded(child: FuncionalitiesView()),
        //       Expanded(
        //           flex: 4,
        //           child: Container(
        //             color: backgroundColor,
        //             child: Column(
        //               children: [
        //                 Container(
        //                   child: Row(
        //                     children: [Text('ss')],
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ))
        //     ],
        //   ),
        // );
      },
    );
  }
}
