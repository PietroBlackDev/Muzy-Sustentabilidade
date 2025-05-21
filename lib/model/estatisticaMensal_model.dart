class EstatisticaMensal {
  final String mes;
  final double qntdeComidaDesperdicada;

  EstatisticaMensal({required this.mes, required this.qntdeComidaDesperdicada});

  factory EstatisticaMensal.fromJson(Map<String, dynamic> json) {
    return EstatisticaMensal(
      mes: nomeDoMes(json['Mes'].toString()),
      qntdeComidaDesperdicada: double.parse(json['QntdeComidaDesperdicada']),
    );
  }
}

String nomeDoMes(String numero) {
  const nomes = [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Maio',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez',
  ];
  int index = int.tryParse(numero) ?? 0;
  return (index >= 1 && index <= 12) ? nomes[index - 1] : numero;
}
