import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_application/core/main/models/category_model.dart';
import 'package:movie_flutter_application/extensions/global.dart';
import 'package:movie_flutter_application/extensions/my_drawer.dart';
import 'package:movie_flutter_application/extensions/widgets/all_category_widget.dart';

import '../../../extensions/widgets/category_design_widget.dart';
import '../profile/profile_view.dart';
import 'models/search_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

final TextEditingController _searchController = TextEditingController();

class _SearchViewState extends State<SearchView> {
  static List<SearchModel> movies_list = [
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/issizadam.jpeg?alt=media&token=9c7e2c11-f070-4d8c-9dc6-390e002679ee&_gl=1*1vmi7ed*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjA1NDguMC4wLjA.",
        name: "issiz adam"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/anamujdemiisterim.jpeg?alt=media&token=20a34fd2-d565-4ab6-b2f0-2fb299dad002&_gl=1*1govpv*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY4Nzk2My4yNS4xLjE2ODY2ODgxMzIuMC4wLjA.",
        name: "müjdemi isterim"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/aaathetomorrowwar.jpeg?alt=media&token=8f49bdad-ee6a-4899-aca8-604a3300f2bb&_gl=1*11n2fc8*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjExMzMuMC4wLjA.",
        name: "The Tomorrow War"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/aaaedgeoftomorrow.webp?alt=media&token=3e362fec-2bda-4c4e-8de4-1cbb826ac849&_gl=1*n3nda1*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjExMTMuMC4wLjA..webp",
        name: "edge of tomorrow"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/aaauncharted.webp?alt=media&token=be92c8af-82af-418b-935a-af9b54d4530c&_gl=1*1formvk*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjExNzYuMC4wLjA.",
        name: "Unchared"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/anainceisler.jpeg?alt=media&token=d37f71ef-f314-4dff-89bd-196f4885b76c&_gl=1*15ljhcm*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY4Nzk2My4yNS4xLjE2ODY2ODgwMTAuMC4wLjA.",
        name: "ince işler"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/askinkiyameti.webp?alt=media&token=34499a98-ed73-4045-908b-070f65fce220&_gl=1*g27etm*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjA0NzcuMC4wLjA.",
        name: "askin kiyameti"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/aaablackwidow.webp?alt=media&token=602b729b-bc26-43a0-95e4-45457b189ec9&_gl=1*5dzp31*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY1NjkyOS4yMC4xLjE2ODY2NjEwNjAuMC4wLjA.",
        name: "Black Widow"),
    SearchModel(
        imgUrl:
            "https://firebasestorage.googleapis.com/v0/b/movieflutterapp-6dd32.appspot.com/o/anasenyasamayabak.jpeg?alt=media&token=4eb2b9b9-61c4-480f-9b26-6a3218043011&_gl=1*1f2pj02*_ga*NDk3MTczNTcyLjE2NzQ1NjM2MjI.*_ga_CW55HF8NVT*MTY4NjY4Nzk2My4yNS4xLjE2ODY2ODgxNjIuMC4wLjA.",
        name: "sen yaşamaya bak"),
  ];

  List<SearchModel> displayList = List.from(movies_list);
  void updateList(String value) {
    setState(() {
      displayList = movies_list
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

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
                                sharedPreferences!.getString("photoUrl")!)))
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
                child: TextField(
                  onChanged: (value) => updateList(value),
                  cursorColor: Colors.grey,
                  style: TextStyle(
                    color: Colors.black54.withOpacity(0.8),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,

                    //prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        )),
                  ),
                  controller: _searchController,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 35.0, right: 35, bottom: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sort by",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Icon(Icons.assessment),
                      ],
                    ),
                    SizedBox(
                      height: 500,
                      child: Container(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true, //important
                          physics: BouncingScrollPhysics(),
                          itemCount: displayList.length,
                          itemBuilder: (context, index) => AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 18, top: 18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                  image:
                                      NetworkImage(displayList[index].imgUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
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
