import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade900;
  Color primaryColor = Colors.blue.shade200;
  Color drawerColor = Colors.blue.shade300;

  SizedBox mySizedbox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  SizedBox mylittleSizedbox() => SizedBox(
        width: 8.0,
        height: 4.0,
      );

  Container showLogo() {
    return Container(
      width: 80.0,
      child: Image.asset('images/car.png'),
    );
  }

  Container showSponsor() {
    return Container(
      width: 80.0,
      child: Image.asset('images/sponsor.jpg'),
    );
  }

  Container showPark() {
    return Container(
      width: 120.0,
      child: Image.asset('images/parking.png'),
    );
  }

  Container showFinder() {
    return Container(
      width: 120.0,
      child: Image.asset('images/finder_car.png'),
    );
  }

  Container showCar() {
    return Container(
      width: 120.0,
      child: Image.asset('images/car_parking.png'),
    );
  }

  Container showObstacle() {
    return Container(
      width: 120.0,
      child: Image.asset('images/icon_obstacle.png'),
    );
  }

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleWhite(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold),
      );

  Text showTitleBlack(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
      );

  Text showTitleGreen(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 24.0,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold),
      );

  Text showTextLabel(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 14.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.normal),
      );

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Text showTitleH1(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1White(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
      );

  Text showTitleH1Black(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
      );

  Text showTitleH1Green(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.green.shade300,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1Cyan(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.cyanAccent,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1Teal(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.tealAccent.shade400,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1LightBlue(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.lightBlueAccent.shade400,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1Yellow(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.yellow.shade400,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1Gley(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH1Red(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            color: Colors.redAccent,
            fontWeight: FontWeight.bold),
      );

  Text showTitleHeader2(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.blue.shade800,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH2White(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
      );

  Text showTitleH2Black(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      );

  Text showTitleH2Green(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.green.shade800,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH3Green(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 16.0,
            color: Colors.green.shade800,
            fontWeight: FontWeight.normal),
      );

  Text showTitleHeader3(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold),
      );

  Text showTitleH3White(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
      );

  Text showTitleH3Black(String title) => Text(
        title,
        style: TextStyle(
            fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
      );

  Widget showTitleCenter(BuildContext context, String title) {
    return Center(
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxHeader(String imgNamePic) {
    return BoxDecoration(
      image: DecorationImage(
        scale: 0.5,
        image: AssetImage('images/$imgNamePic'),
        fit: BoxFit.scaleDown,
      ),
      //borderRadius: BorderRadius.all(Radius.circular(20.0)),
      //color: Colors.white,
    );
  }

  Widget myBoxImage(String imgNamePic) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network('images/$imgNamePic',
                  // width: 300,
                  height: 100,
                  fit: BoxFit.fill))
        ]);
  }

  MyStyle();
}
