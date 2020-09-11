import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {

  String name;
  String number;

  EditProfile({@required this.number,@required  this.name});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  String saveText = "Save";

  double loadSize = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    nameController.text = widget.name;
    phoneController.text = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.8)
                ),
                height: 5,
                width: 50,
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Edit Profile", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: "nunitobold"),),
                  SizedBox(height: 20,),


                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: TextField(
                      controller: nameController,
                      onChanged: ((value){
                        widget.name = value;
                      }),
                      decoration: InputDecoration(
                        hintText: "Name",
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: TextField(
                      controller: phoneController,
                      onChanged: ((value){
                        widget.number = value;
                      }),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 30,),
                  GestureDetector(
                    onTap: () async {
                      loadSize = 20;
                      saveText = "Saving...";
                      setState(() {

                      });
                      FirebaseUser user =
                          await FirebaseAuth.instance.currentUser();
                      print(user.uid);


                      // await uploadFile();
                      //Uploading information to firestore
                      Firestore.instance
                          .collection('users')
                          .document(user.uid)
                          .updateData({
                        "name": widget.name,
                        "phone": widget.number,
                      }).then((result) {
                        loadSize = 0;
                        saveText = "Saved";
                        setState(() {

                        });
                       Navigator.pop(context, widget.name+"ff/ew]"+widget.number);
                      }).catchError((err) {
                        print(err);
                      });
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
                          Text(saveText, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
