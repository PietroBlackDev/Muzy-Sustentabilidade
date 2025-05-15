import 'package:flutter/material.dart';
import 'package:tg/pages/my_forms_page.dart';
import 'package:tg/pages/my_home_page.dart';
import 'package:tg/pages/my_statistic_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [MyHomePage(), MyFormsPage(), MyStatisticPage()];

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
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bar_chart_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
