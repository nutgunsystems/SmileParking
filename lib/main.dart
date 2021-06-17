import 'package:flutter/material.dart';
import 'package:smileparking/screens/home.dart';
import 'package:smileparking/screens/show_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String myToken = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smile Parking',
      home: ShowList(),
      //home: ParentWidget(),
    );
  }
}
