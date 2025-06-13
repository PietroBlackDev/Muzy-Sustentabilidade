class EstatisticaMediaConsumidaRefeicao {
  final String tipoRefeicao;
  final double mediaConsumida;

  EstatisticaMediaConsumidaRefeicao({
    required this.tipoRefeicao,
    required this.mediaConsumida,
  });

  factory EstatisticaMediaConsumidaRefeicao.fromJson(
    Map<String, dynamic> json,
  ) {
    return EstatisticaMediaConsumidaRefeicao(
      tipoRefeicao: json['TipoRefeicao'],
      mediaConsumida: double.parse(json['media_Consumida']),
    );
  }
}
