import 'package:flutter/material.dart';

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
                    backgroundColor: Colors.green, // Green background color
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
}
