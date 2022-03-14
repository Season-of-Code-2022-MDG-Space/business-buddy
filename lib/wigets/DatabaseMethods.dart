import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUsers(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('firstName', isEqualTo: username)
        .get();
  }

  getUserbyUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
  }

  // createChatRoom(String chatRoomId, chatRoomMap) {
  //   FirebaseFirestore.instance
  //       .collection('ChatRoom')
  //       .doc(chatRoomId)
  //       .set(chatRoomMap)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }
}
