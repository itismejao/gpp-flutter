import 'package:flutter/material.dart';

class ButtonAcaoWidget extends StatelessWidget {
  final Function? detalhe;
  final Function? deletar;
  final Function? editar;

  const ButtonAcaoWidget({
    Key? key,
    this.detalhe,
    this.editar,
    this.deletar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          detalhe != null
              ? GestureDetector(
                  onTap: () {
                    detalhe!();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.visibility_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: 6,
          ),
          editar != null
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: 6,
          ),
          deletar != null
              ? GestureDetector(
                  onTap: () => deletar!(),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                )
              : Container(),
        ]);
  }
}
