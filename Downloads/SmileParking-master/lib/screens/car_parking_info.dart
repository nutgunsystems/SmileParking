import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smileparking/model/carmodel.dart';
import 'package:smileparking/screens/obstacle.dart';
import 'package:smileparking/utility/my_cons.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/my_utf8.dart';
import 'package:smileparking/utility/signout.dart';

import 'package:smileparking/utility/warning_dialog.dart';

class CarParking extends StatefulWidget {
  @override
  _CarParkingState createState() => _CarParkingState();
}

class _CarParkingState extends State<CarParking> {
  CarModel carModel;
  Future<void> _launched;

  File myFile;
  String car_id,
      car_identify,
      car_province,
      owner_name,
      owner_contact,
      url_carimage;

  String dns = MyConstant().domain_url;

  @override
  void initState() {
    super.initState();

    //carModel == null ? readCarInfo() : showContent();
    readCarInfo();
  }

  Future<Null> readCarInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');

    print('Read car_id : $id');

    String url = '$dns/SMILEPARK/getCar.php?isAdd=true&car_id=$id';
    //print('URL >>> $url');

    Response response = await Dio().get(url);
    //print('response ====> $response');

    //Display thai - unicode UTF-8
    var result = json.decode(response.data);
    //print('result ====>> $result');

    for (var map in result) {
      //print('map ====>>> $map');

      setState(() {
        carModel = CarModel.fromJson(map);
        car_id = carModel.id;
        car_identify = carModel.carIdentify;
        car_province = carModel.carProvince;
        owner_name = carModel.ownerName;
        owner_contact = carModel.ownerContact;
        url_carimage = carModel.urlImage;
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
        title: Text('แสดงข้อมูลรถยนต์ที่ลงทะเบียน'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => routeToHomePage(context),
          ),
        ],
      ),
      body: carModel == null ? MyStyle().showProgress() : showContent(),
    );
  }

  Widget showContent() => SingleChildScrollView(
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
                    Icons.room,
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
                initialValue: owner_contact,
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
              child: showCall(),
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
          onPressed: () => carModel == null
              ? warningDialog(context, 'กรุณาระบุข้อมูลรถยนต์')
              : //Open car info in next page.
              checkDup_Obstacle(),
          icon: Icon(Icons.edit),
          label: Text(
            'แจ้งจอดกีดขวาง',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> checkDup_Obstacle() async {
    String dns = MyConstant().domain_url;
    String url = '$dns/SMILEPARK/getObstacle.php?isAdd=true&car_id=$car_id';

    try {
      print('url >> $url');

      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        routeToService(Obstacle(), carModel);
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
    prefs.setString('url_image', myCarModel.urlImage);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }
}
