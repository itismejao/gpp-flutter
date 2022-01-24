import 'package:flutter/material.dart';
import 'package:gpp/src/controllers/asteca_controller.dart';
import 'package:gpp/src/controllers/responsive_controller.dart';
import 'package:gpp/src/shared/components/SubTitle1Component.dart';
import 'package:gpp/src/shared/components/button_primary_component.dart';
import 'package:gpp/src/shared/components/checkbox_component.dart';
import 'package:gpp/src/shared/components/h6Component.dart';
import 'package:gpp/src/shared/components/input_component.dart';
import 'package:gpp/src/shared/repositories/styles.dart';

class AstecaDetailView extends StatefulWidget {
  const AstecaDetailView({Key? key}) : super(key: key);

  @override
  _AstecaDetailViewState createState() => _AstecaDetailViewState();
}

class _AstecaDetailViewState extends State<AstecaDetailView> {
  late AstecaController _controller;
  late ResponsiveController _responsive;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = AstecaController();
    _responsive = ResponsiveController();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;

    if (_responsive.isMobile(media.width)) {
      return Scaffold(
        body: Container(
            child: Column(
          children: [
            Container(
              height: media.height * 0.10,
              child: _buildAstecaMenu(media),
            ),
            Container(
              height: media.height * 0.90,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAstecaNavigator(media),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _controller.step > 1
                              ? ButtonPrimaryComponent(
                                  color: primaryColor,
                                  onPressed: () {
                                    setState(() {
                                      _controller.step--;
                                    });
                                  },
                                  text: 'Voltar')
                              : Container(),
                          Row(
                            children: [
                              _controller.step != 4
                                  ? ButtonPrimaryComponent(
                                      color: primaryColor,
                                      onPressed: () {
                                        setState(() {
                                          _controller.step++;
                                        });
                                      },
                                      text: 'Avançar')
                                  : Container(),
                              SizedBox(
                                width: 10,
                              ),
                              ButtonPrimaryComponent(
                                  color: secundaryColor,
                                  icon: Icon(Icons.save, color: Colors.white),
                                  onPressed: () {},
                                  text: 'Salvar')
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: Container(child: _buildAstecaMenu(media))),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  _buildAstecaNavigator(media),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _controller.step > 1
                            ? ButtonPrimaryComponent(
                                color: primaryColor,
                                onPressed: () {
                                  setState(() {
                                    _controller.step--;
                                  });
                                },
                                text: 'Voltar')
                            : Container(),
                        Row(
                          children: [
                            _controller.step != 4
                                ? ButtonPrimaryComponent(
                                    color: primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        _controller.step++;
                                      });
                                    },
                                    text: 'Avançar')
                                : Container(),
                            SizedBox(
                              width: 10,
                            ),
                            ButtonPrimaryComponent(
                                color: secundaryColor,
                                icon: Icon(Icons.save, color: Colors.white),
                                onPressed: () {},
                                text: 'Salvar')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }
  }

  _buildAstecaMenu(Size media) {
    if (_responsive.isMobile(media.width)) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 1;
                });
              },
              child: Container(
                color: _controller.step == 1 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Asteca',
                        style: TextStyle(
                            color: _controller.step == 1
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 2;
                });
              },
              child: Container(
                color: _controller.step == 2 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Endereço',
                        style: TextStyle(
                            color: _controller.step == 2
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 3;
                });
              },
              child: Container(
                color: _controller.step == 3 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Produto',
                        style: TextStyle(
                            color: _controller.step == 3
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.step = 4;
                });
              },
              child: Container(
                color: _controller.step == 4 ? Colors.white : primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Peças',
                        style: TextStyle(
                            color: _controller.step == 4
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.20),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Text(
            'Asteca',
            style: TextStyle(
                letterSpacing: 0.15, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.step = 1;
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12),
                        child: Text(
                          'Asteca',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.step = 2;
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12),
                        child: Text(
                          'Endereço',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.step = 3;
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12),
                        child: Text(
                          'Produto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.step = 4;
                  });
                },
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12),
                        child: Text(
                          'Peças',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 0.20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildAstecaInformation(Size media) {
    if (_responsive.isMobile(media.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Asteca',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nº Asteca',
                initialValue: '38135',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'CPF/CNPJ',
                initialValue: '001.463.861-40',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nº Fiscal',
                initialValue: '38135',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial de saída',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Tipo',
                initialValue: 'Cliente',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nome',
                initialValue: 'Maria Angela Rocha da Fonseca',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Série',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial venda',
                initialValue: '10',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Data de abertura',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Data de compra',
                initialValue: '30/06/2021',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Filial Asteca',
                initialValue: '500',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.badge,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Funcionário(a)',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'RE',
                initialValue: '1032445',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Nome',
                initialValue: 'Kesley Alves de Oliveira',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.build,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Defeito ou motivo',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Defeito',
                initialValue: 'enviar 30 unidades de adesivos/ tapas furos',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Motivo',
                initialValue: 'defeito de fabricação',
              ),
            ),
            Container(
              child: InputComponent(
                label: 'Observação',
                initialValue:
                    'Solicitado pelo técnico, enviar 30 unidades de adesivos/ tapa furos.',
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.description,
                  size: 32,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Asteca',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InputComponent(
                    label: 'Nº Asteca',
                    initialValue: '38135',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 2,
                  child: InputComponent(
                    label: 'CPF/CNPJ',
                    initialValue: '001.463.861-40',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 2,
                  child: InputComponent(
                    label: 'Nome',
                    initialValue: 'Maria Angela Rocha da Fonseca',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InputComponent(
                    label: 'Nº Fiscal',
                    initialValue: '38135',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Série',
                    initialValue: '10',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Filial de saída',
                    initialValue: '10',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Filial venda',
                    initialValue: '10',
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InputComponent(
                    label: 'Tipo',
                    initialValue: 'Cliente',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Data de abertura',
                    initialValue: '30/06/2021',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Data de compra',
                    initialValue: '30/06/2021',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: InputComponent(
                    label: 'Filial Asteca',
                    initialValue: '500',
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.badge,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Funcionário(a)',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InputComponent(
                    label: 'RE',
                    initialValue: '1032445',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 2,
                  child: InputComponent(
                    label: 'Nome',
                    initialValue: 'Kesley Alves de Oliveira',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.build,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Defeito ou motivo',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: InputComponent(
                    label: 'Defeito',
                    initialValue: 'enviar 30 unidades de adesivos/ tapas furos',
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 2,
                  child: InputComponent(
                    label: 'Motivo',
                    initialValue: 'defeito de fabricação',
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: InputComponent(
              label: 'Observação',
              initialValue:
                  'Solicitado pelo técnico, enviar 30 unidades de adesivos/ tapa furos.',
            ),
          ),
        ],
      ),
    );
  }

  _buildAstecaAndress(Size media) {
    if (_responsive.isMobile(media.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Endereço',
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Logradouro',
                  initialValue:
                      'Avenida Perimental Norte NR 1 AP 1903  Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Complemento',
                  initialValue: 'AP 1903 Torre Itaparica',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Bairro',
                  initialValue: 'Setor Candida de Morais',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Referência',
                  initialValue: 'Cond. Borges Landeiro',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Número',
                  initialValue: '01',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Cidade',
                  initialValue: ' Goiânia',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Estado',
                  initialValue: 'GO',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Contato',
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Telefone',
                  initialValue: '(62) 99999-9999',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Endereço',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'Logradouro',
                      initialValue:
                          'Avenida Perimental Norte NR 1 AP 1903  Torre Itaparica',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'Complemento',
                      initialValue: 'AP 1903 Torre Itaparica',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'Número',
                      initialValue: '01',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'Bairro',
                      initialValue: 'Setor Candida de Morais',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'Cidade',
                      initialValue: ' Goiânia',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'Estado',
                      initialValue: 'GO',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Referência',
                initialValue: 'Cond. Borges Landeiro',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.call,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Contato',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: InputComponent(
                label: 'Telefone',
                initialValue: '(62) 99999-9999',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAstecaProduct(Size media) {
    if (_responsive.isMobile(media.width)) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 32,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Produto',
                      style: TextStyle(
                          letterSpacing: 0.15,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'ID',
                  initialValue: '121245',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Nome',
                  initialValue: 'Coz Jazz 3 Pçs IPLDA IP2 IPH1G BEGE',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'LD',
                  initialValue: '02',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Fornecedor',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'ID',
                  initialValue: '4545',
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: InputComponent(
                  label: 'Nome',
                  initialValue: 'Itatiaia',
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_bag,
                    size: 32,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Produto',
                    style: TextStyle(
                        letterSpacing: 0.15,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'ID',
                      initialValue: '121245',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 2,
                    child: InputComponent(
                      label: 'Nome',
                      initialValue: 'Coz Jazz 3 Pçs IPLDA IP2 IPH1G BEGE',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'LD',
                      initialValue: '02',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Fornecedor',
                style: TextStyle(
                    letterSpacing: 0.15,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'ID',
                      initialValue: '4545',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    flex: 2,
                    child: InputComponent(
                      label: 'Nome',
                      initialValue: 'Fabricante',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputComponent(
                      label: 'LD',
                      initialValue: '02',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAstecaNavigator(media) {
    switch (_controller.step) {
      case 1:
        return _buildAstecaInformation(media);

      case 2:
        return _buildAstecaAndress(media);

      case 3:
        return _buildAstecaProduct(media);
      case 4:
        return _buildAstecaParts(media);
    }
  }

  _buildAstecaParts(media) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  size: 32,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Peças',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: 'Buscar',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'ID',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(
                  'Nome',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Estoque disponível',
                  style: TextStyle(
                      letterSpacing: 0.15,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: CheckboxComponent())
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Divider(),
          ),
          Container(
            height: media.height * 0.60,
            child: ListView.builder(
                controller: ScrollController(),
                itemCount: 40,
                itemBuilder: (context, index) {
                  return Container(
                    color:
                        (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '0001',
                            style: TextStyle(
                              letterSpacing: 0.15,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Porta Esq.',
                            style: TextStyle(
                              letterSpacing: 0.15,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '47',
                            style: TextStyle(
                              letterSpacing: 0.15,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(child: CheckboxComponent())
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
