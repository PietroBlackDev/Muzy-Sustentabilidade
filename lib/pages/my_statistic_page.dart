import 'package:flutter/material.dart';
import 'package:tg/pages/my_statistic_page_dois.dart';
import 'package:tg/pages/my_statistic_page_tres.dart';

class MyStatisticPage extends StatefulWidget {
  const MyStatisticPage({super.key});
  @override
  State<MyStatisticPage> createState() => _MyStatisticPageState();
}

class _MyStatisticPageState extends State<MyStatisticPage> {
  @override
  void initState() {
    super.initState();
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
              SizedBox(height: 15),
              Column(
                spacing: 26,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
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
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => MyStatisticPageDois(),
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(
                                1.0,
                                0.0,
                              ); // Começa fora da tela à direita
                              const end =
                                  Offset.zero; // Termina no centro da tela
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Estatísticas de desperdício de alimentos",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
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
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => MyStatisticPageTres(),
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(
                                1.0,
                                0.0,
                              ); // Começa fora da tela à direita
                              const end =
                                  Offset.zero; // Termina no centro da tela
                              const curve = Curves.ease;

                              final tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              final offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Estatísticas de consumo de alimentos",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
