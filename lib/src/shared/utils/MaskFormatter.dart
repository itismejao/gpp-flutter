import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter {
  MaskTextInputFormatter? cpfCnpjFormatter({String? value}) {
    if (value!.length == 11) {
      return cpfFormatter(value: value);
    } else if (value.length == 14) {
      return cnpjFormatter(value: value);
    }
    return null;
  }

  cpfFormatter({String? value}) {
    return MaskTextInputFormatter(
      initialText: value.toString(),
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter dataFormatter({String? value}) {
    return MaskTextInputFormatter(
      initialText: value.toString(),
      mask: '##/##/####',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  cnpjFormatter({String? value}) {
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
