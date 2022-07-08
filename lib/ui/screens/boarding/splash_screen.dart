
import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:bloctest/ui/screens/boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/Strings.dart';
import '../../../helper/routes.dart';
import '../landing/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AfterLayoutMixin {

  Future<String> updateSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    return "-1";
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    AppRoute.pushReplacement(const BoardingScreen());
    if (seen) {
      AppRoute.pushReplacement(const LandingScreen());
    } else {
      await prefs.setBool('seen', true);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(StringsApp.logo),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async{
    await updateSplash();
    await checkFirstSeen();
  }
}
