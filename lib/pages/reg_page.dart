import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectt/model/user_model.dart';

import 'package:projectt/pages/suggestion_page.dart';

class RegScreen extends StatefulWidget {
  const RegScreen({Key? key}) : super(key: key);
  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _auth = FirebaseAuth.instance;

  final _formkey = GlobalKey<FormState>();
  final firstNameditingcontroller = TextEditingController();
  final lastNameditingcontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final phonecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final countrycontroller = TextEditingController();

  final educationcontroller = TextEditingController();
  final pastexpcontroller = TextEditingController();
  final aboutMecontroller = TextEditingController();
  final agecontroller = TextEditingController();
  final workingHrcontroller = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  var items = [
    'agency',
    'business Development',
    'construction/Trade',
    'consulting',
    'designer',
    'developer(App/Web)',
    'digital marketing',
    'e-commerce',
    'finance/fin tech',
    'franchise',
    'marketer',
    'manufacturing',
    'merchandise',
    'product',
    'retail',
    'sales',
    'wholeSale',
    'web Site(news/affiliate)',
    'other'
  ];
  var items2 = ["0-3 Hours", "3-5 Hours", "5-7 Hours", "7-9 Hours", "9+ Hours"];

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return (" First name should be atleast 3 characters ");
        }
        return null;
      },
      autofocus: false,
      controller: firstNameditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        value = firstNameditingcontroller.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.profile_circled),
          hintText: ("Enter First Name"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final lastNameField = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Last Name cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return (" Last name should be atleast 3 characters ");
        }
        return null;
      },
      autofocus: false,
      controller: lastNameditingcontroller,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        value = lastNameditingcontroller.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(CupertinoIcons.profile_circled),
          hintText: ("Enter Last Name"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final emailField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        }

        if (!RegExp("^[a-zA-z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid Email");
        }
        return null;
      },
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        value = emailController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: ("Enter Email"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final passwordField = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter Valid Password (Min 6 Char) ");
        }
      },
      obscureText: true,
      autofocus: false,
      controller: passwordController,
      onSaved: (value) {
        value = passwordController.text;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          hintText: ("Enter password "),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final confirmpasswordField = TextFormField(
      validator: (value) {
        if (confirmpasswordController.text != passwordController.text &&
            passwordController.text != value) {
          return ("Password doesnt match");
        }
        return null;
      },
      obscureText: true,
      autofocus: false,
      controller: confirmpasswordController,
      onSaved: (value) {
        value = confirmpasswordController.text;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          hintText: ("Confirm password "),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );
    final signUpButton = Material(
      color: Colors.deepPurple,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: EdgeInsets.all(20),
        onPressed: () {
          signUp(emailController.text, passwordController.text);
        },
        child: const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );

    final phonefield = TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{10,}$');
        if (value!.isEmpty) {
          return (" Conact No. cannot be empty");
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
          hintText: (" Contact Number"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final cityField = TextFormField(
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
          hintText: ("City"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );
    final stateField = TextFormField(
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
          hintText: ("State"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );
    final countryField = TextFormField(
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
          hintText: ("Country"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final skillsField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return " Business Skills Cannot Be Empty";
        }
        return null;
      },
      controller: _controller,
      decoration: InputDecoration(
        labelText: "Please Select Appropriate Business Skill",
        hintText: " Business Skills",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: EdgeInsets.all(10),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            _controller.text = value;
          },
          itemBuilder: (BuildContext context) {
            return items.map<PopupMenuItem<String>>((String value) {
              return new PopupMenuItem(
                  child: new Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: value);
            }).toList();
          },
        ),
      ),
    );
    final workingHrField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Working Hours Cannot Be Empty";
        }
        return null;
      },
      controller: workingHrcontroller,
      decoration: InputDecoration(
        labelText: "Please Select Appropriate Working Hours",
        hintText: "Daily Working Hours",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
        contentPadding: EdgeInsets.all(10),
        suffixIcon: PopupMenuButton<String>(
          icon: const Icon(Icons.arrow_drop_down),
          onSelected: (String value) {
            workingHrcontroller.text = value;
          },
          itemBuilder: (BuildContext context) {
            return items2.map<PopupMenuItem<String>>((String value) {
              return new PopupMenuItem(
                  child: new Text(
                    value,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  value: value);
            }).toList();
          },
        ),
      ),
    );
    final educationField = TextFormField(
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
          hintText: ("Education"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    final pastexpField = TextFormField(
      autofocus: false,
      controller: pastexpcontroller,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        value = pastexpcontroller.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_tree_rounded),
          hintText: ("Past Experiences in any field"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );
    final aboutmeField = Container(
        child: TextFormField(
      validator: (value) {
        RegExp regex = new RegExp(r'^.{10,}$');
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
      keyboardType: TextInputType.multiline,
      maxLines: null,
      onSaved: (value) {
        value = aboutMecontroller.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        prefixIcon: Icon(Icons.add_business),
        hintText: ("About Me"),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ));
    final ageField = TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Age Cannot Be Empty";
        }
        return null;
      },
      autofocus: false,
      controller: agecontroller,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        value = agecontroller.text;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.format_list_numbered_rounded),
          hintText: ("Enter Age"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: EdgeInsets.all(10)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/images/bb_logo.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      firstNameField,
                      SizedBox(
                        height: 10,
                      ),
                      lastNameField,
                      SizedBox(
                        height: 10,
                      ),
                      emailField,
                      SizedBox(
                        height: 10,
                      ),
                      passwordField,
                      SizedBox(
                        height: 10,
                      ),
                      confirmpasswordField,
                      SizedBox(
                        height: 10,
                      ),
                      ageField,
                      SizedBox(
                        height: 10,
                      ),
                      cityField,
                      SizedBox(
                        height: 10,
                      ),
                      stateField,
                      SizedBox(
                        height: 10,
                      ),
                      countryField,
                      SizedBox(
                        height: 10,
                      ),
                      phonefield,
                      SizedBox(
                        height: 10,
                      ),
                      skillsField,
                      SizedBox(
                        height: 10,
                      ),
                      educationField,
                      SizedBox(
                        height: 10,
                      ),
                      workingHrField,
                      SizedBox(
                        height: 10,
                      ),
                      pastexpField,
                      SizedBox(
                        height: 10,
                      ),
                      aboutmeField,
                      SizedBox(
                        height: 10,
                      ),
                      signUpButton
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        value.user!.updateProfile(displayName: firstNameditingcontroller.text);
        postDetailsToFireStore();
        Navigator.pushNamed(context, "/dash");
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }
  }

  void postDetailsToFireStore() async {
    //calling our firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = _auth.currentUser!;
    UserModel userModel = UserModel();
    //writng data

    userModel.email = user.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameditingcontroller.text;
    userModel.lastName = lastNameditingcontroller.text;
    userModel.age = agecontroller.text;
    userModel.city = citycontroller.text;
    userModel.state = statecontroller.text;
    userModel.country = countrycontroller.text;
    userModel.contact = phonecontroller.text;
    userModel.skills = _controller.text;
    userModel.education = educationcontroller.text;
    userModel.pastexp = pastexpcontroller.text;
    userModel.aboutMe = aboutMecontroller.text;
    userModel.workingHr = workingHrcontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully :)");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const SuggestionPage()),
        (route) => false);
  }
}
