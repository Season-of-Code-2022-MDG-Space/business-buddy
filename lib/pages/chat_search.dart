import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectt/pages/ChatRoom.dart';
import 'package:projectt/wigets/DatabaseMethods.dart';

class ChatsSearch extends StatefulWidget {
  const ChatsSearch({Key? key}) : super(key: key);

  @override
  State<ChatsSearch> createState() => _ChatsSearchState();
}

class _ChatsSearchState extends State<ChatsSearch> {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Chat with Users"),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.15,
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: "Search by Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  onPressed: onSearch,
                  child: const Text("Search"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                userMap != null
                    ? InkWell(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser?.displayName ?? ".",
                              userMap!['firstName']);

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatRoom(
                                chatRoomId: roomId,
                                userMap: userMap!,
                              ),
                            ),
                          );
                        },
                        child: Flexible(
                          child: Padding(
                            padding: EdgeInsets.all(8),
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
                                            userMap!['firstName'] +
                                                " " +
                                                userMap!['lastName'],
                                            style:
                                                const TextStyle(fontSize: 36),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_city),
                                              Text(
                                                userMap!['city'],
                                                style: const TextStyle(
                                                    fontSize: 24),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              const Icon(
                                                  Icons.cast_for_education),
                                              Text(
                                                userMap!['skills']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            userMap!['aboutMe']
                                                    .toString()
                                                    .substring(0, 30) +
                                                "... ",
                                            style:
                                                const TextStyle(fontSize: 28),
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
                        ),
                      )
                    : Container(),
              ],
            ),
    );
  }
}
