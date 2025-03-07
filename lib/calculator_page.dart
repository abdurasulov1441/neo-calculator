import 'package:flutter/material.dart';
import 'package:neo_calculator/neo_button_equall.dart';
import 'package:neo_calculator/neo_button.dart';
import 'package:neo_calculator/style/app_colors.dart';
import 'package:neo_calculator/style/app_style.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Текущее число
  String _expression = ""; // Полное выражение
  String _operator = ""; // Последний оператор
  num? _result; // Хранит результат последовательных операций (num → может быть int или double)
  bool _shouldReset = false; // Флаг, когда вводить новое число

 void _onPressed(String value) {
  setState(() {
    if (value == "C") {
      _output = "0";
      _expression = "";
      _operator = "";
      _result = null;
      _shouldReset = false;
    } else if (value == "⌫") {
      if (_output.isNotEmpty && _output != "0") {
        _output = _output.substring(0, _output.length - 1);
        if (_output.isEmpty) _output = "0";

        // ❗ Удаляем последний символ из _expression тоже
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      }
    } else if (value == "=") {
      if (_operator.isNotEmpty) {
        _calculate();
        _operator = "";
      }
    } else if ("+−×÷".contains(value)) {
      if (_operator.isNotEmpty) {
        _calculate();
      } else {
        _result = num.tryParse(_output);
      }
      _operator = value;
      _expression = "$_result $value";
      _shouldReset = true;
    } else {
      if (_shouldReset) {
        _output = value;
        _shouldReset = false;
      } else {
        _output = _output == "0" ? value : _output + value;
      }

      // ✅ Теперь _expression обновляется правильно
      if (_expression.endsWith("=")) {
        _expression = _output; // Если после "=", начинаем новое выражение
      } else {
        _expression = _expression.isEmpty ? _output : "$_expression$value";
      }
    }
  });
}


  void _calculate() {
    if (_operator.isEmpty || _result == null) return;
    num currentNumber = num.tryParse(_output) ?? 0;
    switch (_operator) {
      case "+":
        _result = _result! + currentNumber;
        break;
      case "−":
        _result = _result! - currentNumber;
        break;
      case "×":
        _result = _result! * currentNumber;
        break;
      case "÷":
        _result = currentNumber != 0 ? _result! / currentNumber : double.nan;
        break;
    }
    _output = _formatResult(_result!);
    _expression = "$_expression =";
  }

  String _formatResult(num result) {
    return result % 1 == 0 ? result.toInt().toString() : result.toString();
  }

  Widget _buildButton(String text, {bool isOperator = false, double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: NeumorphicButton(
        onPressed: () => _onPressed(text),
        label: text,
        size: 70,
        color: isOperator ? AppColors.operatorColor : AppColors.textColor,
      ),
    );
  }
    Widget _buildEquallButton(String text, {bool isOperator = false, double flex = 1}) {
    return Expanded(
      flex: flex.toInt(),
      child: NeumorphicEquallButton(
        onPressed: () => _onPressed(text),
        label: text,
        size: 70,
        color: isOperator ? AppColors.operatorColor : AppColors.textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _expression,
                  style: AppStyle.fontStyle.copyWith(fontSize: 24, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  _output,
                  style: AppStyle.fontStyle.copyWith(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowDark,
                  offset: const Offset(0, -6),
                  blurRadius: 10,
                ),
              ],
            ),
           child: Column(
  children: [
    // Первая строка кнопок
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("C", isOperator: true),
        _buildButton("⌫", isOperator: true),
        _buildButton("%", isOperator: true),
        _buildButton("÷", isOperator: true),
      ],
    ),
    const SizedBox(height: 10),

    // Вторая строка кнопок
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("7"),
        _buildButton("8"),
        _buildButton("9"),
        _buildButton("×", isOperator: true),
      ],
    ),
    const SizedBox(height: 10),

    // Третья строка кнопок
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("4"),
        _buildButton("5"),
        _buildButton("6"),
        _buildButton("−", isOperator: true),
      ],
    ),
    const SizedBox(height: 10),

    // Четвёртая строка кнопок
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton("1"),
        _buildButton("2"),
        _buildButton("3"),
        _buildButton("+", isOperator: true),
      ],
    ),
    const SizedBox(height: 10),

    // Пятая строка кнопок (0, ., =)
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: _buildButton("0")), // "0" занимает больше места
        const SizedBox(width: 10),
        _buildButton("."),
        const SizedBox(width: 10),
        Expanded(child: _buildEquallButton("=", isOperator: true)), // "=" занимает больше места
      ],
    ),
  ],
),

          ),
        ],
      ),
    );
  }
}
