import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/carmodel.dart';
import 'package:Smileparking/screens/show_list.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:Smileparking/utility/warning_dialog.dart';

class Obstacle extends StatefulWidget {
  @override
  _ObstacleState createState() => _ObstacleState();
}

class _ObstacleState extends State<Obstacle> {
  CarModel carModel;

  File myFile;

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';

  String car_id,
      car_identify,
      car_province,
      device_token,
      informer_name,
      informer_contact,
      informer_token;

  String url_carimage = '';

  String default_image = 'images/pic_default01.jpg';

  String dns = MyConstant().domain_url;

  @override
  void initState() {
    super.initState();

    //carModel == null ? readCarInfo() : showContent();
    readCarInfo();
  }

  Future<Null> readCarInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String reg_id = preferences.getString('id');
    String reg_car_identify = preferences.getString('car_identify');
    String reg_car_province = preferences.getString('car_province');
    String reg_car_image = preferences.getString('url_image');
    String reg_device_token = preferences.getString('owner_device_token');
    String my_token = preferences.getString('device_token');

    pref_Station_ID = preferences.getString('device_station_id');
    pref_Station_EN = preferences.getString('device_station_en');
    pref_Station_TH = preferences.getString('device_station_th');

    //print('default_image >>> $default_image');
    print('owner token = $reg_device_token');
    print('informer token = $my_token');

    setState(() {
      car_id = reg_id;
      car_identify = reg_car_identify;
      car_province = reg_car_province;
      url_carimage = reg_car_image;
      device_token = reg_device_token;
      informer_token = my_token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งข้อมูลรถจอดขีดขวาง'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => routeToHomePage(context),
          ),
        ],
      ),
      body: car_id.isEmpty == true || car_id == ''
          ? MyStyle().showProgress()
          : showContent(),
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
              MyStyle().mySizedbox(),
              stationField(),
              nameField(),
              contactField(),
              MyStyle().mySizedbox(),
              groupImageField(),
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
            MyStyle().showObstacle(),
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
                onChanged: (value) => informer_name = value.trim(),
                enabled: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.shop,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อผู้แจ้ง',
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
              width: 300.0,
              child: TextFormField(
                onChanged: (value) => informer_contact = value.trim(),
                enabled: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'เบอร์ติดต่อผู้แจ้ง',
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

  Widget stationField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: pref_Station_TH,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.place,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'สถานทีจอดรถ',
                  helperText: 'สถานทีจอดรถของท่าน',
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
                  default_image,
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

  Future<Null> uploadPhoto() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = 'pic_obstacle$i.jpg';

    String url = '${MyConstant().domain_url}/SMILEPARK/saveObstaclePhoto.php';

    url_carimage = '/SMILEPARK/obstacle/$nameFile';

    print('***** upload Photo');

    try {
      Map<String, dynamic> mapObj = Map();
      mapObj['file'] =
          await MultipartFile.fromFile(myFile.path, filename: nameFile);

      FormData formData = FormData.fromMap(mapObj);
      await Dio().post(url, data: formData).then((value) {
        //print('url = $url');
        //print('filename = $nameFile, pathImage = ${myFile.path}');
        //print('Response ==>> $value');
      });
    } catch (e) {}
  }

  Future<Null> checkDup_Obstacle() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/getObstacle.php?isAdd=true&car_id=$car_id&station_id=$pref_Station_ID';

    print('url ==> $url');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        if (myFile != null) {
          uploadPhoto();
        }

        //ADD Process

        addObstacleInfo();

        //Navigator.pop(context);
      } else {
        warningDialog(context, 'มีการแจ้งจอดกีดขวางแล้ว.');
      }
    } catch (e) {}
  }

  Widget showEditButton() => Container(
        width: 300.0,
        child: RaisedButton.icon(
          color: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            print('click OK');
            if ((informer_name == null || informer_name.isEmpty) ||
                (informer_contact == null || informer_contact.isEmpty)) {
              warningDialog(context, 'กรุณากรอกข้อมูลผู้แจ้งให้ครบถ้วน.');
            } else {
              checkDup_Obstacle();
            }
          },
          icon: Icon(Icons.save),
          textColor: Colors.white,
          label: Text(
            'บันทึกข้อมูล',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> addObstacleInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/addObstacle.php?isAdd=true&car_id=$car_id&station_id=$pref_Station_ID&informer_name=$informer_name&informer_contact=$informer_contact&informer_token=$informer_token&url_image=$url_carimage';

    print('*** Insert new record for obstacle');
    print('url >>> $url');

    try {
      //print('URL >>> $url');

      Response response = await Dio().get(url);

      //print('res = $response');
      if (response.toString() == 'true') {
        print('Save Obstacle completed');

        (device_token == informer_token)
            ? print('This is notification for informer')
            : sendNotification(device_token);

        routeToShowList();
      } else {
        warningDialog(
            context, 'Save obstacle failed. Please check values again');
      }
    } catch (e) {}
  }

  void routeToShowList() {
    //print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  Future<Null> sendNotification(String mytoken) async {
    String title = 'การแจ้งเตือน';
    String body = 'รถยนต์ทะเบียน $car_identify จอดกีดขวาง';
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/apiNotification.php?isAdd=true&token=$mytoken&title=$title&body=$body';

    try {
      print('Notification URL >>> $url');

      Response response = await Dio().get(url);

      print('res = $response');
      if (response.toString() == 'true') {
        print('Send notification completed');
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);

        routeToHomePage(context);
      } else {
        //warningDialog(context, 'Send notification failed.');
      }
    } catch (e) {}
  }
}
