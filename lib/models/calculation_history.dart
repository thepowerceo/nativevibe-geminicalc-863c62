import 'package:flutter/foundation.dart';

/// Represents a single entry in the calculation history.
@immutable
class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationHistory({
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  /// Creates a CalculationHistory from a JSON map.
  factory CalculationHistory.fromJson(Map<String, dynamic> json) {
    return CalculationHistory(
      expression: json['expression'] as String,
      result: json['result'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Converts a CalculationHistory instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculationHistory &&
          runtimeType == other.runtimeType &&
          expression == other.expression &&
          result == other.result &&
          timestamp == other.timestamp;

  @override
  int get hashCode => expression.hashCode ^ result.hashCode ^ timestamp.hashCode;

  @override
  String toString() {
    return 'CalculationHistory(expression: $expression, result: $result, timestamp: $timestamp)';
  }
}