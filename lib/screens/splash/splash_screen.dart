import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (time) {
      print('Time -- ${_timer.tick}');
      print(_timer.tick);

      if (_timer.tick == 5) {
        setState(() {
          animated = true;
        });

        //   _timer.cancel();
      } else if (_timer.tick == 9) {
        _timer.cancel();
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<bool>(
            //fullscreenDialog: true,
            builder: (BuildContext context) => const OnBoardingScreen(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    print('Dispose is called');
    super.dispose();
  }

  bool animated = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4243E6),
                Color(0xff1A1091),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Colors.purple,
          ),
          child: animated ? const Prmt() : const YourBusiness(),
          //  child: animated ? const YourBusiness() : const Prmt(),
        ),
      ),
    );
  }
}

class YourBusiness extends StatelessWidget {
  const YourBusiness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                'PROMOTE',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 68.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -8.0,
                ),
                duration: const Duration(seconds: 8),
                scalingFactor: 0.2,
              ),
            ],
            totalRepeatCount: 0,
            isRepeatingAnimation: false,
            repeatForever: false,
          ),
          AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                'YOUR BUSINESS',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  letterSpacing: 5.7,
                ),
                duration: const Duration(seconds: 8),
                scalingFactor: 0.2,
              ),
            ],
            totalRepeatCount: 0,
            repeatForever: false,
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}

class Prmt extends StatelessWidget {
  const Prmt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                'PRMT',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 68.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -8.0,
                ),
                duration: const Duration(seconds: 9),
                scalingFactor: 0.2,
              ),
            ],
            totalRepeatCount: 0,
            isRepeatingAnimation: false,
            repeatForever: false,
          ),
          AnimatedTextKit(
            animatedTexts: [
              ScaleAnimatedText(
                'YOUR BUSINESS',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  letterSpacing: 1.0,
                ),
                duration: const Duration(seconds: 9),
                scalingFactor: 0.2,
              ),
            ],
            totalRepeatCount: 0,
            repeatForever: false,
            isRepeatingAnimation: false,
          ),
        ],
      ),
    );
  }
}
