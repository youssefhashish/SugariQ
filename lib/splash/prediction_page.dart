import 'package:flutter/material.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/prediction_result.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

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
  String? _selectedSmoking;
  String? _selectedHypertension;
  String? _selectedHeartDisease;

  String? _selectedGlucoseType;
  double? _calculatedBMI;

  bool? _predictionResult;
  double? _predictionPercent;
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

  Future<void> _simulatePrediction() async {
    final glucose = double.tryParse(_glucoseController.text) ?? 0;
    final hba1c = double.tryParse(_hba1cController.text) ?? 0;
    double glucosePercent = 0;
    double hba1cPercent = 0;

    if (_selectedGlucoseType == 'Fasting') {
      if (glucose < 100) {
        glucosePercent = 5;
      } else if (glucose < 126) {
        glucosePercent = 40;
      } else {
        glucosePercent = 90;
      }
    } else if (_selectedGlucoseType == 'Random') {
      if (glucose < 140) {
        glucosePercent = 5;
      } else if (glucose < 200) {
        glucosePercent = 40;
      } else {
        glucosePercent = 90;
      }
    } else {
      glucosePercent = 0;
    }

    if (hba1c < 5.7) {
      hba1cPercent = 5;
    } else if (hba1c < 6.5) {
      hba1cPercent = 40;
    } else {
      hba1cPercent = 90;
    }

    double percent = ((glucosePercent + hba1cPercent) / 2).clamp(0, 99);

    final isDiabetic = percent >= 50;

    setState(() {
      _predictionResult = isDiabetic;
      _predictionPercent = percent;
    });

    PredictionResult.show(
        context, isDiabetic, percent, glucosePercent, hba1cPercent);
  }

  Widget _buildDropdownField(String label, String? selectedValue,
      List<String> options, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: _inputDecoration(label),
      items: options
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select $label' : null,
    );
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      TextInputType? keyboardType,
      Function()? onChanged}) {
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
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Enter your details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
              _buildDropdownField('Gender', _selectedGender, ['Male', 'Female'],
                  (val) => setState(() => _selectedGender = val)),
              const SizedBox(height: 12),
              _buildDropdownField('Smoking', _selectedSmoking, ['Yes', 'No'],
                  (val) => setState(() => _selectedSmoking = val)),
              const SizedBox(height: 12),
              _buildDropdownField(
                  'Hypertension',
                  _selectedHypertension,
                  ['Yes', 'No'],
                  (val) => setState(() => _selectedHypertension = val)),
              const SizedBox(height: 12),
              _buildDropdownField(
                  'Heart Disease',
                  _selectedHeartDisease,
                  ['Yes', 'No'],
                  (val) => setState(() => _selectedHeartDisease = val)),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _glucoseController,
                  label: 'Glucose',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedGlucoseType,
                decoration: _inputDecoration('Glucose Type'),
                items: ['Fasting', 'Random']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGlucoseType = val),
                validator: (value) =>
                    value == null ? 'Please select Glucose Type' : null,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _hba1cController,
                  label: 'HbA1c (%)',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 4,
                    shadowColor: Colors.greenAccent,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      LoadingDialog.show(context);

                      await Future.delayed(const Duration(seconds: 2));

                      LoadingDialog.hide(context);

                      await _simulatePrediction();
                    }
                  },
                  child: const Text('PREDICT',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
