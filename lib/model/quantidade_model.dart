class QuantidadeModel {
  int? quantidade;

  QuantidadeModel();

  QuantidadeModel.fromJson(Map<String, dynamic> json) {
    quantidade = json['quantidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantidade'] = quantidade;
    return data;
  }
}
