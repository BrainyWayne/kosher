import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/account/account.dart';
import 'package:shop_app/newpost.dart';

import '../../home/home_screen.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  String email;
  String username;
  String number;
  PageController controller = new PageController();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: [
            PageView(
              controller: controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                NewPost(),
                Account()
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                    width: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            onSelection(0);
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(left: 20),
                            duration: Duration(milliseconds: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            onSelection(1);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle),

                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            onSelection(2);
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(right: 20),
                            duration: Duration(milliseconds: 200),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.account_circle),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            )
          ],
        ),
      ),
    );
  }

  void getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
    Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        // print(datasnapshot.data['email'].toString());
        // print(datasnapshot.data['name'].toString());
        // print(datasnapshot.data['phone'].toString());

        username = datasnapshot.data['name'].toString();
        email = datasnapshot.data['email'].toString();
        number = datasnapshot.data['phone'].toString();




      }
    });
    setState(() {

    });

  }

  void onSelection(int i) {
    controller.animateToPage(i, duration: Duration(milliseconds: 400), curve: Curves.fastLinearToSlowEaseIn);
  }
}
