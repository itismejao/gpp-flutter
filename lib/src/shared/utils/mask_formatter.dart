import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter {
  cpfInputFormmater(String? value) {
    return MaskTextInputFormatter(
      initialText: value.toString(),
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  cnpjInputFormmater(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '##.###.###/####-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter telefoneInputFormmater(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter cepInputFormmater(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter realInputFormmater(String? value) {
    return MaskTextInputFormatter(
      initialText: value,
      mask: '##.###,###,###',
    );
  }
}
