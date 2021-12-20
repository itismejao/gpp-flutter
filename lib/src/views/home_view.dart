import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/views/funcionalities_view.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
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

        return Row(
          children: [
            const Expanded(child: FuncionalitiesView()),
            Expanded(
                flex: 4,
                child: Container(
                  color: backgroundColor,
                ))
          ],
        );
      },
    );
  }
}
