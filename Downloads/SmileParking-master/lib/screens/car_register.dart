import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smileparking/model/carmodel.dart';
import 'package:smileparking/screens/car_parking_info.dart';
import 'package:smileparking/utility/my_cons.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/my_utf8.dart';
import 'package:smileparking/utility/warning_dialog.dart';

class Car_Register extends StatefulWidget {
  @override
  _Car_RegisterState createState() => _Car_RegisterState();
}

class _Car_RegisterState extends State<Car_Register> {
  String car_identify, car_province;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กรอกทะเบียนรถยนต์ที่ต้องการค้นหาข้อมูล'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: <Widget>[
          myLogo(),
          MyStyle().mySizedbox(),
          carField(),
          provinceField(),
          MyStyle().mySizedbox(),
          searchButton()
        ],
      ),
    );
  }

  Widget carField() => Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) => car_identify = value.trim(),
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
                maxLength: 20,
                inputFormatters: [
                  MyUtf8_LengthLimitingTextInputFormatter(20),
                ],
              ),
            ),
          ],
        ),
      );

  Widget provinceField() => Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) => car_province = value.trim(),
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
                maxLength: 50,
                inputFormatters: [
                  MyUtf8_LengthLimitingTextInputFormatter(50),
                ],
              ),
            ),
          ],
        ),
      );

  Widget myLogo() => Container(
        width: 100.0,
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStyle().showFinder(),
          ],
        ),
      );

  RaisedButton searchButton() {
    return RaisedButton.icon(
      onPressed: () {
        if (car_identify == null || car_identify.isEmpty) {
          warningDialog(context, 'กรุณากรอกทะเบียนรถ.');
        } else {
          print('>>>>>> Search Car INFO');

          findCar();
        }
      },
      icon: Icon(Icons.search),
      label: Text('ค้นหา'),
    );
  }

  Future<Null> findCar() async {
    String rec_id = '';

    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/findCar.php?isAdd=true&car_identify=$car_identify&car_province=$car_province';

    try {
      //print('$url');

      Response response = await Dio().get(url);
      //print('response = $response');

      //support thai display value.
      var result = json.decode(response.data);
      print('result = $result');

      if (result == null) {
        warningDialog(
            context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');
      }

      for (var map in result) {
        CarModel carModelset = CarModel.fromJson(map);

        rec_id = carModelset.id;

        print('rec_id >>>> $rec_id');

        if (rec_id.trim() != '' && rec_id.isNotEmpty) {
          print('car : ${carModelset.carIdentify}');

          //Open car info in next page.
          routeToService(CarParking(), carModelset);
        } else {
          warningDialog(
              context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, CarModel myCarModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', myCarModel.id);
    prefs.setString('car_identify', myCarModel.carIdentify);
    prefs.setString('car_province', myCarModel.carProvince);
    prefs.setString('device_token', myCarModel.deviceToken);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }
}
