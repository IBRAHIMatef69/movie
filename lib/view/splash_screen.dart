import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/constnts.dart';
import 'package:movie/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds:4400), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: minDark,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  child: Lottie.asset(
                'assets/animations/lottie.json',
                fit: BoxFit.cover,
              )),
              SizedBox(
                height: 0,
              ),
              TextLiquidFill(
                loadDuration: Duration(seconds: 2),
                text: 'Egy Dead',
                waveColor: light,
                boxBackgroundColor: minDark,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
