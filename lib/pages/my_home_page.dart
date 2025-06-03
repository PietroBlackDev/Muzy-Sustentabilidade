import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:tg/model/quantidade_model.dart';
import 'package:tg/model/valorAtual_model.dart';

int ultimaInsercao = 0;
int valorHospedes = 0;
int? quantidade = 0;
int? total = 0;
int? valorAtual;
Timer? _timerContador;
Timer? _timerTipoRefeicao;
Timer? _timerConsultaQuantidade;
Timer? _timerConsultaValor;
Timer? _timerRegistraTotal;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isButtonDisabled = true;
  String horario = DateTime.now().toString();
  String refeicao = '';
  int? valor = total! - quantidade!;

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      registraTotalHospedes();
    });
  }

  @override
  void initState() {
    super.initState();
    contador();
    tipoRefeicao();
    iniciarTimer();
    _timerTipoRefeicao;
    _timerRegistraTotal;
    consultaValorAtual();
    registraTotalHospedes();
  }

  void iniciarTimer() {
    _timerContador = Timer.periodic(const Duration(seconds: 1), (timer) {
      contador();
    });

    _timerTipoRefeicao = Timer.periodic(const Duration(seconds: 5), (timer) {
      tipoRefeicao();
    });

    _timerConsultaQuantidade = Timer.periodic(const Duration(seconds: 3), (
      timer,
    ) {
      consultaQuantidadeTotal();
    });

    _timerConsultaValor = Timer.periodic(const Duration(seconds: 2), (timer) {
      consultaValorAtual();
    });

    _timerRegistraTotal = Timer.periodic(const Duration(seconds: 600), (timer) {
      registraTotalHospedes();
    });
  }

  @override
  void dispose() {
    _timerContador?.cancel();
    _timerConsultaQuantidade?.cancel();
    _timerConsultaValor?.cancel();
    super.dispose();
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

  Future consultaQuantidadeTotal() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        'http://10.125.121.135:8081/CI4/public/hospedes',
      );

      if (response.statusCode == 200) {
        var json = jsonEncode(response.data);
        var data = json.toString();

        // Converter o JSON para um Map
        Map<String, dynamic> jsonMap = jsonDecode(data);

        // Criar uma instância de QuantidadeModel usando o método fromJson
        QuantidadeModel quantidadeModel = QuantidadeModel.fromJson(jsonMap);

        // Atualizar o estado do widget com o valor obtido
        setState(() {
          total = quantidadeModel.quantidade;
        });

        print(total);
      }
    } catch (e) {
      print("Erro ao consultar a API: $e");
    }
  }

  Future consultaValorAtual() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        'http://10.125.121.135:8081/CI4/public/valor',
      );

      if (response.statusCode == 200) {
        var json = jsonEncode(response.data);
        var data = json.toString();

        // Converter o JSON para um Map
        Map<String, dynamic> jsonMap = jsonDecode(data);

        ValorAtualModel valorAtualModel = ValorAtualModel.fromJson(jsonMap);

        // Atualizar o estado do widget com o valor obtido

        valorAtual = valorAtualModel.valor;

        print(valorAtual);
      }
    } catch (e) {
      print("Erro ao consultar a API: $e");
    }
  }

  Future<void> atualizaValorHospedes(int quantidade) async {
    final Map<String, dynamic> data = {'ValorHospedes': '$quantidade'};
    final String jsonBody = jsonEncode(data);
    print(jsonBody);

    try {
      final response = await http.put(
        Uri.parse('http://10.125.121.135:8081/CI4/public/subtracao/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Inserção realizada com sucesso!');
      } else {
        print('Erro ao inserir: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }
  }

  Future<void> registraTotalHospedes() async {
    final url = Uri.parse(
      'http://10.125.121.135:8081/CI4/public/hospedes/registrar',
    );

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {},
        ), // Enviando corpo vazio, pois o servidor calcula internamente
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        print('Erro ao inserir: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22, bottom: 7),
            child: Text(
              'TOTAL: $total',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.77,
            alignment: Alignment.center,
            child: Center(
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
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 20,
                          bottom: 10,
                        ),
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
                            valorAtual != null
                                ? Text(
                                  '$valorAtual',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 115,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                : SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 10,
                                  ),
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
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
                                  if (quantidade == null) {
                                    _isButtonDisabled = true;
                                  } else {
                                    _isButtonDisabled = false;
                                    quantidade = 1;
                                    ultimaInsercao = 1;
                                    atualizaValorHospedes(quantidade!);
                                    setState(() {
                                      valorAtual = valorAtual! - 1;
                                    });
                                  }
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
                                  if (quantidade == null) {
                                    _isButtonDisabled = true;
                                  } else {
                                    _isButtonDisabled = false;
                                    quantidade = 2;
                                    ultimaInsercao = 2;
                                    atualizaValorHospedes(quantidade!);
                                    setState(() {
                                      valorAtual = valorAtual! - 2;
                                    });
                                  }
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
                                  if (quantidade == null) {
                                    _isButtonDisabled = true;
                                  } else {
                                    _isButtonDisabled = false;
                                    quantidade = 3;
                                    ultimaInsercao = 3;
                                    atualizaValorHospedes(quantidade!);
                                    setState(() {
                                      valorAtual = valorAtual! - 3;
                                    });
                                  }
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
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
                                if (quantidade == null) {
                                  _isButtonDisabled = true;
                                } else {
                                  _isButtonDisabled = false;
                                  quantidade = 4;
                                  ultimaInsercao = 4;
                                  atualizaValorHospedes(quantidade!);
                                  setState(() {
                                    valorAtual = valorAtual! - 4;
                                  });
                                }
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

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.037,
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
                                if (quantidade == null) {
                                  _isButtonDisabled = true;
                                } else {
                                  _isButtonDisabled = false;
                                  quantidade = 5;
                                  ultimaInsercao = 5;
                                  atualizaValorHospedes(quantidade!);
                                  setState(() {
                                    valorAtual = valorAtual! - 5;
                                  });
                                }
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

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.037,
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
                                        quantidade = -ultimaInsercao;
                                        atualizaValorHospedes(quantidade!);
                                        setState(() {
                                          valorAtual =
                                              valorAtual! + ultimaInsercao;
                                        });
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
          ),
        ),
      ),
    );
  }
}
