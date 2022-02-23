import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  Widget build(BuildContext context) {
    Widget SearchData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ListTile(
                onTap: () {
                  Get.to(UserInfo(),
                      transition: Transition.downToUp,
                      arguments: snapshotData.docs[index]);
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
                subtitle: Text(
                  snapshotData.docs[index]['skills'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          });
    }

    return Scaffold(
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
                })
          ],
          title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Search Profiles",
                hintStyle: TextStyle(color: Colors.white)),
            controller: searchcontroller,
          ),
          backgroundColor: Colors.black,
        ),
        body: isFound
            ? SearchData()
            : Container(
                child: Center(
                  child: Text(
                    "Search Here",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ));
  }
}
