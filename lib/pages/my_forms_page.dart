import 'package:flutter/material.dart';

class MyFormsPage extends StatefulWidget {
  MyFormsPage();
  @override
  State<MyFormsPage> createState() => _MyFormsPageState();
}

class _MyFormsPageState extends State<MyFormsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Login',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
