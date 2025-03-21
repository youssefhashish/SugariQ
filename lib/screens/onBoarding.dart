import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: OnBoardingSlider(
        pageBackgroundColor: Color.fromARGB(92, 95, 183, 148),
        headerBackgroundColor: Color(0xFF5FB794),
        finishButtonText: 'Get Started',
        onFinish: () {
          Navigator.pushNamed(context, '/splash');
        },
        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Color(0xFF85C26F),
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        skipFunctionOverride: () {
          Navigator.pushNamed(context, '/login');
        },
        trailing: Text('Login'),
        trailingFunction: () {
          Navigator.pushNamed(context, '/login');
        },
        background: [
          Image.asset(
            'assets/image1.jpeg',
            fit: BoxFit.cover,
            height: 624,
            width: 414,
          ),
          Image.asset(
            'assets/image4.jpeg',
            fit: BoxFit.cover,
            height: 624,
            width: 414,
          ),
          Image.asset(
            'assets/image2.jpeg',
            fit: BoxFit.cover,
            height: 624,
            width: 414,
          ),
        ],
        totalPage: 3,
        speed: 1.8,
        pageBodies: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 500,
                ),
                Text(
                  '24×7 medical help and support',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 500,
                ),
                Text(
                  'healing mental wellness practices and reportings',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 500,
                ),
                Text(
                  'Changes in your diet that suits your health',
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
