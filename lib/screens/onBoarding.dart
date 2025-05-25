import 'package:flutter/material.dart';
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
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    SmoothPageIndicator(
                      controller: pageController,
                      count: controller.items.length,
                      onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () => pageController
                            .jumpToPage(controller.items.length - 1),
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        )),
                  ]),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.buttonColor,
                    ),
                    width: MediaQuery.of(context).size.width * .3,
                    child: TextButton(
                        onPressed: () => pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn),
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
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
                    height: 660,
                    width: 400,
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
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
          child: const Text(
            "Get started",
            style: TextStyle(
                color: AppTheme.primary,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
