import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:Smileparking/utility/my_phone.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/carmodel.dart';
import 'package:Smileparking/screens/obstacle.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/my_utf8.dart';
import 'package:Smileparking/utility/signout.dart';

import 'package:Smileparking/utility/warning_dialog.dart';

class CarParking extends StatefulWidget {
  final CarModel carModel;
  CarParking({Key key, this.carModel}) : super(key: key);
  @override
  _CarParkingState createState() => _CarParkingState();
}

class _CarParkingState extends State<CarParking> {
  CarModel carModelset;

  Future<void> _launched;

  File myFile;
  String car_id,
      car_identify,
      car_province,
      owner_name,
      owner_contact,
      owner_contact_hidden,
      owner_token,
      url_carimage;

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';

  String dns = MyConstant().domain_url;

  @override
  void initState() {
    super.initState();
    carModelset = widget.carModel;
    //car_id = (carModel.id == null|| carModel.id == '') ? '' : carModel.id;
    carModelset == null
        ? readCarInfo()
        : //print('<< car selected ${carModelset.id} >>')
        setState(() {
            car_id = carModelset.id;
            car_identify = carModelset.carIdentify;
            car_province = carModelset.carProvince;
            owner_name = carModelset.ownerName;
            owner_contact = carModelset.ownerContact;

            owner_token = carModelset.deviceToken;
            url_carimage = carModelset.urlImage;
          });

    getDeviceStation();
  }

  Future<Null> getDeviceStation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      pref_Station_ID = preferences.getString('device_station_id');
      pref_Station_EN = preferences.getString('device_station_en');
      pref_Station_TH = preferences.getString('device_station_th');
    });

    print('pref_Station_TH : $pref_Station_TH');
  }

  Future<Null> readCarInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String pref_id = preferences.getString('id');
    String url = '';

    print('Read car id : $pref_id');

    url = (car_id == null || car_id.toString() == '')
        ? '$dns/SMILEPARK/getCar.php?isAdd=true&car_id=$pref_id'
        : '$dns/SMILEPARK/getCar.php?isAdd=true&car_id=$car_id';

    //print('URL >>> $url');

    Response response = await Dio().get(url);
    //print('response ====> $response');

    //Display thai - unicode UTF-8
    var result = json.decode(response.data);
    //print('result ====>> $result');

    for (var map in result) {
      //print('map ====>>> $map');

      setState(() {
        carModelset = CarModel.fromJson(map);
        car_id = carModelset.id;
        car_identify = carModelset.carIdentify;
        car_province = carModelset.carProvince;
        owner_name = carModelset.ownerName;
        owner_contact = carModelset.ownerContact;
        owner_contact_hidden = MyPhone().replacePhoneNo(owner_contact);
        owner_token = carModelset.deviceToken;
        url_carimage = carModelset.urlImage;
      });
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลรถยนต์ที่ลงทะเบียน'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => routeToHomePage(context),
          ),
        ],
      ),
      body: carModelset == null ? MyStyle().showProgress() : showContent(),
    );
  }

  Widget showContent() => SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[Colors.white, MyStyle().primaryColor],
              center: Alignment(0, -0.3),
              radius: 1.0,
            ),
          ),
          child: Column(
            children: [
              myLogo(),
              MyStyle().mySizedbox(),
              carField(),
              provinceField(),
              nameField(),
              contactField(),
              MyStyle().mySizedbox(),
              imageField(),
              MyStyle().mySizedbox(),
              showEditButton(),
            ],
          ),
        ),
      );

  Widget myLogo() => Container(
        width: 120.0,
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStyle().showCar(),
          ],
        ),
      );

  Widget nameField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: owner_name,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.shop,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อเจ้าของ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
          ],
        ),
      );

  Widget carField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: car_identify,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.directions_car,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'หมายเลขทะเบียนรถ',
                  helperText: 'กรุณาระบุเฉพาะหมายเลขทะเบียน',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
          ],
        ),
      );

  Widget provinceField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: car_province,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.local_activity,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'จังหวัด',
                  helperText: 'กรุณาระบุจังหวัด',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
          ],
        ),
      );

  Widget contactField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260.0,
              child: TextFormField(
                initialValue: owner_contact_hidden,
                enabled: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'เบอร์ติดต่อ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
            Container(
              width: 60.0,
              child: showCallbutton(),
            ),
          ],
        ),
      );

  Widget showCall() {
    return RaisedButton.icon(
      color: Colors.blue[200],
      onPressed: () => setState(() {
        _launched = _makePhoneCall('tel:$owner_contact');
      }),
      icon: Icon(Icons.phone_in_talk),
      label: Text(
        '',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget showCallbutton() {
    return SizedBox.fromSize(
      size: Size(56, 56), // button width and height
      child: ClipOval(
        child: Material(
          color: Colors.orange, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () => setState(() {
              _launched = _makePhoneCall('tel:$owner_contact');
            }), // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call), // icon
                Text("Call"), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row imageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 250.0,
          child: Image.network('$dns$url_carimage'),
        ),
      ],
    );
  }

  Widget showEditButton() => Container(
        width: 300.0,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () => carModelset == null
              ? warningDialog(context, 'กรุณาระบุข้อมูลรถยนต์')
              : //Open car info in next page.
              checkDup_Obstacle(),
          icon: Icon(Icons.edit),
          label: Text(
            'แจ้งจอดกีดขวาง',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

  Future<Null> checkDup_Obstacle() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/getObstacle.php?isAdd=true&car_id=$car_id&station_id=$pref_Station_ID';

    try {
      print('checkDup url >> $url');

      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        routeToService(Obstacle(), carModelset);
        //Navigator.pop(context);
      } else {
        warningDialog(context, 'มีการแจ้งจอดกีดขวางแล้ว.');
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, CarModel myCarModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', myCarModel.id);
    prefs.setString('car_identify', myCarModel.carIdentify);
    prefs.setString('car_province', myCarModel.carProvince);
    prefs.setString('car_province', myCarModel.carProvince);
    prefs.setString('owner_device_token', myCarModel.deviceToken);
    prefs.setString('url_image', myCarModel.urlImage);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, routepage);
    //Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }
}
