// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:meetfit_project/Screens/CreateProfile.dart';
import 'package:meetfit_project/Screens/SignUpScreen.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  void start_timer ()
  {
    Timer(
        Duration(seconds: 4),
            (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateProfile("email", "pass")));
          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    start_timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: ColorizeAnimatedTextKit(
            repeatForever: true,
            text: [
              'MeetMeFit',
            ],
            speed: Duration(milliseconds: 500),
            textStyle: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
            colors: [
              Colors.deepOrange,
              Colors.deepOrangeAccent,
            ],
          ),
        ),
      ),
    );
  }
}
