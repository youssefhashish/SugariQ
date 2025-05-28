import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sugar_iq/screens/login.dart';
import '../components/onboarding_items.dart';
import '../widgets/app_theme.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: isLastPage ? AppTheme.primary : Colors.white,
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SmoothPageIndicator(
                        controller: pageController,
                        count: controller.items.length,
                        onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn,
                        ),
                        effect: WormEffect(
                          dotHeight: 12.h,
                          dotWidth: 12.w,
                          activeDotColor: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      TextButton(
                        onPressed: () => pageController
                            .jumpToPage(controller.items.length - 1),
                        child: Text(
                          "Skip",
                          style:
                              TextStyle(color: Colors.black, fontSize: 17.sp),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppTheme.buttonColor,
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: TextButton(
                      onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn,
                      ),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white, fontSize: 17.sp),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      body: Container(
        color: isLastPage ? AppTheme.primary : Colors.white,
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    controller.items[index].image,
                    height: 660.h,
                    width: 400.w,
                    fit: BoxFit.cover,
                    alignment: controller.items[index].alignment,
                  ),
                ],
              );
            }),
      ),
    );
  }

  // one time onboarding
  Widget getStarted() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .7,
        child: TextButton(
          onPressed: () async {
            final pres = await SharedPreferences.getInstance();
            pres.setBool("Login", true);

            //After we press get started button this onboarding value become true
            // same key
            if (!mounted) return;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LogInScreen()));
          },
          child: Text(
            "Get started",
            style: TextStyle(
                color: AppTheme.primary,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
