import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/screens/details/components/navigation.dart';
import 'package:shop_app/services/firebase_auth.dart';

import 'screens/home/home_screen.dart';



class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}



class _SignupState extends State<Signup> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameontroller = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordConfirmController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  String email;
  FirebaseUser user;
  File _image;
  String _uploadedFileURL = "null";
  double bottomLoaderHeight = 0;
  var imageURL;
  bool canProceedSignup = true;

  String _selectedSignType; // Option 2

  String cantProceedText = "Fill all fields to continue";
  Color colorsProceed = Colors.black;

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
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    cantProceedText,
                    style: TextStyle(
                        color: colorsProceed,
                        fontFamily: "nunitobold",
                        fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
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
                              controller: usernameontroller,
                              decoration: InputDecoration(
                                  hintText: "Full Name",
                                  prefixIcon: Icon(Icons.account_circle),
                                  border: InputBorder.none),
                            ),
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
                              controller: numberController,
                              decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  prefixIcon: Icon(Icons.phone),
                                  border: InputBorder.none),
                            ),
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
                              onChanged: ((value){
                                email = value;
                              }),
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none),
                            ),
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
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.keyboard),
                                  border: InputBorder.none),
                            ),
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
                              controller: passwordConfirmController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  prefixIcon: Icon(Icons.keyboard),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(height: 15),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15)),
                          child: FlatButton(
                            padding: EdgeInsets.all(15),
                            onPressed: () {
                              if (emailController.text.isEmpty) {
                                canProceedSignup = false;
                                print("Email empty");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else if (numberController.text.isEmpty) {
                                canProceedSignup = false;
                                print("Phone number empty");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else if (usernameontroller.text.isEmpty) {
                                canProceedSignup = false;
                                print("Name empty");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else if (passwordController.text.isEmpty) {
                                canProceedSignup = false;
                                print("cant proceed");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else if (passwordConfirmController
                                  .text.isEmpty) {
                                canProceedSignup = false;
                                print("No password entered");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else if (passwordController.text
                                      .toString()
                                      .trim() !=
                                  passwordConfirmController.text
                                      .toString()
                                      .trim()) {
                                canProceedSignup = false;
                                cantProceedText = "Passwords do not match";
                                print("Passwords do not match");
                                setState(() {
                                  colorsProceed = Colors.red;
                                });
                              } else {
                                setState(() {
                                  bottomLoaderHeight = 70;
                                });
                                Auth _auth = new Auth();
                                _auth
                                    .signUp(
                                        emailController.text
                                            .toLowerCase()
                                            .trim(),
                                        passwordController.text)
                                    .then((onValue) async {
                                  user =
                                      await FirebaseAuth.instance.currentUser();
                                  print(user.uid);

                                  _auth.sendEmailVerification();

                                  print(email);

                                  // await uploadFile();
                                  //Uploading information to firestore
                                  Firestore.instance
                                      .collection('users')
                                      .document(user.uid)
                                      .updateData({
                                    "userid": user.uid,
                                    "email": emailController.text,
                                    "name": usernameontroller.text,
                                    "phone": numberController.text,
                                  }).then((result) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Navigation()));
                                  }).catchError((err) {
                                    print(err);
                                  });
                                });
                              }
                            },
                            child: Text(
                              "SIGN UP",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "nunitobold",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    "Signing up...",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//  Future chooseFile() async {
//    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
//      setState(() {
//        _image = image;
//        _uploadedFileURL = image.toString();
//      });
//    });
//  }
//
//  Future uploadFile() async {
//    user = await FirebaseAuth.instance.currentUser();
//    StorageReference storageReference =
//        FirebaseStorage.instance.ref().child('users/' + user.uid);
//    StorageUploadTask uploadTask = storageReference.putFile(_image);
//    await uploadTask.onComplete;
//    print('Uploaded');
//    await storageReference.getDownloadURL().then((photoURL) {
//      print("photoURL: " + photoURL);
//      imageURL = photoURL;
//      print("imageURL: " + imageURL);
//      Firestore.instance.collection('users').document(user.uid).updateData({
//        "photo": imageURL.toString(),
//      });
//    });
//  }

//  savePhotoUrl(String photourl) async {
//    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//    await sharedPreferences.setString('photourl', photourl);
//    setState(() {
//      _uploadedFileURL = photourl;
//    });
//  }
}
