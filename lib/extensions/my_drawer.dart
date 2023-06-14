import 'package:flutter/material.dart';
import 'package:movie_flutter_application/core/auth/login/view/login_view.dart';
import 'package:movie_flutter_application/core/main/view/main_view.dart';
import 'package:movie_flutter_application/core/profile/profile_view.dart';

import 'global.dart';

// bitklieri sulamak için oluşturulacak bir countdown timer

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [
                // Material(
                //   borderRadius: const BorderRadius.all(Radius.circular(80)),
                //   elevation: 10,
                //   child: Padding(
                //     padding: const EdgeInsets.all(1.0),
                //     child: Container(

                //       child: CircleAvatar(
                //         radius: 52,
                //         backgroundImage: NetworkImage(
                //             sharedPreferences!.getString("photoUrl")!
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                      color: Colors.black, fontSize: 20, fontFamily: "Train"),
                ),
                Text(
                  sharedPreferences!.getString("email")!,
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: "Train"),
                ),
              ],
            ),
          ),

          //body drawer
          Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              runSpacing: 16,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Main",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const MainView()));
                  },
                ),

                ListTile(
                  leading: const Icon(
                    Icons.cloud_circle,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Profile",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const ProfileView()));
                  },
                ),

                //  ListTile(
                //    leading: const Icon(Icons.timer, color: Colors.black,),
                //    title: const Text(
                //      "Bitki Sulama",
                //      style: TextStyle(color: Colors.black),
                //    ),
                //    onTap: ()
                //    {
                //    // Navigator.push(context, MaterialPageRoute(builder: (c)=> TimerPage()));

                //    },
                //  ),

                //  ListTile(
                //    leading: const Icon(Icons.reorder, color: Colors.black,),
                //    title: const Text(
                //      "New Orders",
                //      style: TextStyle(color: Colors.black),
                //    ),
                //    onTap: ()
                //    {

                //    },
                //  ),

                //  const Divider(
                //    height: 0,
                //    color: Colors.grey,

                //    ),
                ListTile(
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: const Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    fAuth.signOut().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => const LoginView()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
