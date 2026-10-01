import 'package:flutter/material.dart';
import 'package:simple_intrest/calculator_service.dart';

void main() {
  runApp(const SimpleInterestApp());
}

class SimpleInterestApp extends StatelessWidget {
  const SimpleInterestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Interest Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  State<CalculatorHomePage> createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final CalculatorService _calculatorService = CalculatorService();

  // Simple Interest Form Controllers
  final _siFormKey = GlobalKey<FormState>();
  final _principalController = TextEditingController();
  final _rateController = TextEditingController();
  final _timeController = TextEditingController();

  double? _calculatedSI;
  double? _calculatedTotal;

  // Basic Calculator Controllers
  final _calcFormKey = GlobalKey<FormState>();
  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();
  double? _calcResult;
  String _currentOperationLabel = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _principalController.dispose();
    _rateController.dispose();
    _timeController.dispose();
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  void _calculateSimpleInterest() {
    if (_siFormKey.currentState!.validate()) {
      final double p = double.parse(_principalController.text);
      final double r = double.parse(_rateController.text);
      final double t = double.parse(_timeController.text);

      setState(() {
        _calculatedSI = _calculatorService.calculateSimpleInterest(
          principal: p,
          rate: r,
          time: t,
        );
        _calculatedTotal = _calculatorService.calculateTotalAmount(
          principal: p,
          simpleInterest: _calculatedSI!,
        );
      });
    }
  }

  void _resetSIForm() {
    _principalController.clear();
    _rateController.clear();
    _timeController.clear();
    setState(() {
      _calculatedSI = null;
      _calculatedTotal = null;
    });
  }

  void _performArithmetic(String operation) {
    if (_calcFormKey.currentState!.validate()) {
      final double num1 = double.parse(_num1Controller.text);
      final double num2 = double.parse(_num2Controller.text);

      try {
        double result;
        String label;

        switch (operation) {
          case 'add':
            result = _calculatorService.add(num1, num2);
            label = '$num1 + $num2 = $result';
            break;
          case 'subtract':
            result = _calculatorService.subtract(num1, num2);
            label = '$num1 - $num2 = $result';
            break;
          case 'multiply':
            result = _calculatorService.multiply(num1, num2);
            label = '$num1 × $num2 = $result';
            break;
          case 'divide':
            result = _calculatorService.divide(num1, num2);
            label = '$num1 ÷ $num2 = $result';
            break;
          default:
            return;
        }

        setState(() {
          _calcResult = result;
          _currentOperationLabel = label;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _resetArithmeticForm() {
    _num1Controller.clear();
    _num2Controller.clear();
    setState(() {
      _calcResult = null;
      _currentOperationLabel = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Interest Calculator'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.calculate),
              text: 'Simple Interest',
            ),
            Tab(
              icon: Icon(Icons.exposure),
              text: 'Basic Operations',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSimpleInterestView(),
          _buildBasicCalculatorView(),
        ],
      ),
    );
  }

  Widget _buildSimpleInterestView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _siFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: const [
                    Text(
                      'Simple Interest Formula',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'SI = (Principal × Rate × Time) / 100\nTotal Amount = Principal + SI',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _principalController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Principal Amount (P)',
                hintText: 'e.g., 10000',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter principal amount';
                }
                final parsed = double.tryParse(value);
                if (parsed == null || parsed < 0) {
                  return 'Enter a valid positive number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Rate of Interest per annum (%) (R)',
                hintText: 'e.g., 5.5',
                prefixIcon: Icon(Icons.percent),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter rate of interest';
                }
                final parsed = double.tryParse(value);
                if (parsed == null || parsed < 0) {
                  return 'Enter a valid positive number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _timeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Time Period in Years (T)',
                hintText: 'e.g., 2.5',
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter time period in years';
                }
                final parsed = double.tryParse(value);
                if (parsed == null || parsed < 0) {
                  return 'Enter a valid positive number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _calculateSimpleInterest,
                    icon: const Icon(Icons.check),
                    label: const Text('Calculate'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                OutlinedButton.icon(
                  onPressed: _resetSIForm,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ],
            ),
            if (_calculatedSI != null && _calculatedTotal != null) ...[
              const SizedBox(height: 24.0),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Result Summary',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Simple Interest (SI):'),
                          Text(
                            _calculatedSI!.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total Amount (P + SI):'),
                          Text(
                            _calculatedTotal!.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBasicCalculatorView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _calcFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _num1Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'First Number (Num 1)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter first number';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _num2Controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Second Number (Num 2)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter second number';
                }
                if (double.tryParse(value) == null) {
                  return 'Enter a valid number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _performArithmetic('add'),
                  icon: const Icon(Icons.add),
                  label: const Text('Sum (+)'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _performArithmetic('subtract'),
                  icon: const Icon(Icons.remove),
                  label: const Text('Minus (-)'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _performArithmetic('multiply'),
                  icon: const Icon(Icons.close),
                  label: const Text('Multiply (×)'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _performArithmetic('divide'),
                  icon: const Icon(Icons.percent),
                  label: const Text('Divide (÷)'),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Center(
              child: OutlinedButton.icon(
                onPressed: _resetArithmeticForm,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Numbers'),
              ),
            ),
            if (_calcResult != null) ...[
              const SizedBox(height: 24.0),
              Card(
                elevation: 4.0,
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Calculation Result',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        _currentOperationLabel,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
