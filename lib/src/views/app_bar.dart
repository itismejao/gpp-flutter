import 'package:flutter/material.dart';
import 'package:gpp/src/shared/repositories/global.dart';
import 'package:gpp/src/shared/repositories/navigator_routes.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class AppBarView extends StatelessWidget {
  const AppBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'GPP',
              style: textStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.white, //The color which you want set.
                ),
                SizedBox(
                  width: 12,
                ),
                Icon(
                  Icons.settings,
                  color: Colors.white, //The color which you want set.
                ),
                SizedBox(
                  width: 24,
                ),
                SizedBox(
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
                              'https://picsum.photos/250?image=9'),
                        )),
                    SizedBox(
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
                SizedBox(
                  width: 24,
                ),
                GestureDetector(
                  onTap: () {
                    NavigatorRoutes.pushNamed(context, '/login');
                  },
                  child: Icon(
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
  }
}
