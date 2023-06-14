import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../extensions/global.dart';
import '../../extensions/my_drawer.dart';
import '../../extensions/widgets/error_dialog.dart';
import '../../extensions/widgets/loading_dialog.dart';
import '../main/view/main_view.dart';
import 'models/person_model.dart';

class ProfileView extends StatefulWidget {
  final Person? model;
  const ProfileView({super.key, this.model});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String userImageUrl = "";
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation() async {
    showDialog(
        context: context,
        builder: (c) {
          {
            return const LoadingDialog(
              message: "Updating Photo",
            );
          }
        });
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    fStorage.Reference reference =
        fStorage.FirebaseStorage.instance.ref().child('users').child(fileName);
    fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
    fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {
      userImageUrl = url;
      Navigator.pop(context);
      //send user to homePage
      Route newRoute = MaterialPageRoute(builder: (c) => const MainView());
      Navigator.pushReplacement(context, newRoute);
      saveDataToFirestore();
    });

    // }
  }

  Future saveDataToFirestore() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .set({
      "userAvatarUrl": userImageUrl,
    }, SetOptions(merge: true));
    Fluttertoast.showToast(msg: 'Success');

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences!.setString("photoUrl", userImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Builder(builder: (context) {
                        return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.menu));
                      }),
                      Text(
                        sharedPreferences!.getString("name") ?? '',
                        //"Sezin Karagün",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 17),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        sharedPreferences!.getString("photoUrl") ?? ""),
                  )
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(40)),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _getImage();
                    },
                    child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.20,
                      backgroundColor: Colors.black12,
                      backgroundImage: imageXFile == null
                          ? null
                          : FileImage(File(imageXFile!.path)),
                      child: imageXFile == null
                          ? Icon(
                              Icons.add_photo_alternate,
                              size: MediaQuery.of(context).size.width * 0.20,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    sharedPreferences!.getString("name") ?? '',
                    //widget.model!.userName!,
                    style: const TextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    sharedPreferences!.getString("email") ?? '',
                    // widget.model!.userEmail!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        formValidation();
                      },
                      child: Text("Update"))
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
            )

            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: StreamBuilder(
            //         stream: FirebaseFirestore.instance
            //             .collection("sellers")
            //             .doc(sharedPreferences!.getString('uid'))
            //             .collection("menus")
            //             .doc(widget.model!.menuID)
            //             .collection("items")
            //             .snapshots(),
            //         builder: (context, snapshot) {
            //           return !snapshot.hasData
            //               ? Padding(
            //                   padding: EdgeInsets.all(0),
            //                   child: circularProgress(),
            //                 )
            //               : Container(
            //                   padding: EdgeInsets.only(top: 15, bottom: 40),
            //                   width: MediaQuery.of(context).size.width,
            //                   child: ListView.builder(
            //                       shrinkWrap: true, //important
            //                       physics: NeverScrollableScrollPhysics(),
            //                       itemCount: snapshot.data!.docs.length,
            //                       itemBuilder: (context, index) {
            //                         Items model = Items.fromJson(
            //                             snapshot.data!.docs[index].data());
            //                         return ItemsCardDesign(
            //                           model: model,
            //                           context: context,
            //                         );
            //                       }),
            //                 );
            //         }),
            //   ),
          ],
        ),
      ),
    );
  }
}
