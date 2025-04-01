import 'package:tg/pages/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:tg/themes/my_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: const MyHomePage(title: ''),
    );
  }
}
