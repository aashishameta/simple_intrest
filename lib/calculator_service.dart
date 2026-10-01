/// Utility class providing core arithmetic operations and Simple Interest calculations.
class CalculatorService {
  /// Adds two numbers: [a] + [b]
  double add(double a, double b) {
    return a + b;
  }

  /// Subtracts [b] from [a]: [a] - [b]
  double subtract(double a, double b) {
    return a - b;
  }

  /// Multiplies two numbers: [a] * [b]
  double multiply(double a, double b) {
    return a * b;
  }

  /// Divides [a] by [b]: [a] / [b].
  /// Throws [ArgumentError] if [b] is 0.
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Division by zero is not allowed.');
    }
    return a / b;
  }

  /// Calculates Simple Interest using the formula:
  /// SI = (Principal * Rate * Time) / 100
  ///
  /// [principal] - The initial amount of money (P)
  /// [rate] - Annual interest rate percentage (R)
  /// [time] - Time period in years (T)
  double calculateSimpleInterest({
    required double principal,
    required double rate,
    required double time,
  }) {
    if (principal < 0 || rate < 0 || time < 0) {
      throw ArgumentError('Principal, rate, and time must be non-negative.');
    }
    // SI = (P * R * T) / 100
    final double product = multiply(principal, multiply(rate, time));
    return divide(product, 100);
  }

  /// Calculates Total Amount (Principal + Simple Interest).
  /// Formula: Total = P + SI
  double calculateTotalAmount({
    required double principal,
    required double simpleInterest,
  }) {
    return add(principal, simpleInterest);
  }
}
