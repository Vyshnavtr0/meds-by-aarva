import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meds/screens/splash.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Status bar color
    systemNavigationBarColor: Colors.white, // Navigation bar color
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff04A498)),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
