import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smileparking/screens/show_list.dart';
import 'package:smileparking/utility/my_cons.dart';

import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/warning_dialog.dart';
import 'package:smileparking/model/usermodel.dart';

import 'package:dio/dio.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
// field
  String user, password;
  bool statusRedEye = true;

  String dns = MyConstant().domain_url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[Colors.white, MyStyle().primaryColor],
              center: Alignment(0, -0.3),
              radius: 1.0,
            ),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().showLogo(),
                MyStyle().showTitle('Smile Park'),
                MyStyle().mySizedbox(),
                MyStyle().mySizedbox(),
                userForm(),
                MyStyle().mySizedbox(),
                passwordForm(),
                MyStyle().mySizedbox(),
                loginButton()
              ],
            ),
          )),
        ));
  }

  Widget loginButton() => Container(
        width: 250.0,
        child: ElevatedButton(
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              warningDialog(context, 'Please fill all values.');
            } else {
              checkAuthenUser();
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
              primary: MyStyle().darkColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )),
        ),
      );

  Future<Null> checkAuthenUser() async {
    String url = '$dns/SMILEPARK/getUser.php?isAdd=true&User=$user';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');

      if (result != null) {
        for (var map in result) {
          UserModel userModelset = UserModel.fromJson(map);
          if (password == userModelset.password) {
            String memberType = userModelset.membertype;
            if (memberType == 'admin') {
              print('This is Admin user.');

              routeToService(ShowList(), userModelset);
            } else {
              warningDialog(
                  context, 'Please check your user or password again.');
            }
          } else {
            warningDialog(context, 'Please check your password');
          }
        }
      } else {
        warningDialog(context, 'Please check your user or password again.');
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, UserModel myUserModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('membertype', myUserModel.membertype);
    prefs.setString('name', myUserModel.fullname);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: statusRedEye,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            suffixIcon: IconButton(
                icon: statusRedEye == true
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.remove_red_eye_outlined),
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                }),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password',
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
