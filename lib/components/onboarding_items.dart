import 'package:flutter/material.dart';

import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Health Monitoring",
      descriptions: "24×7 medical help and support",
      image: "assets/image1.jpeg",
      alignment:
          Alignment.lerp(Alignment.centerRight, Alignment.centerLeft, 0.8) ??
              Alignment.center,
    ),
    OnboardingInfo(
      title: "Mental Health",
      descriptions: "healing mental wellness practices and reportings",
      image: "assets/image4.jpeg",
      alignment:
          Alignment.lerp(Alignment.centerRight, Alignment.centerRight, 0.5) ??
              Alignment.center,
    ),
    OnboardingInfo(
      title: "Diet and Nutrition",
      descriptions: "Changes in your diet that suits your health",
      image: "assets/image2.jpeg",
      alignment:
          Alignment.lerp(Alignment.centerRight, Alignment.centerLeft, 0.2) ??
              Alignment.center,
    ),
  ];
}
