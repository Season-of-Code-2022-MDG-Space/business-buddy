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
        color: Colors.deepPurple,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                    margin: EdgeInsets.zero,
                    accountName:
                        Text("${userModel.firstName}${userModel.lastName}"),
                    // ignore: prefer_const_constructors
                    accountEmail: Text("${userModel.email}"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/lap_back5.png"),
                    )
                    // Image.asset("assets/images/lap_back5.jpg"),
                    )),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, "/dash");
              },
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.details,
                color: Colors.white,
              ),
              title: Text(
                "About The App",
                style: TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ActionChip(
                backgroundColor: Colors.redAccent,
                label: Text("Log Out"),
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
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
