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
    onRefresh(FirebaseAuth.instance.currentUser);
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
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
                // if (user!.uid == _auth.currentUser!.uid) {
                //   return Container(height: 0);
                // }if

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Scaffold(
                          // backgroundColor: Colors.black,
                          appBar: AppBar(
                            title: Text("All About " +
                                snapshot.data!.docs[index]['firstName']),
                          ),
                          body: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  child: Image(
                                    image: AssetImage("assets/images/p6.png"),
                                    height: 200,
                                  ),
                                  height: 200,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['firstName'] +
                                          " " +
                                          snapshot.data!.docs[index]
                                              ['lastName'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    SizedBox(
                                      width: 90,
                                    ),
                                    Text(
                                      "Age :" +
                                          " " +
                                          snapshot.data!.docs[index]['age'],
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }));
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
                                  child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['firstName'] +
                                        " " +
                                        snapshot.data!.docs[index]['lastName'],
                                    style: TextStyle(fontSize: 36),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_city),
                                      Text(
                                        snapshot.data!.docs[index]['city'],
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Icon(Icons.cast_for_education),
                                      Text(
                                        snapshot.data!.docs[index]['skills']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['aboutMe']
                                            .toString()
                                            .substring(0, 50) +
                                        "... ",
                                    style: TextStyle(fontSize: 28),
                                  )
                                ],
                              )),
                              Container(
                                width: 250,
                                height: 400,
                                child: ClipRect(
                                  child: Image(
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
