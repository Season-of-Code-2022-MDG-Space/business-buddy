import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                DocumentSnapshot documents = snapshot.data!.docs[index];
                if (documents.id == _auth.currentUser!.uid) {
                  return Container(
                    height: 0,
                  );
                }
                // if (user!.uid == _auth.currentUser!.uid) {
                //   return Container(height: 0);
                // }if

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                            appBar: AppBar(
                              leading: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              title: Center(
                                  child: Text("All About" +
                                      " " +
                                      snapshot.data!.docs[index]['firstName'] +
                                      " " +
                                      snapshot.data!.docs[index]['lastName'])),
                              backgroundColor: Colors.purple,
                            ),
                            body: SingleChildScrollView(
                              child: SafeArea(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/t.png"),
                                              fit: BoxFit.cover)),
                                      child: Container(
                                        width: double.infinity,
                                        height: 130,
                                        child: Container(
                                          alignment: Alignment(0.0, 2.5),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "Add you profile DP image URL here "),
                                            radius: 60.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['firstName'] +
                                          " " +
                                          snapshot.data!.docs[index]
                                              ['lastName'],
                                      style: TextStyle(
                                          fontSize: 35.0,
                                          color:
                                              Color.fromARGB(255, 10, 10, 10),
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['city'] +
                                          "," +
                                          snapshot.data!.docs[index]['country'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black45,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['email'],
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black45,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['contact'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black45,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 8.0),
                                        elevation: 2.0,
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 30),
                                            child: Text(
                                              snapshot
                                                  .data!.docs[index]['skills']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  letterSpacing: 2.0,
                                                  fontWeight: FontWeight.w900),
                                            ))),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "        #   " +
                                          snapshot.data!.docs[index]
                                              ['education'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromARGB(115, 176, 11, 218),
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "          & " +
                                          snapshot.data!.docs[index]
                                              ['education'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color:
                                              Color.fromARGB(115, 236, 11, 225),
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Age",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[index]
                                                        ['age'],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Profile Views",
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Text(
                                                    "2000",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 22.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "About" +
                                          " " +
                                          snapshot.data!.docs[index]
                                              ['firstName'],
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 228, 21, 21),
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Ink(
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['aboutMe'],
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontSize: 20),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.deepPurple),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            floatingActionButton: FloatingActionButton(
                              onPressed: () {},
                              child: Icon(Icons.chat),
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
