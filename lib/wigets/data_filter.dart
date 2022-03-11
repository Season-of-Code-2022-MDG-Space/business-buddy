import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectt/model/user_model.dart';

class DataFilter extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('skills', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future queryData2(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('city', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future queryData3(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('age', isLessThanOrEqualTo: queryString)
        .get();
  }

  Future queryData4(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('pastexp', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  Future queryData5(String queryString) async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('firstName', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
