import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectt/model/user_model.dart';
import 'package:projectt/wigets/drawer.dart';

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({Key? key}) : super(key: key);

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  CollectionReference profile = FirebaseFirestore.instance.collection('users');

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Search"),
        actions: [
          Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/search");
                  },
                  icon: Icon(Icons.search))),
          Icon(Icons.chat)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: profile.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(15),
                  child: InkWell(
                    onDoubleTap: () {
                      Navigator.pushNamed(context, '/info');
                    },
                    child: Container(
                      child: FittedBox(
                        child: Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(22),
                          shadowColor: Color(0x802196F3),
                          child: Row(
                            children: [
                              Container(
                                  child: Text(
                                      snapshot.data!.docs[index]['firstName'])),
                              Container(
                                width: 250,
                                height: 180,
                                child: ClipRect(
                                  child: Image(
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                        'assets/images/download.png'),
                                    height: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
      drawer: const MyDrawer(),
    );
  }
}
