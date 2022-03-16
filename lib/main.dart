import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectt/pages/ChatRoom.dart';
import 'package:projectt/pages/about_app.dart';
import 'package:projectt/pages/chat_search.dart';

import 'package:projectt/pages/dashboard_board.dart';
import 'package:projectt/pages/login_page.dart';
import 'package:projectt/pages/reg_page.dart';
import 'package:projectt/pages/search_page.dart';
import 'package:projectt/pages/suggestion_page.dart';

import './pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Page",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      // home: LoginScreen(),
      routes: {
        "/": (context) => const LoginScreen(),
        "/home": (context) => const MyHomePage(),
        "/reg": (context) => const RegScreen(),
        "/login": (context) => const LoginScreen(),
        "/dash": (context) => const Dashboard(),
        "/sugg": (context) => const SuggestionPage(),
        "/search": (context) => const SearchPage(),
        "/about": (context) => const AboutApp(),
        "/chatUsers": (context) => const ChatsSearch(),
      },
    );
  }
}
