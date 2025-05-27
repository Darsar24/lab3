import 'package:flutter/material.dart';
import 'dart:math';

class ResultScreen extends StatelessWidget {
  final double a;
  final double b;
  final double c;

  const ResultScreen({Key? key, required this.a, required this.b, required this.c}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String resultText;

    if (a == 0) {
      resultText = 'a не может быть равно 0';
    } else {
      double d = b * b - 4 * a * c;

      if (d > 0) {
        double sqrtD = sqrt(d);
        double x1 = (-b - sqrtD) / (2 * a);
        double x2 = (-b + sqrtD) / (2 * a);
        resultText = 'Два корня:\n x₁ = $x1\n x₂ = $x2';
      } else if (d == 0) {
        double x = -b / (2 * a);
        resultText = 'Один корень:\n x = $x';
      } else {
        resultText = 'Нет действительных корней';
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            resultText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
