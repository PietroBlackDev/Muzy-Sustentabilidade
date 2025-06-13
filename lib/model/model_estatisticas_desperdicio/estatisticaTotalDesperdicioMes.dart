class EstatisticaTotalDesperdicioMes {
  final String mes;
  final int qntdeComidaDesperdicada;

  EstatisticaTotalDesperdicioMes({
    required this.mes,
    required this.qntdeComidaDesperdicada,
  });

  factory EstatisticaTotalDesperdicioMes.fromJson(Map<String, dynamic> json) {
    final mesAno = json['mes_ano'];
    final partes = mesAno.split('-');
    final mesNumero = int.parse(partes[1]);

    const nomesMeses = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];

    return EstatisticaTotalDesperdicioMes(
      mes: nomesMeses[mesNumero - 1],
      qntdeComidaDesperdicada: int.parse(json['total_desperdicio']),
    );
  }
}
