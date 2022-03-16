import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/menu_filial/filial_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/models/menu_filial/empresa_filial_model.dart';
import 'package:gpp/src/models/menu_filial/filial_model.dart';
import 'package:gpp/src/models/user_model.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:gpp/src/shared/services/auth.dart';

class AppBarView extends StatefulWidget {
  const AppBarView({Key? key}) : super(key: key);

  @override
  State<AppBarView> createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  final ResponsiveController _responsive = ResponsiveController();

  FilialController _filialController = FilialController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (getFilial().id_filial == null) {
      setFilial(
          filial: EmpresaFilialModel(
        id_empresa: 1,
        id_filial: 500,
        filial: FilialModel(id_filial: 500, sigla: 'DP/ASTEC'),
      ));
    }
  }

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
        Text(
          'Filial',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
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
                  width: 150,
                  // height: 40,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: DropdownSearch<EmpresaFilialModel?>(
                    mode: Mode.MENU,
                    showSearchBox: true,
                    items: snapshot.data,
                    itemAsString: (EmpresaFilialModel? value) => value!.id_filial!.toString(),
                    onChanged: (value) {
                      setFilial(filial: value);
                    },
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0), // borda branca quando clica
                          // borderRadius: BorderRadius.circular(25.0),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0), // borda branca quando clica
                        ),
                        labelText: 'Pesquisar',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownBuilder: (context, value) {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${value!.id_filial}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    popupItemBuilder: (context, value, verdadeiro) {
                      return Column(
                        children: [
                          Text(
                            "${value!.id_filial}",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 5, top: 5)),
                        ],
                      );
                    },
                    dropdownSearchDecoration: InputDecoration(
                      fillColor: primaryColor, // Cor fundo caixa dropdown
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0), // borda branca quando clica
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0), // borda branca quando clica
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      // labelText: 'Filial',
                      // labelStyle: TextStyle(color: Colors.white),
                    ),
                    dropDownButton: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: Colors.white,
                    ),
                    popupBackgroundColor: primaryColor, // Cor de fundo para caixa de seleção
                    showAsSuffixIcons: true,
                    selectedItem: getFilial(),
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
