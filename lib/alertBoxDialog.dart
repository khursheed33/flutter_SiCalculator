import 'package:flutter/material.dart';


class AlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyAlertBox();
  }

}


class MyAlertBox extends StatelessWidget{
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.green,
      title: Text("Welcome to my AlertDialog"),
      content: Text("Hope you like this one"),
        );
  }
}