import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:movie_flutter_application/core/auth/forgotPassword/view/forgot_view.dart';
import 'package:movie_flutter_application/core/auth/register/view/register_view.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../extensions/global.dart';
import '../../../../extensions/widgets/error_dialog.dart';
import '../../../../extensions/widgets/loading_dialog.dart';
import '../../../../extensions/widgets/reuseable_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  formValidation() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      // login
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const CupertinoAlertDialog(
              title: Text("Lütfen Email/şifre yazın"),
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          {
            return const LoadingDialog(
              message: "Signing Account",
            );
          }
        });

    User? currentUser;
    await fAuth
        .signInWithEmailAndPassword(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
    });
    // Navigator.pop(context);
    //    Navigator.push(
    //        context, MaterialPageRoute(builder: (c) => MainView()));

    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MainView()));
      });
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!
            .setString("email", snapshot.data()!["userEmail"]);
        await sharedPreferences!
            .setString("name", snapshot.data()!["userName"]);
        // await sharedPreferences!
        //     .setString("photoUrl", snapshot.data()!["userAvatarUrl"]);
        Navigator.push(context, MaterialPageRoute(builder: (c) => MainView()));
      } else {
        fAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c) => LoginView()));
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: "No record exists. ",
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.12, 20, 0),
          child: Column(
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontSize: 58, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Text(
                "Sign in to continue",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField(
                      'Email', false, true, _emailTextController),
                  const SizedBox(height: 20),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField(
                      'Password', true, true, _passwordTextController),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ForgotView()));
                        },
                          child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.blue),
                  ))),
                  const SizedBox(height: 40),
                  signInSignOutButton(context, true, () {
                    formValidation();
                  }),
                ],
              ),
              const SizedBox(height: 10),
              signUpOption(context)
            ],
          ),
        ),
      ),
    );
  }
}

Row signUpOption(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "You don't have any account? ",
        style: TextStyle(color: Colors.black),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterView()));
        },
        child: Text(
          "Sign up",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
