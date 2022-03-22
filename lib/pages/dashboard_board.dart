import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectt/model/user_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  final _formkey = GlobalKey<FormState>();

  //It is the First Thing that will be called
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.userModel = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final countrycontroller = TextEditingController();
  final skillscontroller = TextEditingController();
  final educationcontroller = TextEditingController();
  final pastexpcontroller = TextEditingController();
  final aboutMecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final TextEditingController _controller = new TextEditingController();
  var items = [
    'Agency',
    'Business Development',
    'Construction/Trade',
    'Consulting',
    'Designer',
    'Developer(App/Web)',
    'Digital Marketing',
    'E-commerce',
    'Finance/Fin tech',
    'Franchise',
    'Marketer',
    'Manufacturing',
    'Merchandise',
    'Product',
    'Retail',
    'Sales',
    'WholeSale',
    'Web Site(new/affiliate)',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: profileview());
  }

  Widget profileview() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    Navigator.pushNamed(context, '/sugg');
                  });
                },
                child: Container(
                  height: 50,
                  width: 50,
                  child:
                      Icon(Icons.arrow_back, size: 24, color: Colors.blue[800]),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'PROFILE',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(height: 24, width: 24)
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 70,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/download.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  height: 40,
                  width: 40,
                  child: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ))
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
            child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.amberAccent),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: TextFormField(
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return (" Name cannot be empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return (" Name should be atleast 3 characters ");
                        }
                        return null;
                      },
                      autofocus: false,
                      controller: namecontroller,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        value = namecontroller.text;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.supervised_user_circle),
                          hintText: ("${userModel.firstName}"
                              " ${userModel.lastName}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: TextFormField(
                      autofocus: false,
                      controller: agecontroller,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        value = agecontroller.text;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.format_list_numbered_rounded),
                          hintText: ("${userModel.age}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Enter your Email");
                        }

                        if (!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return ("Please Enter a valid Email");
                        }
                        return null;
                      },
                      autofocus: false,
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        value = emailcontroller.text;
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail),
                          hintText: ("${userModel.email}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return (" Conact No. cannot be empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return (" Conatct should be atleast 3 characters ");
                        }
                        return null;
                      },
                      autofocus: false,
                      controller: phonecontroller,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        num value = int.parse(phonecontroller.text);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.profile_circled),
                          hintText: ("${userModel.contact}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("City cannot be empty");
                        }

                        return null;
                      },
                      autofocus: false,
                      controller: citycontroller,
                      keyboardType: TextInputType.streetAddress,
                      onSaved: (value) {
                        value = citycontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.location),
                          hintText: ("${userModel.city}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("State cannot be empty");
                        }

                        return null;
                      },
                      autofocus: false,
                      controller: statecontroller,
                      keyboardType: TextInputType.streetAddress,
                      onSaved: (value) {
                        value = statecontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.location),
                          hintText: ("${userModel.state}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Country cannot be empty");
                        }

                        return null;
                      },
                      autofocus: false,
                      controller: countrycontroller,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        value = countrycontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.location_fill),
                          hintText: ("${userModel.country}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Skills Cannot Be Empty";
                          }
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "${userModel.skills}",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10),
                          suffixIcon: PopupMenuButton<String>(
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: (String value) {
                              _controller.text = value;
                            },
                            itemBuilder: (BuildContext context) {
                              return items
                                  .map<PopupMenuItem<String>>((String value) {
                                return new PopupMenuItem(
                                    child: new Text(
                                      value,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    value: value);
                              }).toList();
                            },
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Education cannot be empty");
                        }

                        return null;
                      },
                      autofocus: false,
                      controller: educationcontroller,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        value = educationcontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.cast_for_education),
                          hintText: ("${userModel.education}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      controller: pastexpcontroller,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        value = pastexpcontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_tree_rounded),
                          hintText: ("${userModel.pastexp}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{20,}$');
                        if (value!.isEmpty) {
                          return (" About Me cannot be empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return (" About Me should be atleast 20 characters ");
                        }
                        return null;
                      },
                      autofocus: false,
                      controller: aboutMecontroller,
                      keyboardType: TextInputType.text,
                      onSaved: (value) {
                        value = aboutMecontroller.text;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_business),
                          hintText: ("${userModel.aboutMe}"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18)),
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // updateUser();
                        // User? user = _auth.currentUser;

                        // await collectionReference.add({
                        //   'name': namecontroller.text,
                        //   'email': emailcontroller.text,
                        //   'contact': phonecontroller.text,
                        //   'city': citycontroller.text,
                        //   'state': statecontroller.text,
                        //   'country': countrycontroller.text,
                        //   'skills': _controller.text,
                        //   'education': educationcontroller.text,
                        //   'PastExp': pastexpcontroller.text,
                        //   'About Me': aboutMecontroller.text,
                        //   'age': agecontroller.text
                        // });
                        Navigator.pushNamed(context, "/sugg");
                      },
                      child: Text("Save"))
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

  // Future<void> updateUser() {
  //   return collectionReference
  //       .doc('users')
  //       .update({
  //         'firstName': namecontroller.text,
  //         'email': emailcontroller.text,
  //         'age': agecontroller.text,
  //         'contact': phonecontroller.text,
  //         'city': citycontroller.text,
  //         'state': statecontroller.text,
  //         'country': countrycontroller.text,
  //         'skills': _controller.text,
  //         'pastexp': pastexpcontroller.text,
  //         'aboutMe': aboutMecontroller.text,
  //         'education': educationcontroller.text
  //       })
  //       .then((value) => Fluttertoast.showToast(msg: "User Updated"))
  //       .catchError((error) =>Fluttertoast.showToast(msg: "Error"));
  // }
}
