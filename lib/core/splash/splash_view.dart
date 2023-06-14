import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_flutter_application/core/auth/login/view/login_view.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';

import '../../extensions/global.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {

      Navigator.push(
            context, MaterialPageRoute(builder: (c) => const LoginView()));
      // if (fAuth.currentUser != null) {
      //   Navigator.push(context, MaterialPageRoute(builder: (c) => const MainView()));
      // } else {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (c) => const LoginView()));
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/movie_logo.png",
                width: 119,
                
              ),
              const SizedBox(
                height: 10,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
