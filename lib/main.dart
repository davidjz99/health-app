import 'package:flutter/material.dart';
import 'package:health_app/pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //pantalla login
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // Material3 para un diseño más moderno
      ),
      home: const LoginScreen(), // Se muestra el LoginScreen
    );
  }
}
