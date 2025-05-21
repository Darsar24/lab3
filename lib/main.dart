import 'package:flutter/material.dart';
import 'dart:math'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор квадратного уравнения',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InputScreen(),
    );
  }
}

// === Первый экран: форма ввода ===
class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();
  bool _agree = false;

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agree) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            a: double.parse(_aController.text),
            b: double.parse(_bController.text),
            c: double.parse(_cController.text),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля и примите соглашение.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Квадратное уравнение')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _aController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент a'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент a';
                  if (double.tryParse(value) == null) return 'Неверный формат';
                  if (double.parse(value) == 0) return 'a не может быть равно 0';
                  return null;
                },
              ),
              TextFormField(
                controller: _bController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент b'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент b';
                  if (double.tryParse(value) == null) return 'Неверный формат';
                  return null;
                },
              ),
              TextFormField(
                controller: _cController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент c'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент c';
                  if (double.tryParse(value) == null) return 'Неверный формат';
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _agree,
                onChanged: (value) {
                  setState(() {
                    _agree = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === Второй экран: результат ===
class ResultScreen extends StatelessWidget {
  final double a;
  final double b;
  final double c;

  ResultScreen({required this.a, required this.b, required this.c});

  String calculateRoots(double a, double b, double c) {
    double d = b * b - 4 * a * c;

    if (d > 0) {
      double sqrtD = sqrt(d);
      double x1 = (-b - sqrtD) / (2 * a);
      double x2 = (-b + sqrtD) / (2 * a);
      return 'Два корня: x₁ = $x1, x₂ = $x2';
    } else if (d == 0) {
      double x = -b / (2 * a);
      return 'Один корень: x = $x';
    } else {
      return 'Нет действительных корней';
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = calculateRoots(a, b, c);

    return Scaffold(
      appBar: AppBar(title: Text('Результат')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Коэффициент a: $a', style: TextStyle(fontSize: 18)),
            Text('Коэффициент b: $b', style: TextStyle(fontSize: 18)),
            Text('Коэффициент c: $c', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Решение:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(result, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Вернуться назад
              },
              child: Text('Назад'),
            ),
          ],
        ),
      ),
    );
  }
}