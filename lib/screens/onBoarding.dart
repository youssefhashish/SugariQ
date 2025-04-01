import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sugar_iq/screens/login.dart';
import '../components/onboarding_items.dart';

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
        color: Colors.grey[900],
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    //Indicator
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
                        activeDotColor: Color(0xFF6FBE5A),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //Skip Button
                    TextButton(
                        onPressed: () => pageController
                            .jumpToPage(controller.items.length - 1),
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                  ]),

                  //Next Button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xFF6FBE5A),
                    ),
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
        color: Colors.grey[900],
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
                    height: 653,
                    width: 400,
                    fit: BoxFit.cover,
                    alignment: controller.items[index].alignment,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 5),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(color: Colors.grey, fontSize: 17),
                      textAlign: TextAlign.left),
                ],
              );
            }),
      ),
    );
  }

  // one time onboarding

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFF6FBE5A),
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
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
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
