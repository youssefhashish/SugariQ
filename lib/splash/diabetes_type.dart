import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => onSelect(option1),
              child: Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  color: selectedValue == option1
                      ? Color(0xFF00BFA6).withOpacity(0.2)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.r),
                        color: selectedValue == option1
                            ? Color(0xFF00BFA6)
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedValue == option1
                              ? Color(0xFF00BFA6)
                              : Colors.grey,
                          width: 2.w,
                        ),
                      ),
                      child: selectedValue == option1
                          ? Icon(
                              Icons.check,
                              size: 13.sp,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      option1,
                      style: AppTextStyles.buttonText.copyWith(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => onSelect(option2),
              child: Container(
                width: 120.w,
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
                margin: EdgeInsets.only(left: 12.w),
                decoration: BoxDecoration(
                  color: selectedValue == option2
                      ? Color(0xFF00BFA6).withOpacity(0.2)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5.r),
                        color: selectedValue == option2
                            ? Color(0xFF00BFA6)
                            : Colors.transparent,
                        border: Border.all(
                          color: selectedValue == option2
                              ? Color(0xFF00BFA6)
                              : Colors.grey,
                          width: 2.w,
                        ),
                      ),
                      child: selectedValue == option2
                          ? Icon(
                              Icons.check,
                              size: 13.sp,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      option2,
                      style: AppTextStyles.buttonText.copyWith(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
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
          constraints: BoxConstraints(maxWidth: 480.w),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              // Progress Bar
              Positioned(
                top: 60.h,
                left: 68.w,
                child: SizedBox(
                  width: 350.w,
                  height: 6.h,
                  child: CustomPaint(
                    painter: ProgressBarPainter(progress: 0.50),
                  ),
                ),
              ),
              SizedBox(height: 33.h),
              Text(
                'What diabetes type do you have?',
                style: AppTextStyles.heading.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 25.h),
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
                      width: 160.w,
                      height: 60.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 20.w),
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: BoxDecoration(
                        color: selectedType == 'Type 1'
                            ? Color(0xFF00BFA6).withOpacity(0.2)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.r),
                              color: selectedType == 'Type 1'
                                  ? Color(0xFF00BFA6)
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedType == 'Type 1'
                                    ? Color(0xFF00BFA6)
                                    : Colors.grey,
                                width: 2.w,
                              ),
                            ),
                            child: selectedType == 'Type 1'
                                ? Icon(
                                    Icons.check,
                                    size: 13.sp,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Type 1',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontSize: 15.sp,
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
                      width: 160.w,
                      height: 60.h,
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 20.w),
                      margin: EdgeInsets.only(left: 12.w),
                      decoration: BoxDecoration(
                        color: selectedType == 'Type 2'
                            ? Color(0xFF00BFA6).withOpacity(0.2)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5.r),
                              color: selectedType == 'Type 2'
                                  ? Color(0xFF00BFA6)
                                  : Colors.transparent,
                              border: Border.all(
                                color: selectedType == 'Type 2'
                                    ? Color(0xFF00BFA6)
                                    : Colors.grey,
                                width: 2.w,
                              ),
                            ),
                            child: selectedType == 'Type 2'
                                ? Icon(
                                    Icons.check,
                                    size: 13.sp,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Type 2',
                            style: AppTextStyles.buttonText.copyWith(
                              color: Colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              _buildChoiceTile('Smoking', 'Yes', 'No', _selectedSmoking,
                  (val) => setState(() => _selectedSmoking = val)),
              _buildChoiceTile(
                  'Hypertension',
                  'Yes',
                  'No',
                  _selectedHypertension,
                  (val) => setState(() => _selectedHypertension = val)),
              _buildChoiceTile(
                  'Heart Disease',
                  'Yes',
                  'No',
                  _selectedHeartDisease,
                  (val) => setState(() => _selectedHeartDisease = val)),
              _buildChoiceTile(
                  'Glucose Type',
                  'Fasting',
                  'Random',
                  _selectedGlucoseType,
                  (val) => setState(() => _selectedGlucoseType = val)),
              SizedBox(height: 15.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedType == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please select diabetes type')),
                      );
                      return;
                    }
                    await _simulatePrediction();
                    _onSubmit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFA6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: AppTextStyles.buttonText.copyWith(fontSize: 20.sp),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
