import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/funcionalities_controller.dart';
import 'package:gpp/src/models/funcionalitie_model.dart';
import 'package:gpp/src/repositories/funcionalities_repository.dart';
import 'package:gpp/src/shared/enumeration/funcionalities_enum.dart';
import 'package:gpp/src/shared/repositories/styles.dart';
import 'package:collection/collection.dart';
import 'package:shimmer/shimmer.dart';

class FuncionalitiesView extends StatefulWidget {
  const FuncionalitiesView({Key? key}) : super(key: key);

  @override
  _FuncionalitiesViewState createState() => _FuncionalitiesViewState();
}

class _FuncionalitiesViewState extends State<FuncionalitiesView> {
  late final FuncionalitiesController _controller =
      FuncionalitiesController(FuncionalitiesRepository());

  final ScrollController controller = ScrollController();

  SizedBox loadingLayout(count) {
    return SizedBox(
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Column(
            children: [
              for (var i = 0; i < count; i++)
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      color: backgroundColor,
                      height: 50,
                    ),
                  ],
                ),
            ],
          )),
    );
  }

  funcionalities(MediaQueryData mediaQuery) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Form(
                      child: TextFormField(
                          onChanged: (value) {
                            _controller.search(value);
                          },
                          style: const TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              height: 1.8,
                              fontSize: 14),
                          decoration: inputDecoration(
                              'Buscar', const Icon(Icons.search)))),
                ),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        const SizedBox(
          height: 12,
        ),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            _controller.funcionalitiesSearch.isNotEmpty
                                ? _buildListFuncionalities(
                                    _controller.funcionalitiesSearch,
                                    mediaQuery)
                                : _buildListFuncionalities(
                                    _controller.funcionalities, mediaQuery)
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  ExpansionPanelList _buildListFuncionalities(
      List<FuncionalitieModel> funcionalities, MediaQueryData mediaQuery) {
    return ExpansionPanelList(
        elevation: 0,
        dividerColor: Colors.white,
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            funcionalities[index].isExpanded =
                !funcionalities[index].isExpanded;
          });
        },
        children:
            funcionalities.mapIndexed<ExpansionPanel>((index1, funcionalities) {
          return ExpansionPanel(
            backgroundColor: Colors.white,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.account_box,
                      color: Colors.grey.shade400,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(funcionalities.name,
                        textScaleFactor: mediaQuery.textScaleFactor,
                        style: textStyle(
                            fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: funcionalities.subFuncionalities
                  .mapIndexed((index2, subFuncionalities) {
                return Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: MouseRegion(
                    onHover: (event) {
                      setState(() {
                        //set hover
                        _controller
                            .funcionalities[index1]
                            .subFuncionalities[index2]
                            .colorButton = Colors.grey.shade50;

                        // set border

                        _controller.funcionalities[index1]
                                .subFuncionalities[index2].border =
                            Border(
                                left:
                                    BorderSide(color: primaryColor, width: 4));
                      });
                    },
                    onExit: (event) {
                      setState(() {
                        //set hover
                        _controller
                            .funcionalities[index1]
                            .subFuncionalities[index2]
                            .colorButton = Colors.white;

                        //set border

                        _controller.funcionalities[index1]
                                .subFuncionalities[index2].border =
                            Border(
                                left: BorderSide(
                                    color: Colors.grey.shade200, width: 2));
                      });
                    },
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: subFuncionalities.colorButton,
                                border: subFuncionalities.border),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: secundaryColor,
                                    size: 24.0,
                                    semanticLabel:
                                        'Text to announce in accessibility modes',
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(subFuncionalities.name!,
                                      style: textStyle(
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            isExpanded: _controller.funcionalities[index1].isExpanded,
          );
        }).toList());
  }

  stateManagement(value, MediaQueryData mediaQuery) {
    switch (value) {
      case FuncionalitiesEnum.loading:
        return const ShimmerWidget();

      case FuncionalitiesEnum.changeFuncionalities:
        return funcionalities(mediaQuery);
      default:
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    _controller.changeFuncionalities();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return AnimatedBuilder(
        animation: _controller.state,
        builder: (context, child) {
          return stateManagement(_controller.state.value, mediaQuery);
        });
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double containerWidth = mediaQuery.size.width * 0.12;
    double containerHeight = 10.0;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      itemCount: 15,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: mediaQuery.size.height * 0.02,
                  width: mediaQuery.size.width * 0.03,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: containerHeight,
                      width: containerWidth,
                      color: Colors.grey,
                    ),
                    //SizedBox(height: 5.0),
                    // Container(
                    //   height: containerHeight,
                    //   width: containerWidth,
                    //   color: Colors.grey,
                    // ),
                    // SizedBox(height: 5.0),
                    // Container(
                    //   height: containerHeight,
                    //   width: containerWidth * 0.75,
                    //   color: Colors.grey,
                    // ),
                    // SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
