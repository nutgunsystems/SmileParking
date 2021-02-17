import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/carmodel.dart';
import 'package:Smileparking/screens/car_parking_info.dart';
import 'package:Smileparking/screens/reg_list.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_search.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/my_utf8.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:Smileparking/utility/warning_dialog.dart';

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
        title: Text('ค้นหาข้อมูลรถยนต์ลงทะเบียน'),
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
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            myLogo(),
            MyStyle().mySizedbox(),
            carField(),
            provinceField(),
            MyStyle().mySizedbox(),
            searchButton(),
            MyStyle().mySizedbox(),
          ],
        ),
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
                  helperText: 'ตัวอย่าง "กก 888", "กก-888", "กก888" เป็นต้น',
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
      color: MyStyle().darkColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        if (car_identify == null || car_identify.isEmpty) {
          warningDialog(context, 'กรุณากรอกทะเบียนรถ.');
        } else {
          print('>>>>>> Search Car INFO');

          findCar();
        }
      },
      icon: Icon(Icons.search),
      textColor: Colors.white,
      label: Text('ค้นหา', style: TextStyle(color: Colors.white)),
    );
  }

  Future<Null> findCar() async {
    int rec_count = 0;
    CarModel carModelset;
    String url = '';

    String dns = MyConstant().domain_url;

    String identify_search = MySearch().removeSpecChar(car_identify.toString());

    print('car_identify = $car_identify');

    print('identify_search = $identify_search');

    url = (car_province == null || car_province.trim() == '')
        ? '$dns/SMILEPARK/findIdentify.php?isAdd=true&identify_search=$identify_search'
        : '$dns/SMILEPARK/findIdentify.php?isAdd=true&identify_search=$identify_search&car_province=$car_province';

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
        carModelset = CarModel.fromJson(map);

        rec_count++;
      }

      print('count records >>>> $rec_count');

      if (rec_count == 1) {
        //Open car info in next page.
        print('found one');
        //print(' car id : ${carModelset.id}');
        routeToService(CarParking(), carModelset);
      } else if (rec_count > 1) {
        //Open car List in next page.
        print('found more one');
        routeToService(RegList(), carModelset);
      } else {
        warningDialog(
            context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');
      }
    } catch (e) {}
  }

  Future<Null> routeToService(Widget myWidget, CarModel myCarModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', myCarModel.id);
    prefs.setString('car_identify', myCarModel.carIdentify);
    prefs.setString('car_province', myCarModel.carProvince);
    prefs.setString('owner_device_token', myCarModel.deviceToken);

    //print('>>>>>>>> OK');

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, routepage);
    //Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }
}
