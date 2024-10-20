import 'package:flutter/material.dart';
import 'screens/user_input_screen.dart';
import 'screens/resultado_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Calorias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => UserInputScreen(),
        '/resultado': (context) => ResultadoScreen(),
      },
    );
  }
}
