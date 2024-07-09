import 'package:flutter/material.dart';
import 'package:meds/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future<void> NextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/logo.png",
              height: 150,
              width: 150,
            ),
            Spacer(),
            Text(
              "From AARVA",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
