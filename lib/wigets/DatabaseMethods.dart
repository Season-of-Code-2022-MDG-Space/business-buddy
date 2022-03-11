import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUsers(String username) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('firstName', isEqualTo: username)
        .get();
  }
}
