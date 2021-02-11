import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/carmodel.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:Smileparking/utility/warning_dialog.dart';
import 'package:intl/intl.dart';

import 'car_parking_info.dart';

class RegList extends StatefulWidget {
  @override
  _RegListState createState() => _RegListState();
}

class _RegListState extends State<RegList> {
  List<CarModel> carModelset = List();

  List<Widget> regCards = List();

  String myServerDate = '';
  String default_image = '/SMILEPARK/car/pic_car_default.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    findCar();
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
            value: regCards,
            updateShouldNotify: (oldValue, newValue) => true,
            child:
                regCards.length == 0 ? MyStyle().showProgress() : ChildWidget(),
          ),
        ),
      ),
    );
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
  }

  Future<Null> findCar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String car_identify = preferences.getString('car_identify');
    //String car_province = preferences.getString('car_province');

    String rec_id = '';

    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/findCar.php?isAdd=true&car_identify=$car_identify';

    try {
      print('$url');

      Response response = await Dio().get(url);
      //print('response = $response');

      //support thai display value.
      var result = json.decode(response.data);
      //print('result = $result');

      if (result == null) {
        warningDialog(
            context, 'ไม่พบข้อมูลรถยนต์ที่ท่านระบุ, กรุณาตรวจสอบอีกครั้ง.');

        //routeToHomePage(context);
      }
      regCards.clear();
      int index = 0;
      for (var map in result) {
        CarModel myCards = CarModel.fromJson(map);

        rec_id = myCards.id;

        if (rec_id.isNotEmpty) {
          //print('car_identify = ${myCards.carIdentify}');
          carModelset.add(myCards);

          setState(() {
            regCards.add(createCards(myCards, index));
            index++;
          });
        }
      }
    } catch (e) {}
  }

  Widget createCards(CarModel cardsModel, int index) {
    String dns = MyConstant().domain_url;
    String car_picture = cardsModel.urlImage;
    String url_carpicture = '';

    if (car_picture.isEmpty || car_picture == '' || car_picture == null) {
      car_picture = default_image;

      //print('OK*****');
    }

    url_carpicture = '$dns$car_picture';

    //print('url_carpicture > $url_carpicture');

    return GestureDetector(
      onTap: () {
        print('Click car cards index[$index]');

        MaterialPageRoute routepage = MaterialPageRoute(
          builder: (context) => CarParking(carModel: carModelset[index]),
        );
        Navigator.push(context, routepage);
        //Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
      },
      child: Card(
        color: Colors.white,
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
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    width: 160.0,
                    height: 80.0,
                    //color: Colors.blue.shade200,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url_carpicture),
                    ),
                  ),
                ),
              ),
              MyStyle().showTitleHeader2('${cardsModel.carIdentify}'),
              Text('${cardsModel.carProvince}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget showCurrentDate() {
    DateTime currdateTime = DateTime.now();
    String myCurrentDate = DateFormat('yyyy-MM-dd').format(currdateTime);

    return (myServerDate == '' || myCurrentDate.isEmpty)
        ? Text('รถจอดลงทะเบียน $myCurrentDate')
        : Text('รถจอดลงทะเบียน $myServerDate');
  }

  Future<Null> getServerDate() async {
    String dns = MyConstant().domain_url;
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
