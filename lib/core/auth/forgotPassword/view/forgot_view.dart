import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:movie_flutter_application/core/auth/register/view/register_view.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../extensions/global.dart';
import '../../../../extensions/widgets/error_dialog.dart';
import '../../../../extensions/widgets/loading_dialog.dart';
import '../../../../extensions/widgets/reuseable_widget.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({Key? key}) : super(key: key);

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailTextController.text.trim());
          showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Password reset link sent! Chack your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      
    }
  }

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
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => ForgotView()));
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
                "   Forgot\nPassword",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Text(
                "New Password",
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
                    child: ElevatedButton(
                      onPressed: () {
                        passwordReset();
                      },
                      child: Text(
                        'Send',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.white70;
                            }
                            return Colors.black;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
