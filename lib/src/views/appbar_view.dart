import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/shared/repositories/global.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
class AppBarView extends StatelessWidget {
  final ResponsiveController _responsive = ResponsiveController();
  AppBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget page = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (_responsive.isMobile(constraints.maxWidth)) {
        return Container(
          color: primaryColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
                    Text(
                      'gpp',
                      style: textStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
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
              Text(
                'gpp',
                style: textStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.white, //The color which you want set.
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.white, //The color which you want set.
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  const SizedBox(
                    width: 48,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                                'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png'),
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Olá, ' + authenticateUser!.name.toString(),
                        style: textStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white, //The color which you want set.
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });

    return page;
  }
}
