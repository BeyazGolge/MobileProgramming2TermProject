import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_application/core/auth/forgotPassword/view/forgot_view.dart';
import 'package:movie_flutter_application/core/auth/login/view/login_view.dart';
import 'package:movie_flutter_application/core/auth/register/view/register_view.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';
import 'package:movie_flutter_application/core/splash/splash_view.dart';

import 'core/search/search_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashView());
  }
}
