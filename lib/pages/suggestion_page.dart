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
  Query<Map<String, dynamic>> profile =
      FirebaseFirestore.instance.collection('users').orderBy("skills");

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
        title: const Text("Search"),
        actions: [
          Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/search");
                  },
                  icon: const Icon(Icons.search))),
          const SizedBox(
            width: 20,
          ),
          InkWell(
            child: const Icon(
              Icons.chat,
            ),
            onTap: () {
              Navigator.pushNamed(context, "/chatUsers");
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: profile.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
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

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                            appBar: AppBar(
                              leading: IconButton(
                                icon: const Icon(
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
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/t.png"),
                                                fit: BoxFit.cover)),
                                        child: Container(
                                          width: double.infinity,
                                          height: 130,
                                          child: Container(
                                            alignment:
                                                const Alignment(0.0, 2.5),
                                            child: const CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/images/download.png "),
                                              radius: 60.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                                ['firstName'] +
                                            " " +
                                            snapshot.data!.docs[index]
                                                ['lastName'],
                                        style: const TextStyle(
                                            fontSize: 35.0,
                                            color:
                                                Color.fromARGB(255, 10, 10, 10),
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Text(
                                        snapshot.data!.docs[index]['city'] +
                                            "," +
                                            snapshot.data!.docs[index]
                                                ['country'],
                                        style: const TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black45,
                                            letterSpacing: 2.0,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Email" + " :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['email'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   snapshot.data!.docs[index]['email'],
                                      //   style: const TextStyle(
                                      //       fontSize: 15.0,
                                      //       color: Colors.black45,
                                      //       letterSpacing: 2.0,
                                      //       fontWeight: FontWeight.w600),
                                      // ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Contact" + " :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['contact'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Business Field" + " :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot
                                                    .data!.docs[index]['skills']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Education" + " :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['education'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  "Past Exp." + " :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['pastexp'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        height: 44,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Daily Working Hours" + " :",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[index]
                                                    ['workingHr'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Card(
                                        margin: const EdgeInsets.symmetric(
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
                                                    const Text(
                                                      "Age",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blueAccent,
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                      snapshot.data!.docs[index]
                                                          ['age'],
                                                      style: const TextStyle(
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
                                                  children: const [
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
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "About" +
                                            " " +
                                            snapshot.data!.docs[index]
                                                ['firstName'],
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 228, 21, 21),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Ink(
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['aboutMe'],
                                              style: const TextStyle(
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
                            ),
                            floatingActionButton: FloatingActionButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "/chatUsers");
                              },
                              child: const Icon(Icons.chat),
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
                          shadowColor: const Color(0x802196F3),
                          child: Row(
                            children: [
                              Container(
                                  child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['firstName'] +
                                        " " +
                                        snapshot.data!.docs[index]['lastName'],
                                    style: const TextStyle(fontSize: 36),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_city),
                                      Text(
                                        snapshot.data!.docs[index]['city'],
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Icon(Icons.cast_for_education),
                                      Text(
                                        snapshot.data!.docs[index]['skills']
                                            .toString()
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['aboutMe']
                                            .toString()
                                            .substring(0, 50) +
                                        "... ",
                                    style: const TextStyle(fontSize: 28),
                                  )
                                ],
                              )),
                              Container(
                                width: 250,
                                height: 400,
                                child: const ClipRect(
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
