class PredictionData {
  final double weight;
  final double height;
  final double bmi;
  final String gender;
  final String? smoking;
  final String? hypertension;
  final String? heartDisease;
  final double glucose;
  final String? glucoseType;
  final double hba1c;
  final int age;

  PredictionData({
    required this.weight,
    required this.height,
    required this.bmi,
    required this.gender,
    this.smoking,
    this.hypertension,
    this.heartDisease,
    required this.glucose,
    this.glucoseType,
    required this.hba1c,
    required this.age,
  });

  PredictionData copyWith({
    double? weight,
    double? height,
    double? bmi,
    String? gender,
    String? smoking,
    String? hypertension,
    String? heartDisease,
    double? glucose,
    String? glucoseType,
    double? hba1c,
    int? age,
  }) {
    return PredictionData(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      bmi: bmi ?? this.bmi,
      gender: gender ?? this.gender,
      smoking: smoking ?? this.smoking,
      hypertension: hypertension ?? this.hypertension,
      heartDisease: heartDisease ?? this.heartDisease,
      glucose: glucose ?? this.glucose,
      glucoseType: glucoseType ?? this.glucoseType,
      hba1c: hba1c ?? this.hba1c,
      age: age ?? this.age,
    );
  }
}
