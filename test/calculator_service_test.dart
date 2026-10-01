import 'package:flutter_test/flutter_test.dart';
import 'package:simple_intrest/calculator_service.dart';

void main() {
  late CalculatorService calculator;

  setUp(() {
    calculator = CalculatorService();
  });

  group('Basic Arithmetic Operations', () {
    test('add should return correct sum', () {
      expect(calculator.add(10, 5), equals(15));
      expect(calculator.add(-3, 7), equals(4));
    });

    test('subtract should return correct difference', () {
      expect(calculator.subtract(10, 4), equals(6));
      expect(calculator.subtract(5, 10), equals(-5));
    });

    test('multiply should return correct product', () {
      expect(calculator.multiply(4, 5), equals(20));
      expect(calculator.multiply(0, 100), equals(0));
    });

    test('divide should return correct quotient', () {
      expect(calculator.divide(20, 4), equals(5));
      expect(calculator.divide(7, 2), equals(3.5));
    });

    test('divide by zero should throw ArgumentError', () {
      expect(
        () => calculator.divide(10, 0),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('Simple Interest Calculations', () {
    test('calculateSimpleInterest should calculate SI correctly', () {
      // Principal = 10000, Rate = 5%, Time = 2 years
      // SI = (10000 * 5 * 2) / 100 = 1000
      final double result = calculator.calculateSimpleInterest(
        principal: 10000,
        rate: 5,
        time: 2,
      );
      expect(result, equals(1000.0));
    });

    test('calculateSimpleInterest with fractional rate and time', () {
      // Principal = 5000, Rate = 7.5%, Time = 1.5 years
      // SI = (5000 * 7.5 * 1.5) / 100 = 562.5
      final double result = calculator.calculateSimpleInterest(
        principal: 5000,
        rate: 7.5,
        time: 1.5,
      );
      expect(result, equals(562.5));
    });

    test('calculateSimpleInterest should throw for negative inputs', () {
      expect(
        () => calculator.calculateSimpleInterest(
          principal: -1000,
          rate: 5,
          time: 2,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('calculateTotalAmount should calculate P + SI correctly', () {
      final double total = calculator.calculateTotalAmount(
        principal: 10000,
        simpleInterest: 1000,
      );
      expect(total, equals(11000.0));
    });
  });
}
