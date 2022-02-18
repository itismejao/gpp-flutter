import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';
import 'package:gpp/src/shared/components/TitleComponent.dart';

class PedidoView extends StatefulWidget {
  const PedidoView({Key? key}) : super(key: key);

  @override
  _PedidoViewState createState() => _PedidoViewState();
}

class _PedidoViewState extends State<PedidoView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.list_alt_rounded,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const TitleComponent('Pedidos')
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextComponent('ID'),
                ),
                Expanded(
                  child: TextComponent('Nome'),
                ),
                Expanded(
                  child: TextComponent('CPF/CNPJ'),
                ),
                Expanded(
                  child: TextComponent('Data de emissão'),
                ),
                Expanded(
                  child: TextComponent('Status'),
                ),
                Expanded(
                  child: TextComponent('Valor total R\$'),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            SizedBox(
              height: media.size.height * 0.90,
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    color:
                        (index % 2) == 0 ? Colors.white : Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextComponent('${index}'),
                          ),
                          Expanded(
                            child:
                                TextComponent('Pietro Gustavo Elias da Rocha'),
                          ),
                          Expanded(
                            child: TextComponent('CPF/CNPJ'),
                          ),
                          Expanded(
                            child: TextComponent('12/04/1922'),
                          ),
                          Expanded(
                            child: TextComponent(
                              'Em aberto',
                              color: Colors.green,
                            ),
                          ),
                          Expanded(
                            child: TextComponent('45,88'),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
