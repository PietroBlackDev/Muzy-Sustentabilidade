import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:tg/model/estatisticaMensal_model.dart';
import 'package:tg/pages/my_statistic_page_dois.dart';

class MyStatisticPage extends StatefulWidget {
  const MyStatisticPage({super.key});
  @override
  State<MyStatisticPage> createState() => _MyStatisticPageState();
}

class _MyStatisticPageState extends State<MyStatisticPage> {
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
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Estatísticas Gerais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Material(
                color: Colors.transparent, // Necessário para o efeito ripple
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  splashColor: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.0),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => MyStatisticPageDois(),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4519,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor,
                    ),
                    child: FutureBuilder<List<EstatisticaMensal>>(
                      future: fetchEstatisticas(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text('Nenhuma estatística encontrada.'),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                    left: 10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Estatisticas de desperdício por periodos',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 21,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ],
                                  ),
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
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.002,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4519,
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estatisticas de desperdício por refeições',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 21,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
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
                                PieSeries<EstatisticaMensal, String>(
                                  dataSource: snapshot.data!,
                                  xValueMapper: (estat, _) => estat.mes,
                                  yValueMapper:
                                      (estat, _) =>
                                          estat.qntdeComidaDesperdicada,
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
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.002,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
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
                      // Extraindo apenas os valores para o SparkBarChart
                      final dados =
                          snapshot.data!
                              .map(
                                (estat) =>
                                    estat.qntdeComidaDesperdicada.toDouble(),
                              )
                              .toList();

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 0,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Estatisticas de desperdício por hospedes',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 21,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            SfSparkBarChart(
                              data: dados,
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              axisLineColor: Colors.grey,
                              color: Colors.orange,
                              trackball: SparkChartTrackball(
                                activationMode: SparkChartActivationMode.tap,
                              ),
                              highPointColor: Colors.red,
                              lowPointColor: Colors.green,
                              firstPointColor: Colors.blue,
                              lastPointColor: Colors.purple,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.002,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
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
                      final dados =
                          snapshot.data!
                              .map(
                                (estat) =>
                                    estat.qntdeComidaDesperdicada.toDouble(),
                              )
                              .toList();

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tendência de Desperdício de Comida',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 16),
                            SfSparkAreaChart(
                              axisLineWidth: 1,
                              marker: SparkChartMarker(
                                displayMode: SparkChartMarkerDisplayMode.all,
                              ),
                              data: dados,
                              labelDisplayMode: SparkChartLabelDisplayMode.all,
                              axisLineColor: Colors.grey,
                              color: Theme.of(context).colorScheme.tertiary,
                              borderColor:
                                  Theme.of(context).colorScheme.secondary,
                              borderWidth: 2,
                              highPointColor: Colors.red,
                              lowPointColor: Colors.green,
                              firstPointColor: Colors.blue,
                              lastPointColor: Colors.purple,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.002,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
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
                      final dados = snapshot.data!;
                      final valores =
                          dados
                              .map((e) => e.qntdeComidaDesperdicada.toDouble())
                              .toList();
                      final media =
                          valores.reduce((a, b) => a + b) / valores.length;

                      // Convertendo os dados para +1 (acima da média) e -1 (abaixo da média)
                      final winLossData =
                          valores.map((v) => v >= media ? 1 : -1).toList();

                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Comparativo de Desperdício ',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 24),
                            SfSparkWinLossChart(
                              data: winLossData,
                              color: Colors.deepPurple,
                              negativePointColor: Colors.red,
                              axisLineColor: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
