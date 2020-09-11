import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shop_app/services/firebase_auth.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  double loadSize = 0;
  String sendText = "Send Request";
  String email;
  String emailhint = "Email";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.8)),
                height: 5,
                width: 50,
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: "nunitobold"),
                ),
                SizedBox(height: 30,),
                Text("Enter your email", style: TextStyle(fontFamily: "nunitobold"),),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)
                  ),
                  child: TextField(
                    onChanged: ((value){
                      email = value;
                    }),
                    decoration: InputDecoration(
                      hintText: emailhint,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    if(email.toString().trim() == ""){

                      setState(() {
                        emailhint = "Please enter email";
                      });
                    } else{
                      loadSize = 20;
                      sendText = "Sending Request...";
                      setState(() {

                      });

                      Auth auth = new Auth();
                      auth.sendPasswordResetEmail(email).then((value){
                        Timer(Duration(seconds: 2), () {
                          loadSize = 0;
                          sendText = "Check email to proceed";
                          setState(() {

                          });
                          Timer(Duration(seconds: 3), () {
                            Navigator.pop(context);
                          });
                        });
                      });
                    }


                  },
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 17),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitCubeGrid(
                            size: loadSize,
                            color: Colors.black,
                          ),
                          SizedBox(width: 15,),
                          Text(sendText, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "nunitobold"),),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
