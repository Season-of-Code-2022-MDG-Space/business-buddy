import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectt/wigets/DatabaseMethods.dart';

class ChatSearch extends StatefulWidget {
  const ChatSearch({Key? key}) : super(key: key);

  @override
  State<ChatSearch> createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  TextEditingController messagescontroller = TextEditingController();
  QuerySnapshot<Map<String, dynamic>>? querySnapShot;

  initiateSearch() {
    databaseMethods.getUsers(messagescontroller.text).then((val) {
      setState(() {
        querySnapShot = val;
      });
    });
  }

  Widget SearchResults() {
    return querySnapShot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: querySnapShot!.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                  userEmail: querySnapShot!.docs[index]['email'],
                  userName: querySnapShot!.docs[index]['firstName']);
            })
        : Container(
            child: Text("No results"),
          );
  }

  // ignore: unnecessary_new
  DatabaseMethods databaseMethods = new DatabaseMethods();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Center(child: Text("Search messages")),
          ),
          // ignore: avoid_unnecessary_containers
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                    height: 60,
                    color: Colors.grey[400],
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          controller: messagescontroller,
                          decoration: const InputDecoration(
                              hintText: "Search Users",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        )),
                        InkWell(
                          onTap: () {
                            initiateSearch();
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchResults()
                ],
              ),
            ),
          )),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({required this.userEmail, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(userName, style: TextStyle(color: Colors.amber)),
              Text(
                userEmail,
                style: TextStyle(color: Colors.amber),
              )
            ],
          ),
          SizedBox(
            width: 130,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: Text("Message"),
          )
        ],
      ),
    );
  }
}
