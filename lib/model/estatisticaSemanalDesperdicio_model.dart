class EstatisticaSemanalDesperdicio {
  final String diaSemana;
  final double mediaDesperdicio;

  EstatisticaSemanalDesperdicio({
    required this.diaSemana,
    required this.mediaDesperdicio,
  });

  factory EstatisticaSemanalDesperdicio.fromJson(Map<String, dynamic> json) {
    return EstatisticaSemanalDesperdicio(
      diaSemana: json['dia_semana'],
      mediaDesperdicio: double.parse(json['media_desperdicio']),
    );
  }
}
