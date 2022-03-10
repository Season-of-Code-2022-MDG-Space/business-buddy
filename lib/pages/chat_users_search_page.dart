import 'package:flutter/material.dart';

class ChatSearch extends StatefulWidget {
  const ChatSearch({Key? key}) : super(key: key);

  @override
  State<ChatSearch> createState() => _ChatSearchState();
}

class _ChatSearchState extends State<ChatSearch> {
  final messagescontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search messages"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: messagescontroller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(prefixIcon: Icon(Icons.message)),
          ),
        ),
      ),
    );
  }
}
