import 'package:flutter/material.dart';
import 'package:gemini_calc/models/calculation_history.dart';
import 'package:gemini_calc/services/storage_service.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  final StorageService _storageService;

  CalculatorProvider(this._storageService);

  String _expression = '';
  String _result = '';
  List<CalculationHistory> _history = [];
  double _memoryValue = 0.0;

  String get expression => _expression;
  String get result => _result;
  List<CalculationHistory> get history => List.unmodifiable(_history);
  double get memoryValue => _memoryValue;

  Future<void> loadHistory() async {
    _history = await _storageService.loadHistory();
    notifyListeners();
  }

  void onButtonPressed(String value) {
    if (value == '=') {
      _calculate();
    } else if (value == 'AC') {
      _clearAll();
    } else if (value == 'C') {
      _clear();
    } else if (value == 'â«') {
      if (_expression.isNotEmpty) {
        _expression = _expression.substring(0, _expression.length - 1);
      }
    } else if (value == 'M+') {
      _memoryAdd();
    } else if (value == 'M-') {
      _memorySubtract();
    } else if (value == 'MR') {
      _memoryRecall();
    } else if (value == 'MC') {
      _memoryClear();
    } else {
      _expression += value;
    }
    notifyListeners();
  }

  void _calculate() {
    if (_expression.isEmpty) return;

    try {
      // Replace visual operators with evaluatable ones
      String finalExpression = _expression.replaceAll('Ã', '*').replaceAll('Ã·', '/');
      
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      _result = _formatResult(eval);
      final historyEntry = CalculationHistory(
        expression: _expression,
        result: _result,
        timestamp: DateTime.now(),
      );
      _history.insert(0, historyEntry);
      _storageService.saveHistory(_history);
    } catch (e) {
      _result = 'Error';
    }
  }

  String _formatResult(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void _clear() {
    _expression = '';
    _result = '';
  }

  void _clearAll() {
    _clear();
    _memoryClear();
  }

  Future<void> clearHistory() async {
    _history = [];
    await _storageService.saveHistory([]);
    notifyListeners();
  }

  void _memoryAdd() {
    try {
      _memoryValue += double.parse(result.isEmpty ? expression : result);
    } catch (e) { // ignore
    }
  }

  void _memorySubtract() {
     try {
      _memoryValue -= double.parse(result.isEmpty ? expression : result);
    } catch (e) { // ignore
    }
  }

  void _memoryRecall() {
    _expression += _formatResult(_memoryValue);
  }

  void _memoryClear() {
    _memoryValue = 0.0;
  }
}