class EstatisticaTotalConsumidaMes {
  final String mesAno;
  final int totalConsumido;

  EstatisticaTotalConsumidaMes({
    required this.mesAno,
    required this.totalConsumido,
  });

  /// Factory para criar a instância a partir de um JSON
  factory EstatisticaTotalConsumidaMes.fromJson(Map<String, dynamic> json) {
    return EstatisticaTotalConsumidaMes(
      mesAno: json['mes_ano'],
      totalConsumido: int.parse(json['total_Consumido']),
    );
  }

  /// Getter para retornar o nome do mês abreviado
  String get mesAbreviado {
    final meses = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez',
    ];
    final partes = mesAno.split('-');
    final mesIndex = int.parse(partes[1]) - 1;
    return meses[mesIndex];
  }
}
