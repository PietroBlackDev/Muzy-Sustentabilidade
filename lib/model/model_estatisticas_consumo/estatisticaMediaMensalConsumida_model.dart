class EstatisticaMensalConsumida {
  final String mes;
  final double qntdeComidaConsumida;

  EstatisticaMensalConsumida({
    required this.mes,
    required this.qntdeComidaConsumida,
  });

  factory EstatisticaMensalConsumida.fromJson(Map<String, dynamic> json) {
    return EstatisticaMensalConsumida(
      mes: json['Mes'],
      qntdeComidaConsumida: double.parse(json['QntdeComidaConsumida']),
    );
  }

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
    final partes = mes.split('-');
    final mesIndex = int.parse(partes[0]) - 1;
    return meses[mesIndex];
  }
}
