import 'package:flutter/material.dart';
import '../widgets/app_theme.dart';
import '../widgets/progress_indicator.dart';
import 'diabetes_type.dart';
import '../components/prediction_data.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  static String? lastGender;
  static String? lastAge;
  static String? lastDiabetesType;

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();
  final TextEditingController _hba1cController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _selectedGender;
  double? _calculatedBMI;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _glucoseController.dispose();
    _hba1cController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final heightCm = double.tryParse(_heightController.text);

    if (weight != null && heightCm != null && heightCm > 0) {
      final heightM = heightCm / 100;
      setState(() {
        _calculatedBMI = weight / (heightM * heightM);
      });
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    Function()? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label),
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: (val) => onChanged?.call(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (keyboardType == TextInputType.number ||
            keyboardType == TextInputType.numberWithOptions(decimal: true)) {
          if (double.tryParse(value) == null) {
            return 'Enter valid number';
          }
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Prediction',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 6,
                child: CustomPaint(
                  painter: ProgressBarPainter(progress: 0.25),
                ),
              ),
              SizedBox(height: 20),
              const Text('Enter your details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: _inputDecoration('BMI (Auto Calculated)'),
                readOnly: true,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.green),
                controller: TextEditingController(
                    text: _calculatedBMI != null
                        ? _calculatedBMI!.toStringAsFixed(1)
                        : ''),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: _inputDecoration('Gender'),
                items: ['Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGender = val),
                validator: (val) => val == null ? 'Please select gender' : null,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: _glucoseController,
                  label: 'Glucose',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: _hba1cController,
                  label: 'HbA1c (%)',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 15),
              _buildTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 110),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 4,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final data = PredictionData(
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                        bmi: _calculatedBMI ?? 0,
                        gender: _selectedGender!,
                        smoking: "",
                        hypertension: "",
                        heartDisease: "",
                        glucose: double.parse(_glucoseController.text),
                        glucoseType: "",
                        hba1c: double.parse(_hba1cController.text),
                        age: int.parse(_ageController.text),
                      );
                      PredictionScreen.lastGender = _selectedGender;
                      PredictionScreen.lastAge = _ageController.text;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DiabetesTypeScreen(predictionData: data),
                        ),
                      );
                    }
                  },
                  child:
                      const Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
