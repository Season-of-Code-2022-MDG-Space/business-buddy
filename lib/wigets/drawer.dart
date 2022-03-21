import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectt/model/user_model.dart';
import 'package:projectt/pages/login_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black54,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: Colors.red),
                padding: const EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName: Text(
                        "${userModel.firstName} " " ${userModel.lastName}"),
                    // ignore: prefer_const_constructors
                    accountEmail: Text("${userModel.email}"),
                    currentAccountPicture: const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/p6.png"),
                    ))),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/dash");
              },
              leading: const Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/about");
              },
              leading: const Icon(
                Icons.details,
                color: Colors.white,
              ),
              title: const Text(
                "About The App",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ActionChip(
                backgroundColor: Colors.redAccent,
                label: const Text("Log Out"),
                onPressed: () {
                  logout(context);
                })
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
