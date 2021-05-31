import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterFcm/Provider/auth_provider.dart';
import 'package:flutterFcm/Screens/AuthScreen/phone_auth.dart';
import 'package:flutterFcm/Screens/AuthScreen/register.dart';
import 'package:flutterFcm/Screens/AuthScreen/reset.dart';

import '../home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: isLoading == false
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(hintText: "Email"),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(hintText: "Password"),
                  ),
                  FlatButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        AuthClass()
                            .signIN(
                                email: _email.text.trim(),
                                password: _password.text.trim())
                            .then((value) {
                          if (value == "Welcome") {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(value)));
                          }
                        });
                      },
                      child: Text("Log In ")),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text("Don't have an account? Register "),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ResetPage()));
                    },
                    child: Text("Forgot Password? reset "),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //Social Auth Buttons
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            //Sign In with google
                            AuthClass()
                                .signWithGoogle()
                                .then((UserCredential value) {
                              final displayName = value.user.displayName;

                              print(displayName);

                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            });
                          },
                          child: Container(
                              color: Colors.red,
                              padding: const EdgeInsets.all(10),
                              child: Text("Continue with Google"))),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          AuthClass()
                              .signInWithFacebook()
                              .then((UserCredential value) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          });
                        },
                        child: Container(
                          color: Colors.blue,
                          padding: const EdgeInsets.all(10),
                          child: Text("Continue with facebook"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhoneAuth()));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.amber,
                          margin: const EdgeInsets.symmetric(vertical: 50),
                          child: Text("Continue with phone"),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
