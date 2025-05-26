import 'package:flutter/material.dart';
import '../components/prediction_data.dart';
import '../widgets/app_theme.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/prediction_result.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/text_style.dart';
import 'prediction_page.dart';

class DiabetesTypeScreen extends StatefulWidget {
  final PredictionData predictionData;

  const DiabetesTypeScreen({super.key, required this.predictionData});

  static String? selectedDiabetesType;

  @override
  _DiabetesTypeScreenState createState() => _DiabetesTypeScreenState();
}

class _DiabetesTypeScreenState extends State<DiabetesTypeScreen> {
  String? selectedType;
  String? _selectedSmoking;
  String? _selectedHypertension;
  String? _selectedHeartDisease;
  String? _selectedGlucoseType;
  bool? _predictionResult;
  double? _predictionPercent;

  Widget _buildChoiceTile(String title, String option1, String option2,
      String? selectedValue, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onSelect(option1),
              child: Container(
                width: 120,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: selectedValue == option1
                      ? Color(0xFF00BFA6).withOpacity(0.2)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: selectedValue == option1
                            ? Color(0xFF00BFA6)
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedValue == option1
                              ? Color(0xFF00BFA6)
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: selectedValue == option1
                          ? const Icon(
                              Icons.check,
                              size: 13,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      option1,
                      style: AppTextStyles.buttonText.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onSelect(option2),
              child: Container(
                width: 120,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                margin: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: selectedValue == option2
                      ? Color(0xFF00BFA6).withOpacity(0.2)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        color: selectedValue == option2
                            ? Color(0xFF00BFA6)
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedValue == option2
                              ? Color(0xFF00BFA6)
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: selectedValue == option2
                          ? const Icon(
                              Icons.check,
                              size: 13,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      option2,
                      style: AppTextStyles.buttonText.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _onSubmit() {
    if (_selectedSmoking == null ||
        _selectedHypertension == null ||
        _selectedHeartDisease == null ||
        _selectedGlucoseType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions')),
      );
      return;
    }

    final updatedData = widget.predictionData.copyWith(
      smoking: _selectedSmoking!,
      hypertension: _selectedHypertension!,
      heartDisease: _selectedHeartDisease!,
      glucoseType: _selectedGlucoseType!,
    );
  }

  Future<void> _simulatePrediction() async {
    final gender = widget.predictionData.gender;
    final age = widget.predictionData.age;
    final bmi = widget.predictionData.bmi;
    final glucose = widget.predictionData.glucose;
    final hba1c = widget.predictionData.hba1c;

    final smoking = _selectedSmoking ?? widget.predictionData.smoking;
    final hypertension =
        _selectedHypertension ?? widget.predictionData.hypertension;
    final heartDisease =
        _selectedHeartDisease ?? widget.predictionData.heartDisease;
    final glucoseType =
        _selectedGlucoseType ?? widget.predictionData.glucoseType;
    final diabetesType =
        selectedType ?? DiabetesTypeScreen.selectedDiabetesType;

    double glucosePercent = 0;
    double hba1cPercent = 0;

    if (glucoseType == 'Fasting') {
      if (glucose < 100) {
        glucosePercent = 5;
      } else if (glucose < 126) {
        glucosePercent = 40;
      } else {
        glucosePercent = 90;
      }
    } else if (glucoseType == 'Random') {
      if (glucose < 140) {
        glucosePercent = 5;
      } else if (glucose < 200) {
        glucosePercent = 40;
      } else {
        glucosePercent = 90;
      }
    }

    if (hba1c < 5.7) {
      hba1cPercent = 5;
    } else if (hba1c < 6.5) {
      hba1cPercent = 40;
    } else {
      hba1cPercent = 90;
    }

    double risk = ((glucosePercent + hba1cPercent) / 2);

    if (gender == 'Male') risk += 2;

    if (age > 45) {
      risk += 5;
    } else if (age > 30) {
      risk += 2;
    }

    if (smoking == 'Yes') risk += 5;

    if (hypertension == 'Yes') risk += 5;

    if (heartDisease == 'Yes') risk += 5;

    if (bmi > 30)
      risk += 5;
    else if (bmi > 25) risk += 2;

    if (diabetesType == 'Type 2') risk += 3;

    risk = risk.clamp(0, 99);

    final isDiabetic = risk >= 50;

    setState(() {
      _predictionResult = isDiabetic;
      _predictionPercent = risk;
      selectedType = diabetesType;
      PredictionScreen.lastDiabetesType = selectedType;
      DiabetesTypeScreen.selectedDiabetesType = selectedType;
    });

    PredictionResult.show(
        context, isDiabetic, risk, glucosePercent, hba1cPercent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 480),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              // Progress Bar
              Positioned(
                top: 60,
                left: 68,
                child: SizedBox(
                  width: 350,
                  height: 6,
                  child: CustomPaint(
                    painter: ProgressBarPainter(progress: 0.50),
                  ),
                ),
              ),
              const SizedBox(height: 33),
              const Text(
                'What diabetes type do you have?',
                style: AppTextStyles.heading,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = 'Type 1';
                      });
                    },
                    child: Container(
                      width: 160,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: selectedType == 'Type 1'
                            ? Color(0xFF00BFA6).withOpacity(0.2)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              color: selectedType == 'Type 1'
                                  ? Color(0xFF00BFA6)
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedType == 'Type 1'
                                    ? Color(0xFF00BFA6)
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: selectedType == 'Type 1'
                                ? const Icon(
                                    Icons.check,
                                    size: 13,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Type 1',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = 'Type 2';
                      });
                    },
                    child: Container(
                      width: 160,
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      margin: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        color: selectedType == 'Type 2'
                            ? Color(0xFF00BFA6).withOpacity(0.2)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              color: selectedType == 'Type 2'
                                  ? Color(0xFF00BFA6)
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedType == 'Type 2'
                                    ? Color(0xFF00BFA6)
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: selectedType == 'Type 2'
                                ? const Icon(
                                    Icons.check,
                                    size: 13,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Type 2',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: null, // Disable tap for "Gestational"
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200, // Disabled appearance
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Gestational',
                        style: AppTextStyles.buttonText
                            .copyWith(color: Colors.grey),
                      ),
                      const Spacer(),
                      Text(
                        'Coming Soon!',
                        style: AppTextStyles.subtitle
                            .copyWith(color: AppTheme.primary, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  _buildChoiceTile(
                      "Do you smoke?",
                      "Yes",
                      "No",
                      _selectedSmoking,
                      (val) => setState(() => _selectedSmoking = val)),
                  _buildChoiceTile(
                      "Do you have hypertension?",
                      "Yes",
                      "No",
                      _selectedHypertension,
                      (val) => setState(() => _selectedHypertension = val)),
                  _buildChoiceTile(
                      "Do you have heart disease?",
                      "Yes",
                      "No",
                      _selectedHeartDisease,
                      (val) => setState(() => _selectedHeartDisease = val)),
                  _buildChoiceTile(
                      "What is the glucose type?",
                      "Fasting",
                      "Random",
                      _selectedGlucoseType,
                      (val) => setState(() => _selectedGlucoseType = val)),
                ],
              ),

              const Spacer(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 32),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppTheme.primary,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      DiabetesTypeScreen.selectedDiabetesType = selectedType;
                      LoadingDialog.show(context);

                      await Future.delayed(const Duration(seconds: 2));

                      LoadingDialog.hide(context);

                      await _simulatePrediction();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 44,
                        vertical: 20,
                      ),
                    ),
                    child: const Text(
                      'PREDICT',
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(String title, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: selected ? AppTheme.primary : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
