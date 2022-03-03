 import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
   import 'package:movie/view/splash_screen.dart';


void main() async{
   runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override



  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Egy Dead',
      theme: ThemeData(backgroundColor: Color(0xff203239),
        primarySwatch: Colors.grey,
      ),
      home:SplashScreen(),
    );
  }
}

