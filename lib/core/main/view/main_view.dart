import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_application/core/main/models/category_model.dart';
import 'package:movie_flutter_application/core/search/search_view.dart';
import 'package:movie_flutter_application/extensions/global.dart';
import 'package:movie_flutter_application/extensions/my_drawer.dart';

import '../../../extensions/widgets/category_design_widget.dart';
import '../../auth/login/view/login_view.dart';
import '../../profile/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

final TextEditingController _searchController = TextEditingController();

class _MainViewState extends State<MainView> {
  List symptoms = [
    "Domates",
    "Fesleğen",
    "Gül",
    "Lale",
    "Biber",
    "Nergiz",
    "Karpuz",
    "Kabak",
  ];
  List img = [
    "d1.jpg",
    "d2.jpg",
    "d3.jpg",
    "d4.jpg",
    "d5.jpg",
    "d6.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
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
                          sharedPreferences!.getString("name") ?? 'Null',
                          //"Sezin Karagün",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => const ProfileView()));
                        },
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                sharedPreferences!.getString("photoUrl") ??
                                    "")))
                  ],
                ),
              ),
              preferredSize: const Size.fromHeight(40)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const SearchView()));
                  },
                  child: TextField(
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      color: Colors.black54.withOpacity(0.8),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      labelStyle:
                          TextStyle(color: Colors.grey.withOpacity(0.7)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white,

                      //prefixIcon: const Icon(Icons.search),
                      suffixIcon: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SearchView()));
                          },
                          child: const Icon(Icons.search)),

                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'My Collection',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("favorite")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Padding(
                                  padding: EdgeInsets.all(0),
                                  child: LinearProgressIndicator(),
                                )
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true, //important
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Category model = Category.fromJson(
                                            snapshot.data!.docs[index].data());
                                        return CategoryDesignWidget(
                                          model: model,
                                          context: context,
                                        );
                                      }),
                                );
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Comedy Movies',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Comedy")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Padding(
                                  padding: EdgeInsets.all(0),
                                  child: LinearProgressIndicator(),
                                )
                              : Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true, //important
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Category model = Category.fromJson(
                                            snapshot.data!.docs[index].data());
                                        return CategoryDesignWidget(
                                          model: model,
                                          context: context,
                                        );
                                      }),
                                );
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Romantic Movies',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("romantic")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Padding(
                                  padding: EdgeInsets.all(0),
                                  child: LinearProgressIndicator(),
                                )
                              : Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true, //important
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Category model = Category.fromJson(
                                            snapshot.data!.docs[index].data());
                                        return CategoryDesignWidget(
                                          model: model,
                                          context: context,
                                        );
                                      }),
                                );
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Action&Adventure Movies',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("action")
                            .snapshots(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? Padding(
                                  padding: EdgeInsets.all(0),
                                  child: LinearProgressIndicator(),
                                )
                              : Container(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true, //important
                                      physics: BouncingScrollPhysics(),
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        Category model = Category.fromJson(
                                            snapshot.data!.docs[index].data());
                                        return CategoryDesignWidget(
                                          model: model,
                                          context: context,
                                        );
                                      }),
                                );
                        }),
                  ),
                ],
              )
            ],
          ),
        ));
    // child: ElevatedButton(
    //     onPressed: () {
    //       fAuth.signOut();
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (c) => const LoginView()));
    //     },
    //     child: Text("Sign out")),
  }
}
