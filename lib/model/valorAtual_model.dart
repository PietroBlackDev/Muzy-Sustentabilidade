class ValorAtualModel {
  int? valor;

  ValorAtualModel();

  ValorAtualModel.fromJson(Map<String, dynamic> json) {
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valor'] = valor;
    return data;
  }
}
