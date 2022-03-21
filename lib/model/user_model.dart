import 'package:flutter/material.dart';

class UserModel {
  String? email;
  String? uid;
  String? firstName;
  String? lastName;
  String? age;
  String? city;
  String? state;
  String? country;
  String? contact;
  String? skills;
  String? education;
  String? pastexp;
  String? aboutMe;
  String? workingHr;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.age,
      this.city,
      this.state,
      this.contact,
      this.country,
      this.skills,
      this.education,
      this.pastexp,
      this.aboutMe,
      this.workingHr});
//taking data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        age: map['age'],
        city: map['city'],
        state: map['state'],
        country: map['country'],
        skills: map['skills'],
        contact: map['contact'],
        education: map['education'],
        pastexp: map['pastexp'],
        aboutMe: map['aboutMe'],
        workingHr: map["workingHr"]);
  }
//sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'city': city,
      'state': state,
      'country': country,
      'skills': skills,
      'education': education,
      'pastexp': pastexp,
      'aboutMe': aboutMe,
      'contact': contact,
      "workingHr": workingHr
    };
  }
}
