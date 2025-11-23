import 'package:flutter/material.dart';
import 'simple_examples_page.dart';

void main() {
  runApp(const TappableExampleApp());
}

class TappableExampleApp extends StatelessWidget {
  const TappableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tappable Examples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SimpleExamplesPage(),
    );
  }
}
