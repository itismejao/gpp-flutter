import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/menu_filial/menu_filial_controller.dart';
import 'package:gpp/src/controllers/pecas_controller/pecas_linha_controller.dart';

import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/models/pecas_model/pecas_linha_model.dart';

import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
class AppBarView extends StatelessWidget {
  final ResponsiveController _responsive = ResponsiveController();
  AppBarView({
    Key? key,
  }) : super(key: key);

  MenuFilialController _menuFilialController = MenuFilialController();
  PecasLinhaController _pecasLinhaController = PecasLinhaController();

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
              ),
              filial(context),
            ],
          ),
        ),
      );
    });

    return page;
  }

  filial(BuildContext context) {
    return Column(
      children: [
        Text('Filial'),
        FutureBuilder(
          future: _menuFilialController.buscarTodos(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Sem conexão');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                print(snapshot.data);
                return Container(
                  child: Flexible(
                    flex: 5,
                    child: Container(
                      width: 600,
                      height: 48,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownSearch<EmpresaFilialModel?>(
                        mode: Mode.MENU,
                        showSearchBox: true,
                        items: snapshot.data,
                        itemAsString: (EmpresaFilialModel? value) => value!.id_filial!.toString(),
                        onChanged: (value) {
                          // txtIdMaterial.text = value!.id_peca_material_fabricacao.toString();

                          // _pecasController.pecasModel.id_peca_material_fabricacao =
                          // value.id_peca_material_fabricacao.toString();
                        },
                        dropdownSearchDecoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                        ),
                        dropDownButton: Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black,
                        ),
                        showAsSuffixIcons: true,
                      ),
                    ),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
