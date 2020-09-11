import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop_app/account/changePassword.dart';
import 'package:shop_app/globalwidgets.dart';
import 'package:shop_app/screens/details/components/navigation.dart';
import 'package:shop_app/services/firebase_auth.dart';
import 'package:shop_app/signup.dart';

import 'screens/home/home_screen.dart';
import 'screens/home/home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

double bottomLoaderHeight = 0;
bool topSnackVisible = false;
bool phoneNumberBox = false;
String topBannerText = "";
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  String phoneNumber;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String email, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.red,Colors.amber
              ]),

            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "kosher",
                        style: TextStyle(
                            fontFamily: "Pacifico",
                            fontSize: 40,
                            color: Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: TextField(
                                onChanged: ((value) {
                                  email = value;
                                }),
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    border: InputBorder.none)),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: TextField(
                              onChanged: ((value) {
                                password = value;
                              }),
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.keyboard),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          width: double.infinity,
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            onPressed: () async {
                              if (emailController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              }
                              if (!emailController.text.contains("@")) {
                                setState(() {
                                  topBannerText = "Enter a valid email";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else if (passwordController.text == "") {
                                setState(() {
                                  topBannerText = "Enter your password";
                                  topSnackVisible = true;
                                  _hideTopBanner();
                                });
                              } else {
                                setState(() {
                                  bottomLoaderHeight = 70;
                                });
                                Auth _auth = Auth();

                                await _auth
                                    .signIn(email, password)
                                    .then((onValue) {
                                  if (onValue != null) {
                                    bottomLoaderHeight = 0;
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomeScreen()));
                                  }
                                }).catchError((onError) {
                                  print(onError);
                                });
                              }
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  fontFamily: "nunitobold",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // SizedBox(height: 20),
                        // GestureDetector(
                        //   onTap: () async {
                        //     user = await googleSignIn();
                        //
                        //    setState(() {
                        //      phoneNumberBox = true;
                        //    });
                        //
                        //
                        //   },
                        //   child: Container(
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(15),
                        //       color: Colors.white,
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       crossAxisAlignment: CrossAxisAlignment.center,
                        //       children: [
                        //         Image.asset("assets/images/google.png", height: 25, width: 25,),
                        //         SizedBox(width: 15,),
                        //         Text("Sign in with Google", style: TextStyle(
                        //             fontFamily: "nunitobold",
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.bold),),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 20),
                        Text("Don't have an account?",
                            style: TextStyle(
                              fontFamily: "nunitobold",
                              color: Colors.black,
                            )),
                        SizedBox(height: 20),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Signup()));
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  fontFamily: "nunitobold",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              expand: false,
                              context: context,
                              builder: (context, scrollController) =>
                                  Material(child: ChangePassword()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Forgot Password?",
                                style: TextStyle(
                                  fontFamily: "nunitobold",
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: phoneNumberBox,
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        cText("Enter your phone number", true, 20),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            onChanged: ((value) {
                              phoneNumber = value;
                            }),
                            decoration: InputDecoration(
                                hintText: "Phone Number",
                                prefixIcon: Icon(Icons.phone),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Firestore.instance
                                .collection('users')
                                .document(user.uid)
                                .setData({
                              "userid": user.uid,
                              "email": user.email,
                              "name": user.displayName,
                              "phone": phoneNumber,
                            }).then((result) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Navigation()));
                            }).catchError((err) {
                              print(err);
                            });
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green,
                              ),
                              child: Container(
                                  child:
                                      Center(child: cText("SAVE", true, 18)))),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: topSnackVisible,
            child: Container(
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  topBannerText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
              height: bottomLoaderHeight,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
              child: Row(
                children: <Widget>[
                  SpinKitCubeGrid(
                    size: 20,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    "Signing in...",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<FirebaseUser> googleSignIn() async {
    // hold the instance of the authenticated user
    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    // if (isSignedIn) {
    //   // if so, return the current user
    //   user = await _auth.currentUser();
    // }
    // else {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // get the credentials to (access / id token)
    // to sign in via Firebase Authentication
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    user = (await _auth.signInWithCredential(credential)).user;

    return user;
  }

  void _hideTopBanner() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        topSnackVisible = false;
      });
    });
  }
}
