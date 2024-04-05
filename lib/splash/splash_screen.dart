import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nation_job_connect/base/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void proceedToNext() {
    Timer(const Duration(seconds: 3), () {
      // Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const MainScreen(
                key: Key("main_screen"),
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    proceedToNext();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff3D3D3D), Colors.black]),
        ),
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: const Stack(
          children: [
            Center(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Text("Nation Job Connect"))),
          ],
        ),
      ),
    );
  }
}
