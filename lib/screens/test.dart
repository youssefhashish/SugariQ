/*import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(DiabetesPredictionApp());
}

class DiabetesPredictionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          elevation: 0,
        ),
      ),
      home: DiabetesPredictionScreen(),
    );
  }
}

class DiabetesPredictionScreen extends StatefulWidget {
  @override
  _DiabetesPredictionScreenState createState() =>
      _DiabetesPredictionScreenState();
}

class _DiabetesPredictionScreenState extends State<DiabetesPredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();
  String _predictionResult = '';
  bool _isLoading = false;

  Future<void> _predictDiabetes() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final age = double.parse(_ageController.text);
      final bmi = double.parse(_bmiController.text);
      final glucose = double.parse(_glucoseController.text);

      try {
        // Load the TensorFlow Lite model
        final interpreter =
            await Interpreter.fromAsset('diabetes_prediction_dataset.csv');

        // Prepare input data
        var input = [age, bmi, glucose];
        var output = List.filled(1, 0).reshape([1, 1]);

        // Run inference
        interpreter.run(input, output);

        // Get the prediction result
        final prediction = output[0][0];
        setState(() {
          _predictionResult = prediction >= 0.5
              ? 'High Risk of Diabetes'
              : 'Low Risk of Diabetes';
        });
      } catch (e) {
        setState(() {
          _predictionResult = 'Error: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Diabetes Prediction', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Enter Your Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _bmiController,
                        decoration: InputDecoration(
                          labelText: 'BMI',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your BMI';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: _glucoseController,
                        decoration: InputDecoration(
                          labelText: 'Glucose Level',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.monitor_heart),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your glucose level';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: _predictDiabetes,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Predict',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_predictionResult.isNotEmpty)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Prediction Result',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _predictionResult,
                        style: TextStyle(
                          fontSize: 18,
                          color: _predictionResult.contains('High')
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}*/
