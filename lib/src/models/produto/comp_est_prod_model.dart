import 'package:gpp/src/models/produto/produto_model.dart';

class CompEstProd {
  int? idCompEst;
  ProdutoModel? produto;

  CompEstProd({this.idCompEst, this.produto});

  factory CompEstProd.fromJson(Map<String, dynamic> json) {
    return CompEstProd(
        idCompEst: json['id_comp_est'] != null ? json['id_comp_est'] : null,
        produto: json['produto'] != null
            ? ProdutoModel.fromJson(json['produto'])
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_comp_est'] = this.idCompEst;
    data['produto'] = this.produto != null ? this.produto!.toJson() : null;
    return data;
  }
}
