import 'dart:async';

import 'package:biodiv/ui/login/login_screen.dart';
import 'package:biodiv/ui/navigation/curved_navigation_bar.dart';
import 'package:biodiv/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      startTimer();
    });
  }

  void startTimer() {
    Timer(const Duration(seconds: 2), () {
      checkUserLogin();
    });
  }

  void checkUserLogin() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    if (token != null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const Navigation(
                    pageId: 0,
                  )));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Center(
        child: Image.asset(
          "asset/image/LogoBiodiversity.png",
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
