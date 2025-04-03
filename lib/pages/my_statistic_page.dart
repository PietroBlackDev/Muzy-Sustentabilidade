import 'package:flutter/material.dart';

class MyStatisticPage extends StatefulWidget {
  MyStatisticPage();
  @override
  State<MyStatisticPage> createState() => _MyStatisticPageState();
}

class _MyStatisticPageState extends State<MyStatisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Estatisticas',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
