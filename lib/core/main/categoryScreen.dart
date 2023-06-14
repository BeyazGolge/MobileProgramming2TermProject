import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_flutter_application/core/main/models/category_model.dart';

import '../../extensions/global.dart';

class CategoryScreen extends StatefulWidget {
  final Category? model;
  const CategoryScreen({super.key, this.model});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? userImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/romantikkomedi2.webp?alt=media&token=8d06b7d1-c673-493c-9b69-d44450583b3a&_gl=1*ai5mqe*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NTkxODMuMC4wLjA.";

  Future saveDataToFirestore() async {
    FirebaseFirestore.instance
        .collection("favorite")
        .doc(sharedPreferences!.getString("uid"))
        .set({
      "imgUrl": userImageUrl,
    }, SetOptions(merge: true));
    Fluttertoast.showToast(msg: 'Success');

    //save data locally
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        saveDataToFirestore();
                      },
                      icon: Icon(Icons.favorite_outline_outlined))
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(40)),
      ),
      // appBar: AppBar(
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(),
      //   ),
      //   title: Text(
      //     sharedPreferences!.getString("name") ?? 'Null',
      //   ),
      //   centerTitle: true,

      // ),
      //drawer: const MyDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.model!.imgUrl!),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      widget.model!.name.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ), //textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: Text(
                      widget.model!.subject.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ), //textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

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
