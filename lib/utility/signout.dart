import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Smileparking/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signOutProcress() async {
  SharedPreferences myPrefer = await SharedPreferences.getInstance();
  myPrefer.clear();
  exit(0);
}

Future<Null> routeToHomePage(BuildContext context) async {
  //exit(0);
  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => Home(),
  );

  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
