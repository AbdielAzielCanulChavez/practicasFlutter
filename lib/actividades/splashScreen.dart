import 'package:flutter/material.dart';
import 'package:pruebaexamen/actividades/login.dart';
import 'dart:async';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        Duration(seconds: 3),
        (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),
          ),
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 500,
        ),
      ),
    );
  }
}

