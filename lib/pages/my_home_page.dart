import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:tg/model/quantidade_model.dart';

int ultimaInsercao = 0;
int valorHospedes = 0;
int? quantidade;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isButtonDisabled = true;
  String horario = DateTime.now().toString();
  String refeicao = '';

  @override
  void initState() {
    super.initState();
    contador();
    tipoRefeicao();
    consultaQuantidadeApi();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  void contador() {
    setState(() {
      horario = DateFormat.Hms().format(DateTime.now()).toString();
    });
  }

  void tipoRefeicao() {
    setState(() {
      TimeOfDay horarioCafe = TimeOfDay(hour: 11, minute: 00);
      TimeOfDay horarioAlmoco = TimeOfDay(hour: 14, minute: 30);
      TimeOfDay horarioTarde = TimeOfDay(hour: 18, minute: 0);
      TimeOfDay horarioJanta = TimeOfDay(hour: 22, minute: 0);
      TimeOfDay horarioAtual = TimeOfDay.now();

      int comparacaoAlmoco = compareTimes(horarioAtual, horarioAlmoco);
      int comparacaoJanta = compareTimes(horarioAtual, horarioJanta);
      int comparacaoCafe = compareTimes(horarioAtual, horarioCafe);
      int comparacaoTarde = compareTimes(horarioAtual, horarioTarde);

      if (comparacaoCafe < 0) {
        refeicao = 'Café da Manhã';
      } else if (comparacaoAlmoco < 0) {
        refeicao = 'Almoço';
      } else if (comparacaoTarde < 0) {
        refeicao = 'Café da Tarde';
      } else if (comparacaoJanta < 0) {
        refeicao = 'Jantar';
      }
    });
  }

  int compareTimes(TimeOfDay t0, TimeOfDay t1) {
    final int minutosAtual = t0.hour * 60 + t0.minute;
    final int minutos1 = t1.hour * 60 + t1.minute;
    return minutosAtual.compareTo(minutos1);
  }

  Future consultaQuantidadeApi() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        'http://10.125.121.135:8081/CI4/public/hospedes',
      );

      if (response.statusCode == 200) {
        var json = jsonEncode(response.data);
        var _data = json.toString();

        // Converter o JSON para um Map
        Map<String, dynamic> jsonMap = jsonDecode(_data);

        // Criar uma instância de QuantidadeModel usando o método fromJson
        QuantidadeModel quantidadeModel = QuantidadeModel.fromJson(jsonMap);

        // Atualizar o estado do widget com o valor obtido
        setState(() {
          quantidade = quantidadeModel.quantidade;
        });

        // Exibir o valor
        print(quantidade);
      }
    } catch (e) {
      print("Erro ao consultar a API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      contador();
    });

    Timer(Duration(seconds: 1), () {
      tipoRefeicao();
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Painel",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
                  child: Text(
                    horario,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    refeicao,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.68,
                  height: MediaQuery.of(context).size.height * 0.325,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(130),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      quantidade != null
                          ? Text(
                            '$quantidade',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 115,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(strokeWidth: 10),
                          ),
                      SizedBox(height: 10),

                      Column(
                        children: [
                          Text(
                            "Hospedes para",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            refeicao,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.275,
                        height: MediaQuery.of(context).size.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            _isButtonDisabled = false;
                            quantidade = quantidade! - 1;
                            ultimaInsercao = 1;
                            setState(() {});
                          },
                          child: Text(
                            "-1",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.275,
                        height: MediaQuery.of(context).size.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            _isButtonDisabled = false;
                            quantidade = quantidade! - 2;
                            ultimaInsercao = 2;
                            setState(() {});
                          },
                          child: Text(
                            "-2",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.275,
                        height: MediaQuery.of(context).size.height * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            _isButtonDisabled = false;
                            quantidade = quantidade! - 3;
                            ultimaInsercao = 3;
                            setState(() {});
                          },
                          child: Text(
                            "-3",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.275,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          _isButtonDisabled = false;
                          quantidade = quantidade! - 4;
                          ultimaInsercao = 4;
                          setState(() {});
                        },
                        child: Text(
                          "-4",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.037),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.275,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          _isButtonDisabled = false;
                          quantidade = quantidade! - 5;
                          ultimaInsercao = 5;
                          setState(() {});
                        },
                        child: Text(
                          "-5",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: MediaQuery.of(context).size.width * 0.037),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.275,
                      height: MediaQuery.of(context).size.height * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed:
                            _isButtonDisabled
                                ? null
                                : () {
                                  _isButtonDisabled = true;
                                  quantidade = quantidade! + ultimaInsercao;
                                  setState(() {});
                                },
                        child: Icon(
                          Icons.keyboard_backspace_outlined,
                          color: const Color.fromARGB(255, 0, 0, 0),
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
