import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smileparking/model/cardsmodel.dart';
import 'package:smileparking/utility/my_cons.dart';
import 'package:smileparking/utility/my_style.dart';
import 'package:smileparking/utility/signout.dart';
import 'package:smileparking/utility/warning_dialog.dart';

class EditObstacle extends StatefulWidget {
  final CardsModel cardsModel;
  EditObstacle({Key key, this.cardsModel}) : super(key: key);
  @override
  _EditObstacleState createState() => _EditObstacleState();
}

class _EditObstacleState extends State<EditObstacle> {
  CardsModel cardsModel;
  String rec_id = '';
  bool fixed_status = false;
  String car_identify,
      car_province,
      informer_name,
      informer_contact,
      url_carimage;

  String default_image = '/SMILEPARK/obstacle/pic_default01.jpg';

  String dns = MyConstant().domain_url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardsModel = widget.cardsModel;
    rec_id = cardsModel.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'รถจอดกีดขวาง',
            style: TextStyle(
              //color: Colors.black,
              fontSize: 25.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () => routeToHomePage(context),
            ),
          ]),
      body: rec_id.isEmpty == true || rec_id == ''
          ? MyStyle().showProgress()
          : showContent(),
    );
  }

  Widget showContent() => SingleChildScrollView(
        child: Column(
          children: [
            imageField(),
            MyStyle().mySizedbox(),
            carField(),
            provinceField(),
            //ownercontactField(),
            showRadio(),
            nameField(),
            contactField(),
            MyStyle().mySizedbox(),
            showEditButton(),
          ],
        ),
      );

  Container showRadio() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: 300.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              MyStyle().showTitleHeader2('สถานะรอการยืนยัน: '),
            ],
          ),
          Row(
            children: [
              option1Radio(),
              option2Radio(),
            ],
          ),
        ],
      ),
    );
  }

  Widget ownercontactField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: '',
                enabled: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'เบอร์ติดต่อเจ้าของรถ',
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
                initialValue: cardsModel.carIdentify,
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
                initialValue: cardsModel.carProvince,
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

  Widget nameField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: cardsModel.informerName,
                enabled: false,
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

  Widget contactField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: cardsModel.informerContact,
                enabled: false,
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

  Row imageField() {
    String car_picture = cardsModel.carPicture;
    String obstacle_picture = cardsModel.urlImage;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          width: 250.0,
          child: (obstacle_picture == '' || obstacle_picture.isEmpty)
              ? Image.network('$dns$car_picture')
              : Image.network('$dns$obstacle_picture'),
        ),
      ],
    );
  }

  Widget option1Radio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: false,
                groupValue: fixed_status,
                onChanged: (value) {
                  setState(() {
                    fixed_status = value;
                  });
                },
              ),
              Text('จอดกีดขวาง', style: TextStyle(color: MyStyle().darkColor))
            ],
          ),
        ),
      ],
    );
  }

  Widget option2Radio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 150.0,
          child: Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: fixed_status,
                onChanged: (value) {
                  setState(() {
                    fixed_status = value;
                  });
                },
              ),
              Text('รับทราบแล้ว', style: TextStyle(color: MyStyle().darkColor))
            ],
          ),
        ),
      ],
    );
  }

  Widget showEditButton() => Container(
        width: 300.0,
        child: RaisedButton.icon(
          color: MyStyle().primaryColor,
          onPressed: () {
            print('click OK');
            if ((rec_id == null || rec_id.isEmpty)) {
              warningDialog(context, 'กรุณากรอกข้อมูลผู้แจ้งให้ครบถ้วน.');
            } else if (fixed_status == true) {
              EditObstacleInfo();
            }
          },
          icon: Icon(Icons.save),
          label: Text(
            'บันทึกข้อมูล',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> EditObstacleInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/fixedObstacle.php?isAdd=true&car_identify=${cardsModel.carIdentify}&car_province=${cardsModel.carProvince}';

    try {
      //print('>Edit obstacle. > url > $url');

      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
        print('Save Fixed Obstacle completed');
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);

        routeToHomePage(context);
      } else {
        warningDialog(context, 'Save failed. Please check values again');
      }
    } catch (e) {}
  }
}
