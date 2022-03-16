import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ABOUT US"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            children: [
              Card(
                  child: Row(
                children: const [
                  Icon(Icons.star),
                  Flexible(
                    child: Text(
                      "Business Buddy  is the most trusted network, enabling you to instantly and easily build  connections and find the right partner .",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )),
              Card(
                child: Row(
                  children: const [
                    Icon(Icons.star),
                    Flexible(
                      child: Text(
                        " It Helps To Find a perfect partner by going through millions of business connections and opportunities .",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: const [
                    Icon(Icons.star),
                    Flexible(
                      child: Text(
                        "Take the first step and start social networking to build connections, and find career opportunities. Filter through millions of Businesses instantly to find the right ones for you .",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: const [
                    Icon(Icons.star),
                    Flexible(
                      child: Text(
                        "Gain valuable workplace insights from your business connections and business news. Connect with companies, industry experts, and the Business Buddy community to understand what can give you the edge in the Business search. Get salary insights on potential careers and learn even more from your business network. ",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                  radius: 150,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  child: Image(image: AssetImage("assets/images/bb_logo.jpg")))
            ],
          ),
        ));
  }
}
