import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectt/model/user_model.dart';

import 'package:projectt/wigets/data_filter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchcontroller = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isFound = false;
  bool citysearch = false;
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Widget SearchData() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshotData.docs.length,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot documents = snapshotData.docs[index];
                if (documents.id == _auth.currentUser!.uid) {
                  return Container(
                    height: 0,
                  );
                }
                return GestureDetector(
                  child: ListTile(
                    minVerticalPadding: 18,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        // DocumentSnapshot documents = snapshotData.docs[index];

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
                                      snapshotData.docs[index]['firstName'] +
                                      " " +
                                      snapshotData.docs[index]['lastName'])),
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
                                      snapshotData.docs[index]['firstName'] +
                                          " " +
                                          snapshotData.docs[index]['lastName'],
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
                                      snapshotData.docs[index]['city'] +
                                          "," +
                                          snapshotData.docs[index]['country'],
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
                                      snapshotData.docs[index]['email'],
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
                                      snapshotData.docs[index]['contact'],
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
                                              snapshotData.docs[index]['skills']
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
                                          snapshotData.docs[index]['education'],
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
                                          snapshotData.docs[index]['education'],
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
                                                    snapshotData.docs[index]
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
                                          snapshotData.docs[index]['firstName'],
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
                                            snapshotData.docs[index]['aboutMe'],
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
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images.download.png'),
                    ),
                    title: Text(
                      snapshotData.docs[index]['firstName'] +
                          ' ' +
                          snapshotData.docs[index]['lastName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              color: Colors.white,
                            ),
                            Text(
                              snapshotData.docs[index]['city'] +
                                  "                         " +
                                  snapshotData.docs[index]['skills']
                                      .toString()
                                      .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              snapshotData.docs[index]['aboutMe']
                                      .toString()
                                      .substring(0, 50) +
                                  "...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isFound = false;
            });
          },
          child: Icon(Icons.clear),
        ),
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
          actions: [
            GetBuilder<DataFilter>(
                init: DataFilter(),
                builder: (val) {
                  return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      val
                          .queryData(searchcontroller.text.toLowerCase())
                          .then((value) {
                        snapshotData = value;
                        setState(() {
                          isFound = true;
                        });
                      });
                    },
                  );
                }),
            GetBuilder<DataFilter>(
                init: DataFilter(),
                builder: (val) {
                  return IconButton(
                    icon: Icon(Icons.location_city),
                    onPressed: () {
                      val.queryData2(searchcontroller.text).then((value) {
                        snapshotData = value;
                        setState(() {
                          isFound = true;
                        });
                      });
                    },
                  );
                }),
          ],
          title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Search By Skills",
                hintStyle: TextStyle(color: Colors.white)),
            controller: searchcontroller,
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            citysearch = true;
                          });
                        },
                        child: Text("Search By City")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Search By Age")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: Text("Search By Working Hours"))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  isFound
                      ? SearchData()
                      : Container(
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(80.0),
                              child: Text(
                                "Search Here",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 40),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ));
  }
}
