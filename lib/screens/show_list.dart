import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/cardsmodel.dart';
import 'package:Smileparking/model/dsmodel.dart';
import 'package:Smileparking/screens/add_car_info.dart';
import 'package:Smileparking/screens/edit_obstacle.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:intl/intl.dart';

class ShowList extends StatefulWidget {
  ShowList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  List<CardsModel> obstaclesModel = List();

  List<Widget> carCards = List();

  DSModel dsmodelset;

  double myScreen = 0.0;

  String myServerDate = '';
  String myToken = '';

  String myStation_ID = '';
  String myStation_EN = '';
  String myStation_TH = '';
  String myStation_Lat = '';
  String myStation_Long = '';

  String pref_membertype = '';
  String pref_name = '';

  bool isAnnounced = false;

  //String default_image = '/SMILEPARK/obstacle/pic_default01.jpg';
  String default_image = '/SMILEPARK/images/pic_default01.jpg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getServerDate();

    getToken();

    aboutNotification();
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Widget showCurrentDate() {
    DateTime currdateTime = DateTime.now();
    String myCurrentDate = DateFormat('yyyy-MM-dd').format(currdateTime);
    String myAdmin = '';

    if (pref_membertype != null) {
      myAdmin = '[$pref_membertype]';
    }

    return (myServerDate == '' || myCurrentDate.isEmpty)
        ? Text('จอดกีดขวาง $myCurrentDate $myAdmin')
        : Text('จอดกีดขวาง $myServerDate $myAdmin');
  }

