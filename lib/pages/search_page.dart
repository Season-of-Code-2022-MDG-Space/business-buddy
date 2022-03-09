import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectt/model/user_model.dart';
import 'package:projectt/pages/user_info.dart';
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
                return GestureDetector(
                  child: ListTile(
                    minVerticalPadding: 18,
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        DocumentSnapshot documents = snapshotData.docs[index];
                        if (documents.id == _auth.currentUser!.uid) {
                          return Container(
                            height: 0,
                          );
                        }
                        return Scaffold(
                          // backgroundColor: Colors.black,
                          appBar: AppBar(
                            title: Text("All About " +
                                snapshotData.docs[index]['firstName']),
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
                                      snapshotData.docs[index]['firstName'] +
                                          " " +
                                          snapshotData.docs[index]['lastName'],
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
                                          snapshotData.docs[index]['age'],
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

    // Widget SearchCity() {
    //   return ListView.builder(
    //       itemCount: snapshotData.docs.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return GestureDetector(
    //           child: ListTile(
    //             onTap: () {
    //               Get.to(UserInfo(),
    //                   transition: Transition.downToUp,
    //                   arguments: snapshotData.docs[index]);
    //             },
    //             leading: CircleAvatar(
    //               backgroundImage: AssetImage('assets/images.download.png'),
    //             ),
    //             title: Text(
    //               snapshotData.docs[index]['firstName'] +
    //                   ' ' +
    //                   snapshotData.docs[index]['lastName'],
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //             subtitle: Row(
    //               children: [
    //                 Icon(
    //                   Icons.location_city,
    //                   color: Colors.white,
    //                 ),
    //                 Text(
    //                   snapshotData.docs[index]['city'] +
    //                       "                         " +
    //                       snapshotData.docs[index]['skills']
    //                           .toString()
    //                           .toUpperCase(),
    //                   style: TextStyle(
    //                       color: Colors.white,
    //                       fontSize: 12,
    //                       fontWeight: FontWeight.bold),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    // }

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
