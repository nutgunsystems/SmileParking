import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smileparking/model/mobilemodel.dart';
import 'package:smileparking/screens/show_list.dart';
import 'package:smileparking/utility/my_cons.dart';
import 'package:smileparking/utility/my_search.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/my_utf8.dart';
import 'package:smileparking/utility/signout.dart';

import 'package:smileparking/utility/warning_dialog.dart';

class AddCarInfo extends StatefulWidget {
  @override
  _AddCarInfoState createState() => _AddCarInfoState();
}

class _AddCarInfoState extends State<AddCarInfo> {
  File myFile;
  String car_identify, car_province, owner_name, owner_contact, url_carimage;

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';
  String identify_search = '';

  MobileModel mobileModel;
  String _platformImei = 'Unknown';
  String uniqueId = "Unknown";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDeviceStation();
    //initPlatformState();
    //readMobileInfo();
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

  Future<Null> getDeviceStation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      pref_Station_ID = preferences.getString('device_station_id');
      pref_Station_EN = preferences.getString('device_station_en');
      pref_Station_TH = preferences.getString('device_station_th');
    });

    print('pref_Station_TH : $pref_Station_TH');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียนรถยนต์'),
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
            nameField(),
            contactField(),
            MyStyle().mySizedbox(),
            groupImageField(),
            MyStyle().mySizedbox(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Widget nameField() => Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) => owner_name = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.shop,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อเจ้าของรถ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
                maxLength: 100,
                inputFormatters: [
                  MyUtf8_LengthLimitingTextInputFormatter(100),
                ],
              ),
            ),
          ],
        ),
      );

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
                  helperText: 'ตัวอย่าง "กกก 8888" หรือ "กกก-8888" เป็นตัน',
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

  Widget contactField() => Container(
        margin: EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextField(
                onChanged: (value) => owner_contact = value.trim(),
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
                maxLength: 100,
                inputFormatters: [
                  MyUtf8_LengthLimitingTextInputFormatter(100),
                ],
              ),
            ),
          ],
        ),
      );

  RaisedButton saveButton() {
    return RaisedButton.icon(
      color: MyStyle().darkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: () {
        if ((owner_name == null || owner_name.isEmpty) &&
            (owner_contact == null || owner_contact.isEmpty) &&
            (car_identify == null || car_identify.isEmpty)) {
          warningDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน.');
        } else {
          if (owner_name == null || owner_name.isEmpty) {
            warningDialog(context, 'กรุณากรอกชื่อเจ้าของรถ.');
          } else if (owner_contact == null || owner_contact.isEmpty) {
            warningDialog(context, 'กรุณากรอกเบอร์ติดต่อ.');
          } else if (car_identify == null || car_identify.isEmpty) {
            warningDialog(context, 'กรุณากรอกหมายเลขทะเบียนรถ.');
          } else if (myFile == null) {
            warningDialog(context, 'กรุณาถ่ายภาพรถของท่านอีกครั้ง.');
          } else {
            //print('>>>>>> Add Car INFO');

            checkDup_Car();
          }
        }
      },
      icon: Icon(Icons.save),
      textColor: Colors.white,
      label: Text(
        'บันทึกข้อมูล',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Future<Null> uploadPhoto() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = 'pic_car$i.jpg';

    String url = '${MyConstant().domain_url}/SMILEPARK/saveCarPhoto.php';

    print('***** Upload Photo');

    try {
      Map<String, dynamic> mapObj = Map();
      mapObj['file'] =
          await MultipartFile.fromFile(myFile.path, filename: nameFile);

      FormData formData = FormData.fromMap(mapObj);
      await Dio().post(url, data: formData).then((value) {
        //print('url = $url');
        //print('filename = $nameFile, pathImage = ${myFile.path}');
        //print('Response ==>> $value');

        url_carimage = '/SMILEPARK/car/$nameFile';

        //print('urlImage = $url_carimage');

        //ADD Process

        addCarInfo();
      });
    } catch (e) {}
  }

  Future<Null> addCarInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String deviceToken = preferences.getString('device_token');

    print('*** Insert new record');

    String dns = MyConstant().domain_url;
    String url = '';
    try {
      identify_search = MySearch().removeSpecChar(car_identify.toString());

      print('car_identify = $car_identify');

      print('identify_search = $identify_search');

      url =
          '$dns/SMILEPARK/addCar.php?isAdd=true&addCar.php?isAdd=true&car_identify=$car_identify&car_province=$car_province&owner_name=$owner_name&owner_contact=$owner_contact&url_image=$url_carimage&device_token=$deviceToken&identify_search=$identify_search';

      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'true') {
        print('Save Car completed');
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);
        routeToList();
      } else {
        warningDialog(context, 'Save failed. Please check values again');
      }
    } catch (e) {}
  }

  Void routeToList() {
    //print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Future<Null> checkDup_Car() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/findCar.php?isAdd=true&car_identify=$car_identify&car_province=$car_province';

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        uploadPhoto();
        //Navigator.pop(context);
      } else {
        warningDialog(context, 'รถท่านได้ลงทะเบียนแล้ว, กรุณาตรวจสอบอีกครั้ง');
      }
    } catch (e) {}
  }

  Future<Null> editCarInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String car_id = preferences.getString('id');
    String dns = MyConstant().domain_url;

    String url =
        '$dns/SMILEPARK/editCarInfo.php?isAdd=true&isAdd=true&id=$car_id&car_identify=$car_identify&car_province=$car_province&owner_name=$owner_name&owner_contact=$owner_contact&url_image=$url_carimage';

    //print('URL >> $url');

    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        warningDialog(
            context, 'บันทึกข้อมูลผิดพลาด, กรุณาลองดำเนินการใหม่อีกครั้ง.');
      }
    });
  }

  Row groupImageField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
          iconSize: 36.0,
          icon: Icon(Icons.add_a_photo),
          onPressed: () => chooseImage(ImageSource.camera),
        ),
        Container(
          width: 150.0,
          child: myFile == null
              ? Image.asset(
                  'images/car01.jpg',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  myFile,
                  fit: BoxFit.cover,
                ),
        ),
        IconButton(
          iconSize: 36.0,
          icon: Icon(Icons.add_photo_alternate),
          onPressed: () => chooseImage(ImageSource.gallery),
        ),
      ],
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    var filePicture = await ImagePicker.pickImage(
      source: imageSource,
      maxHeight: 427.0,
      maxWidth: 640.0,
      imageQuality: 100,
    );
    setState(() {
      myFile = filePicture;
    });
  }

  Widget myLogo() => Container(
        width: 100.0,
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStyle().showPark(),
          ],
        ),
      );
}