  Future<Null> getServerDate() async {
    String dns = MyConstant().domain_url;
    String currdate = '';
    String url = '$dns/SMILEPARK/getServerDate.php?isAdd=true';

    try {
      //print('>>>>> get current date.');

      Response response = await Dio().get(url);
      print('get current date = $response');
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

    if (myToken.trim() != '') {
      //print('myToken : $myToken');

      getDeviceStation();

      checkDeviceInfo();
    }
  }

  Future<Null> getDeviceStation() async {
    //print('>>> pref_membertype = $pref_membertype');
    //print('>>> pref_name = $pref_name');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/getDeviceStation.php?isAdd=true&device_token=$myToken';

    //print('$url');

    try {
      Response response = await Dio().get(url);
      //print('response = $response');

      //support thai display value.
      var result = json.decode(response.data);
      //print('result = $result');

      if (result != null) {
        for (var map in result) {
          //print('map ====>>> $map');

          dsmodelset = DSModel.fromJson(map);

          myStation_ID = dsmodelset.refStationId;
          myStation_EN = dsmodelset.stationNameEn;
          myStation_TH = dsmodelset.stationNameTh;
          myStation_Lat = dsmodelset.latPosition;
          myStation_Long = dsmodelset.longPosition;

          print('myStation_ID : $myStation_ID');
          print('Lat : Long = $myStation_Lat , $myStation_Long');

          prefs.setString('device_station_id', myStation_ID);
          prefs.setString('device_station_en', myStation_EN);
          prefs.setString('device_station_th', myStation_TH);
          prefs.setString('device_station_lat', myStation_Lat);
          prefs.setString('device_station_long', myStation_Long);
        }
      }

      //print('myStation_ID : $myStation_ID');

      if ((myStation_ID.isEmpty) || (myStation_ID.trim() == '')) {
        print('Add Default');

        addDeviceStation();
      } else {
        findObstacle();
      }
    } catch (e) {}
  }

  Future<Null> addDeviceStation() async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //String deviceToken = preferences.getString('device_token');

    print('*** Insert default device station');

    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/addDeviceStation.php?isAdd=true&device_token=$myToken&station_id=1';

    //print('url => $url ');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'true') {
        print('Save Device Station completed');

        setState(() {
          getDeviceStation();
        });
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);
      }
    } catch (e) {}
  }

  Future<Null> checkDeviceInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/getDeviceInfo.php?isAdd=true&device_token=$myToken';

    //print('url = $url');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'null') {
        print('process check device by obstacle.');

        checkDeviceInfobyObstacle();
      }
    } catch (e) {}
  }

  Future<Null> checkDeviceInfobyObstacle() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/getDeviceInfo_obstacle.php?isAdd=true&device_token=$myToken';

    //print('url = $url');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'null') {
        print('go to page Add Car.');

        routeToAddCar();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    //Variable of Page screen width size
    myScreen = MediaQuery.of(context).size.width;

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
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: getRefresh,
          child: Provider.value(
            value: carCards,
            updateShouldNotify: (oldValue, newValue) => true,
            child:
                carCards.length == 0 ? MyStyle().showProgress() : ChildWidget(),
          ),
        ),
      ),
    );
  }

  void routeToReload() {
    //print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  void routeToAddCar() {
    //print('Button click add');
    Widget myWidget = AddCarInfo();

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    //Navigator.push(context, route);
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  Future<Null> findObstacle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    pref_membertype = preferences.getString('membertype');
    pref_name = preferences.getString('name');

    //print('>>> pref_membertype = $pref_membertype');
    //print('>>> pref_name = $pref_name');

    String rec_id = '';

    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/findObstacle.php?isAdd=true&station_id=$myStation_ID';

    //print('$url');

    try {
      Response response = await Dio().get(url);
      //print('response = $response');

      //support thai display value.
      var result = json.decode(response.data);
      //print('result = $result');

      if (result == null) {
        //warningDialog(context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');

        routeToHomePage(context);
      }
      carCards.clear();
      int index = 0;
      for (var map in result) {
        isAnnounced = false;
        CardsModel myCards = CardsModel.fromJson(map);

        rec_id = myCards.id;

        if (rec_id.isNotEmpty) {
          //print('car_identify = ${myCards.carIdentify}');

          //print('totalAnnounce = ${myCards.totalAnnounce}');

          //print('isAnnounced = $isAnnounced');

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
    String car_picture = cardsModel.refCarPicture;
    String obstacle_picture = cardsModel.urlImage;
    String url_obstaclepicture = '';

    String car_identify = (cardsModel.refCarId == null)
        ? cardsModel.carIdentify
        : cardsModel.refCarIdentify;

    String car_province = (cardsModel.refCarId == null)
        ? cardsModel.carProvince
        : cardsModel.refCarProvince;

    if ((obstacle_picture.isEmpty || obstacle_picture == '') &&
        (car_picture.isEmpty || car_picture == '')) {
      obstacle_picture = default_image;
    } else if ((obstacle_picture.isEmpty || obstacle_picture == '') &&
        (car_picture.isNotEmpty || car_picture != '')) {
      obstacle_picture = car_picture;
    }

    Color myCard_COLOR = Colors.blue.shade200;

    //myCard_COLOR = (isAnnounced == false) ? Colors.blue.shade200 : Colors.green.shade200;
    myCard_COLOR =
        (cardsModel.totalAnnounce.isEmpty || cardsModel.totalAnnounce == '0')
            ? Colors.red.shade200
            : Colors.green.shade200;

    if (cardsModel.totalAnnounce.isNotEmpty &&
        cardsModel.totalAnnounce != '0') {
      obstacle_picture = '/SMILEPARK/images/anouncement.png';
    }

    url_obstaclepicture = '$dns$obstacle_picture';

    //print('url_obstaclepicture > $url_obstaclepicture');

    return GestureDetector(
      onTap: () {
        //print('Click cards index[$index]');

        MaterialPageRoute routepage = MaterialPageRoute(
          builder: (context) => EditObstacle(cardsModel: obstaclesModel[index]),
        );
        print('Go to EditObstacle Page');
        Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
      },
      child: Card(
        color: myCard_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 2,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    width: 160.0,
                    height: 80.0,
                    //color: Colors.blue.shade300,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      backgroundImage: NetworkImage(url_obstaclepicture),
                    ),
                  ),
                ),
              ),
              MyStyle().showTitleHeader2('$car_identify'),
              Text('$car_province'),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> routeToService(Widget myWidget, CardsModel myCardsModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', myCardsModel.id);
    //prefs.setString('car_identify', myCardsModel.carIdentify);
    //prefs.setString('car_province', myCardsModel.carProvince);
    //prefs.setString('url_image', myCardsModel.urlImage);
    //prefs.setString('owner_token', myCardsModel.deviceToken);

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }

  Future<Null> aboutNotification() async {
    if (Platform.isAndroid) {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging();
      await firebaseMessaging.configure(
        onLaunch: (message) {
          print('Notification onLaunch');
        },
        onMessage: (message) {
          print('Notification onMessage');
          //normalDialog(context, 'Refresh');
          routeToReload();
        },
        onResume: (message) {
          print('Notification onResume');
        },
      );
    } else if (Platform.isAndroid) {}
  }

  static Future<bool> checkAnnounced(String my_obstacle_id) async {
    String dns = MyConstant().domain_url;

    String url =
        '$dns/SMILEPARK/getAnnounce.php?isAdd=true&obstacle_id=$my_obstacle_id';

    //print('url >>> $url ');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        return Future<bool>.value(false);
      } else {
        //print('check OK');
        return Future<bool>.value(true);
      }
    } catch (e) {}
  }
}

class ChildWidget extends StatefulWidget {
  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  List<Widget> recCards = List();

  @override
  void initState() {
    //print('initState(), counter = $_counter');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    recCards = Provider.of<List<Widget>>(context);
    //print('didChangeDependencies(), counter = $_counter');
    super.didChangeDependencies();
  }

  GridView showGridView() {
    return GridView.extent(
      maxCrossAxisExtent: 160.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      children: recCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return showGridView();
  }
}
