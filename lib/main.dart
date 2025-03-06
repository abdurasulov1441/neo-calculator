import 'package:flutter/material.dart';
import 'package:neo_calculator/calculator_page.dart';
import 'package:neo_calculator/style/app_colors.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.backgroundColor),
      home: const CalculatorScreen(),
    );
  }
}

