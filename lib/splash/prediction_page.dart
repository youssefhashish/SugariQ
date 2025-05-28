import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.r)),
      filled: true,
      fillColor: Colors.white,
      labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.sp),
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
      style: TextStyle(fontSize: 14.sp),
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
        title: Text('Diabetes Prediction',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp)),
        backgroundColor: Colors.white,
        elevation: 1.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black54),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: CustomPaint(painter: ProgressBarPainter(progress: 0.25)),
              ),
              SizedBox(height: 20.h),
              Text('Enter your details',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 20.h),
              _buildTextField(
                controller: _weightController,
                label: 'Weight (kg)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              SizedBox(height: 15.h),
              _buildTextField(
                controller: _heightController,
                label: 'Height (cm)',
                keyboardType: TextInputType.number,
                onChanged: _calculateBMI,
              ),
              SizedBox(height: 15.h),
              TextFormField(
                decoration: _inputDecoration('BMI (Auto Calculated)'),
                readOnly: true,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 14.sp),
                controller: TextEditingController(
                    text: _calculatedBMI != null
                        ? _calculatedBMI!.toStringAsFixed(1)
                        : ''),
              ),
              SizedBox(height: 15.h),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                decoration: _inputDecoration('Gender'),
                items: ['Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGender = val),
                validator: (val) => val == null ? 'Please select gender' : null,
              ),
              SizedBox(height: 15.h),
              _buildTextField(
                controller: _glucoseController,
                label: 'Glucose',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              _buildTextField(
                controller: _hba1cController,
                label: 'HbA1c (%)',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15.h),
              _buildTextField(
                controller: _ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 110.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    textStyle:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
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
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
