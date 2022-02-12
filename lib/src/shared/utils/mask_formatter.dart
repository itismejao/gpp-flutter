import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter {
  cpf(String? value) {
    return MaskTextInputFormatter(
      initialText: value.toString(),
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  cnpj(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter telefone(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter cep(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }
}
