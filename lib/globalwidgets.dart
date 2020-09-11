import 'package:flutter/material.dart';

Widget cText(String text, bool bold, double size) {
  return Text(
    text,
    style:
        TextStyle(fontFamily: bold ? "nunitobold" : "nunito", fontSize: size),
  );
}

void navigateTo(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => widget));
}

void navigateToReplace(BuildContext context, Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => widget));
}

void goBack(BuildContext context){
  Navigator.pop(context);
}

Widget cButton(String text, Color textColor, Color color){
  return AnimatedContainer(
    duration: Duration(milliseconds: 400),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor, fontFamily: "nunito"),),
      ],
    ),
  );
}