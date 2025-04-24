import 'package:flutter/material.dart';
import 'package:tg/pages/my_screen_page.dart';
import 'package:tg/themes/my_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muzy Sustentabilidade',
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      home: HomeScreen(),
    );
  }
}
