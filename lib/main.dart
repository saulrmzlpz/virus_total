import 'package:flutter/material.dart';
import 'package:virus_total_multi/screens/screens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF19AA8B),
      )),
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
    );
  }
}
