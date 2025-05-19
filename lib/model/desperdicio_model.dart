class DesperdicioModel {
  int? comidaProduzida;
  int? comidaDesperdicada;

  DesperdicioModel();

  DesperdicioModel.fromJson(Map<String, dynamic> json) {
    comidaProduzida = json['QntdeComidaProduzida'];
    comidaDesperdicada = json['QntdeComidaDesperdicada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['QntdeComidaProduzida'] = comidaProduzida;
    data['QntdeComidaDesperdicada'] = comidaDesperdicada;
    return data;
  }
}
