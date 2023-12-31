import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:path/path.dart' as Path;

import '../../../../extensions/global.dart';
import '../../../../extensions/widgets/error_dialog.dart';
import '../../../../extensions/widgets/loading_dialog.dart';
import '../../../../extensions/widgets/reuseable_widget.dart';
import '../../login/view/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _dateTextController = TextEditingController();

  String userImageUrl = "";
  String completeAddress = "";

  // Future<void> _getImage() async {
  //   imageXFile = await _picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     imageXFile;
  //   });
  // }

  Future<void> formValidation() async {
    // if (imageXFile == null) {
    //   showDialog(
    //       context: context,
    //       builder: (c) {
    //         return const ErrorDialog(
    //           message: "Please select an image",
    //         );
    //       });
    // }
    // else {
    if (_passwordTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty &&
        _userNameTextController.text.isNotEmpty) {
      showDialog(
          context: context,
          builder: (c) {
            {
              return const LoadingDialog(
                message: "Registering Account",
              );
            }
          });
      authenticateSellerAndSignUp();

      // String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      // fStorage.Reference reference = fStorage.FirebaseStorage.instance
      //     .ref()
      //     .child('users')
      //     .child(fileName);
      // fStorage.UploadTask uploadTask =
      //     reference.putFile(File(imageXFile!.path));
      // fStorage.TaskSnapshot taskSnapshot =
      //     await uploadTask.whenComplete(() {});
      // await taskSnapshot.ref.getDownloadURL().then((url) {
      //   sellerImageUrl = url;
      // });
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: "Please write complete required full info",
            );
          });
    }
    // }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await fAuth
        .createUserWithEmailAndPassword(
      email: _emailTextController.text.trim(),
      password: _passwordTextController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to homePage
        Route newRoute = MaterialPageRoute(builder: (c) => const MainView());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userUID": currentUser.uid,
      "userEmail": currentUser.email,
      "userName": _userNameTextController.text.trim(),
      "userAvatarUrl": userImageUrl,
      "status": "approved",
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!
        .setString("name", _userNameTextController.text.trim());
    // await sharedPreferences!.setString("photoUrl", userImageUrl);
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
              // InkWell(
              //   onTap: () {
              //     _getImage();
              //   },
              //   child: CircleAvatar(
              //     radius: MediaQuery.of(context).size.width * 0.20,
              //     backgroundColor: Colors.black12,
              //     backgroundImage: imageXFile == null
              //         ? null
              //         : FileImage(File(imageXFile!.path)),
              //     child: imageXFile == null
              //         ? Icon(
              //             Icons.add_photo_alternate,
              //             size: MediaQuery.of(context).size.width * 0.20,
              //             color: Colors.grey,
              //           )
              //         : null,
              //   ),
              // ),
              Text(
                "Create new",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500),
              ),
              Text(
                "Account",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const LoginView()));
                  },
                  child: Text(
                    "Already Registered? Log in here.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  )),

              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField(
                      'User Name', false, true, _userNameTextController),
                  SizedBox(height: 15),
                  Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField(
                      'E-Mail', false, true, _emailTextController),
                  SizedBox(height: 15),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField(
                      'Password', true, true, _passwordTextController),
                  SizedBox(height: 15),
                  Text(
                    "Date of Birth",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  reuseableTextField2('Date of Birth', Icons.date_range, false,
                      true, _dateTextController),
                  signInSignOutButton(context, false, () {
                    formValidation();
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
