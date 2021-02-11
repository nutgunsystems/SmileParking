import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/screens/show_list.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:Smileparking/utility/warning_dialog.dart';

class EditStation extends StatefulWidget {
  @override
  _EditStationState createState() => _EditStationState();
}

class _EditStationState extends State<EditStation> {
  int selected_station_id = 1;

  String pref_Token = '';

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';

  @override
  void initState() {
    super.initState();

    getDeviceStation();
  }

  Future<Null> getDeviceStation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      pref_Station_ID = preferences.getString('device_station_id');

      pref_Token = preferences.getString('device_token');

      selected_station_id = int.parse(pref_Station_ID);
      //pref_Station_EN = preferences.getString('device_station_en');
      //pref_Station_TH = preferences.getString('device_station_th');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สถานที่จอดรถ'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => routeToHomePage(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Column(
              children: [
                MyStyle().mySizedbox(),
                showImageRadio(),
                MyStyle().mySizedbox(),
                showEditButton(),
                MyStyle().mySizedbox(),
                MyStyle().mySizedbox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showEditButton() => Container(
        width: 300.0,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () {
            print('click OK');
            if ((selected_station_id == null || selected_station_id == 0)) {
              warningDialog(context, 'กรุณาเลือกสถานีที่ต้องการ.');
            } else {
              if (selected_station_id.toString() != pref_Station_ID) {
                addDeviceStation();
              }
            }
          },
          icon: Icon(Icons.save),
          label: Text(
            'บันทึกข้อมูล',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> addDeviceStation() async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //String deviceToken = preferences.getString('device_token');

    print('*** Insert new device station');

    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/addDeviceStation.php?isAdd=true&device_token=$pref_Token&station_id=$selected_station_id';

    print('url => $url ');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'true') {
        print('Save Device Station completed');

        setState(() {
          routeToList();
        });
      }
    } catch (e) {}
  }

  Void routeToList() {
    print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Container showRadio() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: 300.0,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyStyle().mySizedbox(),
              MyStyle().showTitleHeader2('กรุณาระบุสถานีจอด: '),
              MyStyle().mySizedbox(),
              option1Radio(),
              option2Radio(),
              MyStyle().mySizedbox(),
            ],
          ),
        ],
      ),
    );
  }

  Row showImageRadio() {
    String dns = MyConstant().domain_url;

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Stack(
        children: <Widget>[
          Column(
            //mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () => setState(() => selected_station_id = 1),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
                  height: 100,
                  width: 300,
                  color: selected_station_id == 1
                      ? Colors.green.shade200
                      : Colors.transparent,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: 300.0,
                            height: 80.0,
                            //color: Colors.blue.shade200,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '$dns/SMILEPARK/station/station_01.png'),
                            ),
                          ),
                        ),
                      ),
                      MyStyle().showTitleHeader3('หาดบางแสน'),
                    ],
                  ),
                ),
              ),
              MyStyle().mySizedbox(),
              GestureDetector(
                onTap: () => setState(() => selected_station_id = 2),
                child: Container(
                  margin:
                      EdgeInsets.only(left: 10.0, right: 16.0, bottom: 16.0),
                  height: 100,
                  width: 300,
                  color: selected_station_id == 2
                      ? Colors.green.shade200
                      : Colors.transparent,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: 300.0,
                            height: 80.0,
                            //color: Colors.blue.shade200,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  '$dns/SMILEPARK/station/station_02.png'),
                            ),
                          ),
                        ),
                      ),
                      MyStyle().showTitleHeader3('วัดโสธรวราราม'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget option1Radio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: selected_station_id,
                onChanged: (value) {
                  setState(() {
                    selected_station_id = value;
                  });
                },
              ),
              Text('หาดบางแสน', style: TextStyle(color: MyStyle().darkColor))
            ],
          ),
        ),
      ],
    );
  }

  Widget option2Radio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: 2,
                groupValue: selected_station_id,
                onChanged: (value) {
                  setState(() {
                    selected_station_id = value;
                  });
                },
              ),
              Text('วัดโสธรวราราม',
                  style: TextStyle(color: MyStyle().darkColor))
            ],
          ),
        ),
      ],
    );
  }
}
