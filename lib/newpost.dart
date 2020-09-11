import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/services/crudobj.dart';


import 'login.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String username;
  String email;
  String photoUrl;
  String residence;
  String number;
  String price;
  String type;
  String title;
  String details;
  CRUDMethods crudObj;
  String uploadButtonText = "Upload";
  var imageURL;
  File _image;
  String _uploadedFileURL = "null";
  FirebaseUser user;
  @override
  void initState() {
    super.initState();
    crudObj = new CRUDMethods();

    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(left: 20, right: 20, top: 30),
        children: <Widget>[
          SafeArea(
            child: Row(
              children: <Widget>[
                Text(
                  "Upload new Product",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),

          InkWell(
            onTap: () {
              chooseFile();
            },
            child: ClipRRect(
              //borderRadius: BorderRadius.circular(200),
              child: Container(
                height: 250,
                 // padding: EdgeInsets.all(60),
                  child: _uploadedFileURL == "null"
                      ? CircleAvatar(
                    child: Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 60,
                    ),
                    radius: 60,
                    backgroundColor: Colors.green,
                  )
                      : Image.file(_image, fit: BoxFit.cover,)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Product Name"),
          TextField(
            decoration: InputDecoration(hintText: "Enter name"),
            onChanged: (value) {
              title = value;
              print(title);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("Product Details"),
          TextField(
            decoration: InputDecoration(hintText: "Enter details"),
            onChanged: (value) {
              details = value;
              print(details);
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("Price"),
          TextField(
            decoration: InputDecoration(hintText: "Enter price"),
            onChanged: (value) {
              price = value;
              print(price);
            },
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              uploadFile(title, details);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: <Widget>[
                  Text(
                    uploadButtonText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Text(
                  "Cancel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Future<void> getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentReference documentReference =
        Firestore.instance.collection('users').document(user.uid);

    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        print(datasnapshot.data['email'].toString());
        print(datasnapshot.data['name'].toString());
        print(datasnapshot.data['residence'].toString());
        var photolink;
        try {
          photolink = datasnapshot.data['photo'].toString();
        } catch (e) {
          photoUrl = "N/A";
        }

        setState(() {
          username = datasnapshot.data['name'].toString();
          email = datasnapshot.data['email'].toString();
          photoUrl = photolink;
          number = datasnapshot.data['phone'].toString();
        });
      }
    });
  }

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
        _uploadedFileURL = image.toString();
      });
    });
  }

  Future uploadFile(String title, String details) async {
    user = await FirebaseAuth.instance.currentUser();
    StorageReference storageReference =
    FirebaseStorage.instance.ref().child('posts/' + user.uid + DateTime.now().toString());
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('Uploaded');
    await storageReference.getDownloadURL().then((photoURL) {
      print("photoURL: " + photoURL);
      imageURL = photoURL;
      // print("imageURL: " + imageURL);
      // Firestore.instance.collection('users').document(user.uid).updateData({
      //   "photo": imageURL.toString(),
      // });

      uploadPost(title, details, photoURL);

    });
  }


  void uploadPost(String title, String details, String photourl) {
    crudObj.addData({
      'title': title,
      'details': details,
      'photourl': photourl,
      'name': username,
      'number': number,
      'price': price,
      'email': email,
      'uid': user.uid

    }).then((result) {
      setState(() {
        uploadButtonText = "Uploaded";
      });
    }).catchError((e) {
      print(e);
    });
  }
}
