import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/menu_filial/filial_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

// ignore: must_be_immutable
class AppBarView extends StatelessWidget {
  final ResponsiveController _responsive = ResponsiveController();
  AppBarView({
    Key? key,
  }) : super(key: key);

  FilialController _filialController = FilialController();

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
    return Row(
      children: [
        // Text(
        //   'Filial',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // Padding(padding: EdgeInsets.only(right: 20)),
        FutureBuilder(
          future: _filialController.buscarTodos(),
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
                  width: 200,
                  height: 40,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: DropdownSearch<EmpresaFilialModel?>(
                    mode: Mode.MENU,
                    showSearchBox: true,
                    items: snapshot.data,
                    itemAsString: (EmpresaFilialModel? value) {
                      return value!.id_filial!.toString();
                    },
                    popupItemBuilder: (context, value, verdadeiro) {
                      return Text(
                        "${value!.id_filial.toString()}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      );
                    },
                    onChanged: (value) {
                      // txtIdMaterial.text = value!.id_peca_material_fabricacao.toString();

                      // _pecasController.pecasModel.id_peca_material_fabricacao =
                      // value.id_peca_material_fabricacao.toString();
                    },
                    dropdownSearchDecoration: InputDecoration(
                      fillColor: primaryColor, // Cor fundo caixa dropdown
                      filled: true,
                      // border: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.white, width: 2.0),
                      //   borderRadius: BorderRadius.circular(25.0),
                      // ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0), // borda branca quando clica
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'Filial',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    dropDownButton: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    popupBackgroundColor: primaryColor, // Cor de fundo para caixa de seleção
                    showAsSuffixIcons: true,
                    selectedItem: FilialController.selectedFilial,
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
