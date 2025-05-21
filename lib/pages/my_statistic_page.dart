import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tg/model/estatisticaMensal_model.dart';

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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: FutureBuilder<List<EstatisticaMensal>>(
          future: fetchEstatisticas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhuma estatística encontrada.'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Estatísticas Mensais'),
                  primaryXAxis: CategoryAxis(labelRotation: 60, interval: 1),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    LineSeries<EstatisticaMensal, String>(
                      dataSource: snapshot.data!,
                      xValueMapper: (estat, _) => estat.mes,
                      yValueMapper: (estat, _) => estat.qntdeComidaDesperdicada,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      markerSettings: MarkerSettings(isVisible: true),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
