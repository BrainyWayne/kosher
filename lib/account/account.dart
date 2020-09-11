import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/account/changePassword.dart';
import 'package:shop_app/account/editProfile.dart';
import 'package:shop_app/globalwidgets.dart';
import 'package:shop_app/services/firebase_auth.dart';

import '../constants.dart';
import '../login.dart';

class Account extends StatefulWidget {

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool verified = false;
  String verificationText = 'Click here to resend verification email';
  double bottomLoaderHeight = 0;
  String username = ".";
  String email = ".";
  String number = "";
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 60),
            child: SafeArea(
                child: Stack(
              children: [

                ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      "Profile",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontFamily: "Pacifico"),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    username,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "nunitobold"),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    email,
                                    style: TextStyle(fontFamily: "nunito"),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    number,
                                    style: TextStyle(fontFamily: "nunito"),
                                  ),
                                ],
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: cText(username[0], true, 20),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Account Settings",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "nunitobold"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var response = await showCupertinoModalBottomSheet(
                                expand: false,
                                context: context,
                                builder: (context, scrollController) =>
                                    Material(child: EditProfile(number: number, name: username,)),
                              );

                              number = response.toString().split("ff/ew]")[1];
                              username = response.toString().split("ff/ew]")[0];
                              setState(() {

                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: "nunitobold"),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                expand: false,
                                context: context,
                                builder: (context, scrollController) =>
                                    Material(child: ChangePassword()),
                              );
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: 16, fontFamily: "nunitobold"),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Text(
                                  "Generate Profile Report",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "nunitobold"),
                                ),
                                Spacer(),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Notifications",
                            style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Text(
                                  "Notifications",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "nunitobold"),
                                ),
                                Spacer(),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Text(
                                  "Schedule Notification",
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: "nunitobold"),
                                ),
                                Spacer(),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              bottomLoaderHeight = 70;
                              setState(() {});
                              Auth auth = new Auth();
                              auth.signOut().then((value) {
                                Timer(Duration(seconds: 2), () {
                                  navigateToReplace(context, Login());
                                });
                              });
                            },
                            child: Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15, vertical: 17),
                              decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Text(
                                    "Log out",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "nunitobold"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "kosher",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text("v1.0",
                                      style: TextStyle(fontWeight: FontWeight.bold))
                                ],
                              ),
                              Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
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
                          "Signing out",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }

  void getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
    Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        print(datasnapshot.data['phone'].toString());

        username = datasnapshot.data['name'].toString();
        email = datasnapshot.data['email'].toString();
        number = datasnapshot.data['phone'].toString();


        setState(() {

        });

      }
    });


  }

}
