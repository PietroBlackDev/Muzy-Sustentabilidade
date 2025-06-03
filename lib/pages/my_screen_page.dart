import 'package:flutter/material.dart';
import 'package:tg/pages/my_forms_page.dart';
import 'package:tg/pages/my_home_page.dart';
import 'package:tg/pages/my_statistic_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.usuario, required this.indice});

  final String usuario;
  final int indice;

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late int _indiceAtual = widget.indice;
  final List<Widget> _telas = [MyHomePage(), MyFormsPage(), MyStatisticPage()];

  bool isItem2Enabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: BottomNavigationBar(
          onTap: onTabTapped,
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
                Icons.home_filled,
                color:
                    isItem2Enabled
                        ? null
                        : Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.edit_document,
                color:
                    isItem2Enabled
                        ? null
                        : Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_rounded,
                color:
                    isItem2Enabled
                        ? null
                        : Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    if (widget.usuario == 'gestor') {
      setState(() {
        _indiceAtual = index;
      });
    }

    if (widget.usuario == 'painel') {
      if (index == 1 && !isItem2Enabled) {
        return;
      }
      if (index == 2 && !isItem2Enabled) {
        return;
      }
    }

    if (widget.usuario == 'nutricionista') {
      if (index == 0 && !isItem2Enabled) {
        return;
      }
      setState(() {
        _indiceAtual = index;
      });
    }
  }
}
