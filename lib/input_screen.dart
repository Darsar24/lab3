import 'package:flutter/material.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  bool _agree = false;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _agree) {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);
      double c = double.parse(_cController.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(a: a, b: b, c: c),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пожалуйста, заполните все поля и примите соглашение')),
      );
    }
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ввод коэффициентов')),
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
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
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
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
                  return null;
                },
              ),
              TextFormField(
                controller: _cController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Коэффициент c'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите коэффициент c';
                  if (double.tryParse(value) == null) return 'Неверный формат числа';
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Согласен на обработку данных'),
                value: _agree,
                onChanged: (bool? value) {
                  setState(() {
                    _agree = value!;
                  });
                },
              ),
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
