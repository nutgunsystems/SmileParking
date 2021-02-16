import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/mobilemodel.dart';
import 'package:Smileparking/screens/add_car_info.dart';
import 'package:Smileparking/screens/car_register.dart';
import 'package:Smileparking/screens/edit_station.dart';
import 'package:Smileparking/screens/new_obstacle.dart';
import 'package:Smileparking/screens/show_list.dart';
import 'package:Smileparking/screens/singin.dart';
import 'package:Smileparking/utility/my_mobile.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/normal_dialog.dart';
import 'package:Smileparking/utility/signout.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  MobileModel mobileModel;
  Size size;
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";

  String pref_membertype = '';
  String pref_name = '';

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';

  @override
  void initState() {
    super.initState();
    aboutNotification();
    getDeviceStation();
  }

  Future<Null> getDeviceStation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      pref_membertype = preferences.getString('membertype');
      pref_name = preferences.getString('name');

      pref_Station_ID = preferences.getString('device_station_id');
      pref_Station_EN = preferences.getString('device_station_en');
      pref_Station_TH = preferences.getString('device_station_th');
    });

    print('User : $pref_name');
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
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[Colors.white, MyStyle().drawerColor],
              center: Alignment(0, -0.5),
              radius: 1.0,
            ),
          ),
          child: ListView(
            children: <Widget>[
              showHeadDrawer(),
              showContentDrawer(),
            ],
          ),
        ),
      );

  Widget showHeadDrawer() => Container(
        //width: 50.0,
        height: 120.0,
        child: UserAccountsDrawerHeader(
          decoration: MyStyle().myBoxHeader('icon_info.png'),

          //currentAccountPicture: MyStyle().showLogo(),
          accountName: Text(
            'Smile Parking ',
            style: TextStyle(
              color: MyStyle().darkColor,
              fontSize: 20.0,
            ),
          ),
          accountEmail:
              Text('version 1.0', style: TextStyle(color: MyStyle().darkColor)),
        ),
      );

  Widget showContentDrawer() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 300.0,
      child: Column(
        children: [
          MyStyle().mySizedbox(),
          MyStyle().showSponsor(),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('ผู้จัดทำโครงการ:',
                style: TextStyle(
                  color: Colors.purple[300],
                  fontSize: 16.0,
                )),
          ]),
          MyStyle().mySizedbox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('นาย ณัฐวัฒน์ วานิชธัญทรัพย์',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
              MyStyle().mySizedbox(),
            ],
          ),
          MyStyle().mySizedbox(),
          Row(
            children: [
              Text('ติดต่อ: 0836141565',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ],
          ),
          Row(
            children: [
              Text('Email: Vvorawat@gmail.com',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  )),
            ],
          ),
          MyStyle().mySizedbox(),
          signINMENU(),
        ],
      ),
    );
  }

  ListTile signINMENU() {
    return ListTile(
      leading: Icon(Icons.login),
      title: Text('Sign in Administrator.',
          style: TextStyle(
            color: Colors.green.shade800,
            fontSize: 16.0,
          )),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SignIn());
        Navigator.push(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '$pref_Station_TH',
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
      body: showMenu(),
    );
  }

  ListView showMenu() {
    return ListView(
      //padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[Colors.white, Colors.white],
              center: Alignment(0, -0.3),
              radius: 1.0,
            ),
          ),
          width: 300.0,
          //height: 550.0,
          //// Linear bordor gradient
          //decoration: new BoxDecoration(
          //gradient: new LinearGradient(
          //    colors: [
          //      const Color(0xFF3366FF),
          //     const Color(0xFF00CCFF),
          //    ],
          //    begin: const FractionalOffset(0.0, 0.0),
          //    end: const FractionalOffset(1.0, 0.0),
          //    stops: [0.0, 1.0],
          //    tileMode: TileMode.clamp),
          //  ),
          // Add box decoration

          //// Background color gradient
          //decoration: BoxDecoration(
          //// Box decoration takes a gradient
          // gradient: LinearGradient(
          //   // Where the linear gradient begins and ends
          //   begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   // Add one stop for each color. Stops should increase from 0 to 1
          //   stops: [0.1, 0.5, 0.7, 0.9],

          //   colors: [
          //    // Colors are easy thanks to Flutter's Colors class.
          //     Colors.blue[600],
          //     Colors.blue[400],
          //     Colors.blue[200],
          //     Colors.blue[100],
          //   ],
          // ),
          // ),

          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.30,
                child: Center(
                  child: new Image.asset(
                    'images/BG_005.jpg',
                    width: size.width,
                    height: size.height,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                children: [
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  //myLogo(),
                  showAppName(),

                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  addAndEditButton(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  searchButton(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  obstacleButton(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  informButton(),
                  MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                  ((pref_name != null) && (pref_name == 'Super Admin'))
                      ? stationButton()
                      : MyStyle().mySizedbox(),
                  MyStyle().mySizedbox(),
                ],
              ),
            ],
          ),
        ),
      ],
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
              margin: EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq1',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.add_box),
                onPressed: () => routeToAddCar(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleH1Black('ลงทะเบียนรถ')
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
              margin: EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq2',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.search),
                onPressed: () => routeToFindCar(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleH1Gley('ค้นหาข้อมูลรถ')
      ],
    );
  }

  Row obstacleButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq3',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.person),
                onPressed: () => routeToObstacle(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleH1Gley('ติดตามเจ้าของรถ')
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
              margin: EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq4',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.list),
                onPressed: () => routeToList(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleH1Gley('จอดขีดขวาง')
      ],
    );
  }

  Row stationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                heroTag: 'unq5',
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: const Icon(Icons.place),
                onPressed: () => routeToStation(),
              ),
            ),
          ],
        ),
        MyStyle().showTitleH1Green('สถานทีจอดรถ')
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

  Void routeToObstacle() {
    print('Button click new obstacle');
    Widget myWidget = NewObstacle();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Void routeToList() {
    print('Button click shoe list');
    Widget myWidget = ShowList();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Void routeToStation() {
    print('Button click select station');
    Widget myWidget = EditStation();

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
