
import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator BMI',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BMIScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double? _bmiResult;
  String _bmiInterpretation = "Silakan masukkan data Anda";

  void _calculateBMI() {
    final double weight =
        double.tryParse(_weightController.text) ?? 0;
    final double heightInCm =
        double.tryParse(_heightController.text) ?? 0;

    setState(() {
      if (weight > 0 && heightInCm > 0) {
        final double heightInM = heightInCm / 100;
        final double bmi = weight / (heightInM * heightInM);

        _bmiResult = bmi;

        if (bmi < 18.5) {
          _bmiInterpretation = "Kekurangan berat badan";
        } else if (bmi < 25) {
          _bmiInterpretation = "Berat badan ideal";
        } else if (bmi < 30) {
          _bmiInterpretation = "Kelebihan berat badan";
        } else {
          _bmiInterpretation = "Obesitas";
        }
      } else {
        _bmiResult = null;
        _bmiInterpretation = "Masukkan data yang valid";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator BMI'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _weightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Berat Badan (kg)',
                icon: const Icon(Icons.monitor_weight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _heightController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                icon: const Icon(Icons.height),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Hitung BMI'),
            ),
            const SizedBox(height: 40),
            const Text(
              'Hasil:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    _bmiResult?.toStringAsFixed(1) ?? '--',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bmiInterpretation,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
