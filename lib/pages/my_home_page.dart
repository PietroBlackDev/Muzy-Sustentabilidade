import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int valorHospedes = 96;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String horario = DateTime.now().toString();
  String refeicao = '';

  @override
  void initState() {
    super.initState();
    contador();
    tipoRefeicao();
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
        print('Cafe');
        refeicao = 'Café da Manhã';
      } else if (comparacaoAlmoco < 0) {
        print('Almoco');
        refeicao = 'Almoço';
      } else if (comparacaoTarde < 0) {
        print('Tarde');
        refeicao = 'Café da Tarde';
      } else if (comparacaoJanta < 0) {
        print('Janta');
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
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      contador();
    });

    Timer(Duration(seconds: 1), () {
      tipoRefeicao();
    });

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
                      Text(
                        '$valorHospedes',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 115,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

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
                            "almoçar",
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
                            valorHospedes = valorHospedes - 1;
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
                            valorHospedes = valorHospedes - 2;
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
                            valorHospedes = valorHospedes - 3;
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
                          valorHospedes = valorHospedes - 4;
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
                          valorHospedes = valorHospedes - 5;
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: BottomNavigationBar(
          showSelectedLabels: true,
          iconSize: 28,
          showUnselectedLabels: false,
          currentIndex: 0,
          selectedFontSize: 0,
          backgroundColor: Theme.of(context).colorScheme.primary,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.edit_document,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
