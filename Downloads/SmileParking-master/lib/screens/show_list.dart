import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:instant/instant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smileparking/model/cardsmodel.dart';
import 'package:smileparking/screens/edit_obstacle.dart';
import 'package:smileparking/utility/my_cons.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/normal_dialog.dart';
import 'package:smileparking/utility/signout.dart';
import 'package:smileparking/utility/warning_dialog.dart';
import 'package:intl/intl.dart';

class ShowList extends StatefulWidget {
  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  List<CardsModel> obstaclesModel = List();
  List<Widget> carCards = List();
  String myServerDate = '';
  String myToken = '';

  String default_image = '/SMILEPARK/obstacle/pic_default01.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    getServerDate();
    getToken();
    findObstacle();
  }

  Widget showCurrentDate() {
    DateTime currdateTime = DateTime.now();
    String myCurrentDate = DateFormat('yyyy-MM-dd').format(currdateTime);

    return (myServerDate == '' || myCurrentDate.isEmpty)
        ? Text('จอดกีดขวาง $myCurrentDate')
        : Text('จอดกีดขวาง $myServerDate');
  }

  Future<Null> getServerDate() async {
    String dns = MyConstant().domain_url;
    String currdate = '';
    String url = '$dns/SMILEPARK/getServerDate.php?isAdd=true';

    try {
      print('>>>>> get current date.');

      Response response = await Dio().get(url);
      print('res = $response');
      if (response.toString() != '') {
        myServerDate = response.toString();
      }
    } catch (e) {}
  }

  Future<Null> getToken() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();

    myToken = await firebaseMessaging.getToken();
    //print('myToken ====>>> $myToken');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('device_token', myToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showCurrentDate(),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => routeToHomePage(context),
          ),
        ],
      ),
      body: carCards.length == 0 ? MyStyle().showProgress() : showGridView(),
    );
  }

  GridView showGridView() {
    return GridView.extent(
      maxCrossAxisExtent: 160.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: carCards,
    );
  }

  Future<Null> findObstacle() async {
    String rec_id = '';

    String dns = MyConstant().domain_url;
    String url = '$dns/SMILEPARK/findObstacle.php?isAdd=true';

    try {
      //print('$url');

      Response response = await Dio().get(url);
      //print('response = $response');

      //support thai display value.
      var result = json.decode(response.data);
      //print('result = $result');

      if (result == null) {
        //warningDialog(context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');

        routeToHomePage(context);
      }
      int index = 0;
      for (var map in result) {
        CardsModel myCards = CardsModel.fromJson(map);

        rec_id = myCards.id;

        if (rec_id.isNotEmpty) {
          //print('car_identify = ${myCards.carIdentify}');
          obstaclesModel.add(myCards);

          setState(() {
            carCards.add(createCards(myCards, index));
            index++;
          });
        }
      }
    } catch (e) {}
  }

  Widget createCards(CardsModel cardsModel, int index) {
    String dns = MyConstant().domain_url;
    String car_picture = cardsModel.urlImage;
    String obstacle_picture = cardsModel.urlImage;
    String url_obstaclepicture = '';

    if ((obstacle_picture.isEmpty || obstacle_picture == '') &&
        (car_picture.isEmpty || car_picture == '')) {
      obstacle_picture = default_image;
    } else if ((obstacle_picture.isEmpty || obstacle_picture == '') &&
        (car_picture.isNotEmpty || car_picture != '')) {
      obstacle_picture = car_picture;
    }

    url_obstaclepicture = '$dns$obstacle_picture';

    //print('url_obstaclepicture > $url_obstaclepicture');

    return GestureDetector(
      onTap: () {
        print('Click cards index[$index]');

        MaterialPageRoute routepage = MaterialPageRoute(
          builder: (context) => EditObstacle(cardsModel: obstaclesModel[index]),
        );

        Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 70.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(url_obstaclepicture),
              ),
            ),
            MyStyle().showTitle('${cardsModel.carIdentify}'),
          ],
        ),
      ),
    );
  }

  Future<Null> routeToService(Widget myWidget, CardsModel myCardsModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', myCardsModel.id);
    prefs.setString('car_identify', myCardsModel.carIdentify);
    prefs.setString('car_province', myCardsModel.carProvince);
    prefs.setString('url_image', myCardsModel.urlImage);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  
}
