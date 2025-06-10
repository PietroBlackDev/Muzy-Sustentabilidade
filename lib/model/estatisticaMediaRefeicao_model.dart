class EstatisticaMediaRefeicao {
  final String tipoRefeicao;
  final double mediaDesperdicio;

  EstatisticaMediaRefeicao({
    required this.tipoRefeicao,
    required this.mediaDesperdicio,
  });

  factory EstatisticaMediaRefeicao.fromJson(Map<String, dynamic> json) {
    return EstatisticaMediaRefeicao(
      tipoRefeicao: json['TipoRefeicao'],
      mediaDesperdicio: double.parse(json['media_desperdicio']),
    );
  }
}
