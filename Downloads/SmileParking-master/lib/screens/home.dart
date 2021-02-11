import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:smileparking/model/mobilemodel.dart';
import 'package:smileparking/screens/add_car_info.dart';
import 'package:smileparking/screens/car_register.dart';
import 'package:smileparking/screens/show_list.dart';
import 'package:smileparking/utility/my_mobile.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/normal_dialog.dart';
import 'package:smileparking/utility/signout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MobileModel mobileModel;
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";

  @override
  void initState() {
    super.initState();
    aboutNotification();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformImei;
    String idunique;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);
      idunique = await ImeiPlugin.getId();
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformImei = platformImei;
      uniqueId = idunique;
    });
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: <Widget>[
            showHeadDrawer(),
            showContentDrawer(),
          ],
        ),
      );

  UserAccountsDrawerHeader showHeadDrawer() => UserAccountsDrawerHeader(
        decoration: MyStyle().myBoxHeader('icon_info.png'),
        //currentAccountPicture: MyStyle().showLogo(),
        accountName: Text(
          'About',
          style: TextStyle(
            color: MyStyle().darkColor,
            fontSize: 20.0,
          ),
        ),
        accountEmail: Text('Please read this information.',
            style: TextStyle(color: MyStyle().darkColor)),
      );

  Widget showContentDrawer() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 300.0,
      child: Column(
        children: [
          Row(
            children: [
              MyStyle().showTitleHeader2('สนันสนุนโดย'),
            ],
          ),
          MyStyle().mySizedbox(),
          MyStyle().showSponsor(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('นัท & กัน ไอศครีม.',
                  style: TextStyle(
                    color: Colors.purple[200],
                    fontSize: 20.0,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'หาดบางแสน',
            style: TextStyle(
              //color: Colors.black,
              fontSize: 25.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutProcress(),
            ),
          ]),
      drawer: showDrawer(),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          myLogo(),
          showAppName(),
          MyStyle().mySizedbox(),
          MyStyle().mySizedbox(),
          addAndEditButton(),
          MyStyle().mySizedbox(),
          searchButton(),
          MyStyle().mySizedbox(),
          informButton(),
        ],
      ),
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq1',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.add_box),
                onPressed: () => routeToAddCar(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleHeader2('ลงทะเบียนรถ')
      ],
    );
  }

  Row searchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq2',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.search),
                onPressed: () => routeToFindCar(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleHeader2('ค้นหาข้อมูลรถ')
      ],
    );
  }

  Row informButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq3',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.list),
                onPressed: () => routeToList(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleHeader2('จอดขีดขวาง')
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('[บริการจอดรถ]'),
      ],
    );
  }

  Void readMobileInfo() {
    var jsonData, parsedJson;

    if (_platformImei.isNotEmpty && _platformImei != '') {
      jsonData = '{ "Imei" : "$_platformImei", "uniqueId" : "$uniqueId"  }';
      parsedJson = json.decode(jsonData);

      mobileModel = MobileModel.fromJson(parsedJson);
    }

    print('$_platformImei');
    print('MobileModel >>>> ${mobileModel.imei} is ${mobileModel.uniqueId}');
  }

  Void routeToAddCar() {
    print('Button click add');
    Widget myWidget = AddCarInfo();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Void routeToFindCar() {
    print('Button click search');
    Widget myWidget = Car_Register();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Void routeToList() {
    print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Future<Null> aboutNotification() async {
    if (Platform.isAndroid) {
      print('Android Notification.');

      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      await firebaseMessaging.configure(
        onLaunch: (message) {
          print('>>> onLaunch');
        },
        onResume: (message) {
          print('>>> onResume');
        },
        onMessage: (message) {
          print('>>> onMessage');
          normalDialog(context, message.toString());
        },
      );
    } else if (Platform.isIOS) {
      print('iOS Notification.');
    }
  }
}
