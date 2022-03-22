import 'package:flutter/material.dart';
import 'package:gpp/src/shared/components/TextComponent.dart';

class PaginacaoComponent extends StatelessWidget {
  final Function primeiraPagina;
  final Function anteriorPagina;
  final Function proximaPagina;

  final Function ultimaPagina;
  final int total;
  final int atual;
  const PaginacaoComponent({
    Key? key,
    required this.primeiraPagina,
    required this.anteriorPagina,
    required this.proximaPagina,
    required this.ultimaPagina,
    required this.total,
    required this.atual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextComponent('Total de páginas: ${total}'),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.first_page),
                onPressed: () => primeiraPagina()),
            IconButton(
                icon: const Icon(
                  Icons.navigate_before_rounded,
                  color: Colors.black,
                ),
                onPressed: () => primeiraPagina()),
            TextComponent('${atual}'),
            IconButton(
                icon: Icon(Icons.navigate_next_rounded),
                onPressed: () => proximaPagina()),
            IconButton(
                icon: Icon(Icons.last_page), onPressed: () => ultimaPagina()),
          ],
        )
      ],
    );
  }
}
