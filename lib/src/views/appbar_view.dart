import 'package:flutter/material.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
class AppBarView extends StatelessWidget {
  final ResponsiveController _responsive = ResponsiveController();
  AppBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget page = LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if (_responsive.isMobile(constraints.maxWidth)) {
        return Container(
          color: primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                    GestureDetector(
                      child: Text(
                        'gpp',
                        style: textStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    //   handleLogout(context);
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white, //The color which you want set.
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Text(
                  'gpp',
                  style: textStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          ),
        ),
      );
    });

    return page;
  }
}
