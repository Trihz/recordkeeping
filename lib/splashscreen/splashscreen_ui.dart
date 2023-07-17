import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:recordkeeping/AuthenticationFirebase/auth_widget_tree.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthWidgetTree()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                'RECORD KEEPER',
                textStyle: const TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Horizon',
                    fontWeight: FontWeight.w900),
                colors: [Colors.orange, Colors.purple],
              ),
            ],
            isRepeatingAnimation: true,
          )),
        ),
      ),
    );
  }
}
