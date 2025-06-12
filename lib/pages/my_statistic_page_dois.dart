import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tg/model/estatisticaMediaRefeicao_model.dart';
import 'package:tg/model/estatisticaMensal_model.dart';
import 'package:tg/model/estatisticaSemanalDesperdicio_model.dart';
import 'package:tg/model/estatisticaTotalDesperdicioMes.dart';

class MyStatisticPageDois extends StatefulWidget {
  const MyStatisticPageDois({super.key});
  @override
  State<MyStatisticPageDois> createState() => _MyStatisticPageDoisState();
}

class _MyStatisticPageDoisState extends State<MyStatisticPageDois> {
  Future<List<EstatisticaMensal>> fetchEstatisticas() async {
    final response = await http.get(
      Uri.parse('http://10.125.121.135:8081/CI4/public/api/estatisticas'),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => EstatisticaMensal.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar estatísticas');
    }
  }

  Future<List<EstatisticaSemanalDesperdicio>>
  fetchEstatisticasSemanalDesperdicio() async {
    final response = await http.get(
      Uri.parse(
        'http://10.125.121.135:8081/CI4/public/api/estatisticas/mediaSemanalDesperdicio',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => EstatisticaSemanalDesperdicio.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar estatísticas');
    }
  }

  Future<List<EstatisticaMediaRefeicao>> fetchEstatisticaMediaRefeicao() async {
    final response = await http.get(
      Uri.parse(
        'http://10.125.121.135:8081/CI4/public/api/estatisticas/mediaDesperdicioRefeicao',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => EstatisticaMediaRefeicao.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar estatísticas');
    }
  }

  Future<List<EstatisticaTotalDesperdicioMes>>
  fetchEstatisticasTotalDesperdicioMes() async {
    final response = await http.get(
      Uri.parse(
        'http://10.125.121.135:8081/CI4/public/api/estatisticas/totalDesperdicioMes',
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => EstatisticaTotalDesperdicioMes.fromJson(item))
          .toList();
    } else {
      throw Exception('Falha ao carregar estatísticas');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEstatisticas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.106,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset('assets/images/logosemfundo.png'),
        ),
        leadingWidth: 160,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 20,
            children: [
              SizedBox(height: 1),
              Text(
                'Estatisticas de desperdício por periodos',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: FutureBuilder<List<EstatisticaTotalDesperdicioMes>>(
                  future: fetchEstatisticasTotalDesperdicioMes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma estatística encontrada.'),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total de desperdicio de comida por mês',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SfCartesianChart(
                              backgroundColor: Colors.transparent,
                              primaryXAxis: CategoryAxis(
                                labelRotation: 60,
                                interval: 1,
                                majorGridLines: const MajorGridLines(width: 1),
                                labelStyle: const TextStyle(fontSize: 11),
                              ),
                              primaryYAxis: NumericAxis(
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(size: 0),
                                labelStyle: const TextStyle(fontSize: 11),
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom,
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              series: <CartesianSeries>[
                                LineSeries<
                                  EstatisticaTotalDesperdicioMes,
                                  String
                                >(
                                  name: 'Desperdício (kg)',
                                  dataSource: snapshot.data!,
                                  xValueMapper: (estat, _) => estat.mes,
                                  yValueMapper:
                                      (estat, _) =>
                                          estat.qntdeComidaDesperdicada,
                                  dataLabelSettings: const DataLabelSettings(
                                    labelAlignment: ChartDataLabelAlignment.top,
                                    isVisible: true,
                                    textStyle: TextStyle(fontSize: 8),
                                  ),
                                  markerSettings: const MarkerSettings(
                                    isVisible: true,
                                    width: 6,
                                    height: 6,
                                    shape: DataMarkerType.circle,
                                    borderColor: Colors.deepOrange,
                                    borderWidth: 2,
                                  ),
                                  color: Colors.deepOrange,
                                  width: 3,
                                  enableTooltip: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.4313,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: FutureBuilder<List<EstatisticaMensal>>(
                  future: fetchEstatisticas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Nenhuma estatística encontrada.'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Média diária de desperdicio de comida por mês',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                labelRotation: 60,
                                interval: 1,
                              ),

                              series: <CartesianSeries>[
                                LineSeries<EstatisticaMensal, String>(
                                  dataSource: snapshot.data!,
                                  xValueMapper: (estat, _) => estat.mes,
                                  yValueMapper:
                                      (estat, _) =>
                                          estat.qntdeComidaDesperdicada,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                  ),
                                  markerSettings: MarkerSettings(
                                    isVisible: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.43,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: FutureBuilder<List<EstatisticaMediaRefeicao>>(
                  future: fetchEstatisticaMediaRefeicao(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Nenhuma estatística encontrada.'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          left: 5,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Média diária de desperdício por tipo de refeição',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SfCircularChart(
                              legend: Legend(
                                isVisible: true,
                                isResponsive: true,
                                height: '100%',
                                iconHeight: 12,
                                iconWidth: 12,
                                overflowMode: LegendItemOverflowMode.wrap,
                              ),
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <CircularSeries>[
                                PieSeries<EstatisticaMediaRefeicao, String>(
                                  dataSource: snapshot.data!,
                                  xValueMapper:
                                      (estat, _) => estat.tipoRefeicao,
                                  yValueMapper:
                                      (estat, _) => estat.mediaDesperdicio,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.94,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.tertiary,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: FutureBuilder<List<EstatisticaSemanalDesperdicio>>(
                  future: fetchEstatisticasSemanalDesperdicio(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Nenhuma estatística encontrada.'),
                      );
                    } else {
                      final ordemDias = [
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday',
                      ];

                      final diasPtBrAbreviado = {
                        'Monday': 'Seg',
                        'Tuesday': 'Ter',
                        'Wednesday': 'Qua',
                        'Thursday': 'Qui',
                        'Friday': 'Sex',
                        'Saturday': 'Sáb',
                        'Sunday': 'Dom',
                      };

                      final dadosOrdenados =
                          snapshot.data!..sort(
                            (a, b) => ordemDias
                                .indexOf(a.diaSemana)
                                .compareTo(ordemDias.indexOf(b.diaSemana)),
                          );

                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 5,
                          left: 5,
                          top: 16,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Média diária de desperdício por dia da semana',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Expanded(
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  labelRotation: 70,
                                  interval: 1,
                                ),

                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: <CartesianSeries>[
                                  ColumnSeries<
                                    EstatisticaSemanalDesperdicio,
                                    String
                                  >(
                                    dataSource: dadosOrdenados,
                                    xValueMapper:
                                        (estat, _) =>
                                            diasPtBrAbreviado[estat.diaSemana]!,
                                    yValueMapper:
                                        (estat, _) => estat.mediaDesperdicio,
                                    name: 'Desperdício',
                                    dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                    ),
                                    dataLabelMapper:
                                        (estat, _) => estat.mediaDesperdicio
                                            .toStringAsFixed(2),
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
