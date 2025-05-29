import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:tg/componentes/decoracao_campo_aut.dart';

Timer? _timer;
String refeicao = '';

class MyFormsPage extends StatefulWidget {
  const MyFormsPage({super.key});

  @override
  State<MyFormsPage> createState() => _MyFormsPageState();
}

class _MyFormsPageState extends State<MyFormsPage> {
  @override
  void initState() {
    super.initState();
    tipoRefeicao();
    iniciarTimer();
  }

  void iniciarTimer() {
    _timer = Timer.periodic(const Duration(seconds: 600), (timer) {
      tipoRefeicao();
    });
  }

  void tipoRefeicao() {
    setState(() {
      TimeOfDay horarioCafe = TimeOfDay(hour: 10, minute: 00);
      TimeOfDay horarioAlmoco = TimeOfDay(hour: 15, minute: 00);
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

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String dataAgora = DateFormat.yMMMd().format(DateTime.now());

  var formKey = GlobalKey<FormState>();
  var inputComidaDesperdicada = TextEditingController();
  var inputComidaProduzida = TextEditingController();

  void quandoGravaCliente() async {
    if (formKey.currentState!.validate()) {
      final jsonData = {
        'QntdeComidaDesperdicada': inputComidaDesperdicada.text,
        'QntdeComidaProduzida': inputComidaProduzida.text,
      };

      try {
        Dio dio = Dio(
          BaseOptions(
            connectTimeout: Duration(seconds: 5),
            receiveTimeout: Duration(seconds: 5),
            validateStatus: (status) => status! < 500,
            headers: {
              'Content-Type': 'application/json', // Define o tipo como JSON
            },
          ),
        );

        Response response = await dio.put(
          'http://10.125.121.135:8081/CI4/public/desperdicio/ultimo',
          data: jsonData, // Enviando como JSON
        );

        if (response.statusCode == 200) {
          print('Dados atualizados com sucesso!');
        } else {
          print('Erro: ${response.data['message']}');
        }
      } catch (e) {
        print('Erro na requisição: $e');
      }
    }
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      'Questionario diário',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty || value == '0') {
                        return 'Por favor insira algum valor';
                      }
                      if (int.tryParse(value!) == null) {
                        return 'Por favor insira um número válido';
                      }
                      return null;
                    },
                    controller: inputComidaProduzida,
                    decoration: getAuthenticationInputDecoration(
                      'Quantidade de comida produzida:',
                    ),
                  ),
                  SizedBox(height: 26),
                  Text('Refeições', style: TextStyle(fontSize: 24)),
                  Text(
                    'Quantidade de comida desperdiçada por refeições em kg',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty || value == '0') {
                        return 'Por favor insira algum valor';
                      }
                      if (int.tryParse(value!) == null) {
                        return 'Por favor insira um número válido';
                      }
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                              child: Lottie.asset('assets/lotties/check.json'),
                            ),
                            content: Text(
                              'Valores inseridos com sucesso',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                        255,
                                        248,
                                        250,
                                        252,
                                      ),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return null;
                    },
                    controller: inputComidaDesperdicada,
                    decoration: getAuthenticationInputDecoration(
                      'Pesagem da refeição atual ($refeicao)',
                    ),
                  ),
                  SizedBox(height: 60),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          quandoGravaCliente();
                        },
                        child: Text(
                          "ENVIAR",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
