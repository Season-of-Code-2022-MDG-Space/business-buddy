import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectt/pages/reg_page.dart';
import 'package:projectt/pages/suggestion_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //form key of Form
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
          prefixIcon: const Icon(Icons.mail),
          hintText: ("Enter Email"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.all(10)),
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
          prefixIcon: const Icon(Icons.password),
          hintText: ("Enter Password"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.all(10)),
    );

    final loginButton = Material(
      color: Colors.deepPurple,
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        padding: const EdgeInsets.all(20),
        onPressed: () {
          // Navigator.pushNamed(context, "/home");
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
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
                      const SizedBox(
                        height: 60,
                      ),
                      emailField,
                      const SizedBox(
                        height: 20,
                      ),
                      passwordField,
                      const SizedBox(
                        height: 10,
                      ),
                      loginButton,
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          children: [
                            const Text("I don't have an account ? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegScreen()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) {
        Fluttertoast.showToast(msg: "Login Success");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SuggestionPage()));
      }).catchError((e) {
        Fluttertoast.showToast(msg: e.toString());
      });
    }
  }
}
