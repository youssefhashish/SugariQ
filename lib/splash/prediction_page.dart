/*import 'package:flutter/material.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pregnanciesController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();
  final TextEditingController _insulinController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _pregnanciesController.dispose();
    _glucoseController.dispose();
    _insulinController.dispose();
    _bmiController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Widget _buildRichTextHint(String part1, String part2Green) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600]), // Default style for hint text
        children: <TextSpan>[
          TextSpan(text: part1),
          TextSpan(
              text: part2Green,
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Prediction',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black54),
            onPressed: () {
              // Handle share action
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0.5, // Subtle elevation
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100], // Light grey background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 24.0),
                child: Text(
                  'We need some information to predict your diabetes risk',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              _buildTextField(
                  controller: _pregnanciesController,
                  parameterName: 'Pregnancies',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _glucoseController,
                  parameterName: 'Glucose',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _insulinController,
                  parameterName: 'Insulin',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _bmiController,
                  parameterName: 'BMI',
                  keyboardType: TextInputType.numberWithOptions(decimal: true)),
              const SizedBox(height: 12),
              _buildTextField(
                  controller: _ageController,
                  parameterName: 'Age',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity, // Ensure button is full width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, 
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                      // Example: print('Pregnancies: ${_pregnanciesController.text}');
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

  Widget _buildTextField(
      {required TextEditingController controller,
      required String parameterName,
      TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: '', // Placeholder for RichText, actual hint is RichText
        hintStyle: TextStyle(color: Colors.grey[600]),
        floatingLabelBehavior: FloatingLabelBehavior
            .never, // To prevent label from appearing on top
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 10.0, top: 15.0, bottom: 15.0),
          child: _buildRichTextHint('Enter value for ', parameterName),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value for $parameterName';
        }
        if (keyboardType == TextInputType.number ||
            (keyboardType?.decimal ?? false)) {
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
        }
        return null;
      },
    );
  }
}*/

/*import 'package:flutter/material.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                  'We need some information to predict your diabetes risk',
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

    _simulatePrediction(); 
  }
}
,
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

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Predicting your result...",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}*/

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

  double? _calculatedBMI;

  bool? _predictionResult;

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

    final isDiabetic = glucose > 125 || hba1c > 6.5;

    setState(() {
      _predictionResult = isDiabetic;
    });

    PredictionResult.show(context, isDiabetic);
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
