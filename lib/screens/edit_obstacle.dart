import 'package:Smileparking/utility/my_phone.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Smileparking/model/cardsmodel.dart';
import 'package:Smileparking/screens/show_list.dart';
import 'package:Smileparking/utility/my_cons.dart';
import 'package:Smileparking/utility/my_date.dart';
import 'package:Smileparking/utility/my_style.dart';
import 'package:Smileparking/utility/signout.dart';
import 'package:Smileparking/utility/warning_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class EditObstacle extends StatefulWidget {
  final CardsModel cardsModel;
  EditObstacle({Key key, this.cardsModel}) : super(key: key);
  @override
  _EditObstacleState createState() => _EditObstacleState();
}

class _EditObstacleState extends State<EditObstacle> {
  Future<void> _launched;

  CardsModel cardsModel;

  bool checkedValue = false;

  String pref_membertype = '';
  String pref_name = '';

  String pref_Station_ID = '';
  String pref_Station_EN = '';
  String pref_Station_TH = '';

  String rec_id = '';

  bool fixed_status = false;

  String car_identify,
      car_province,
      owner_contact,
      owner_contact_hidden,
      informer_name,
      informer_contact,
      informer_contact_hidden,
      url_carimage;

  String ownertoken = '';
  String informertoken = '';
  String deviceToken = '';

  String default_image = '/SMILEPARK/obstacle/pic_default01.jpg';

  String dns = MyConstant().domain_url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardsModel = widget.cardsModel;

    getToken();
    getAnnounce();
  }

  void routeToShow() {
    print('Button click add');
    Widget myWidget = ShowList();

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.push(context, route);
  }

  Future getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      deviceToken = preferences.getString('device_token');

      pref_membertype = preferences.getString('membertype');
      pref_name = preferences.getString('name');

      pref_Station_ID = preferences.getString('device_station_id');
      pref_Station_EN = preferences.getString('device_station_en');
      pref_Station_TH = preferences.getString('device_station_th');

      rec_id = cardsModel.id;
      car_identify = (cardsModel.refCarId == null)
          ? cardsModel.carIdentify
          : cardsModel.refCarIdentify;
      car_province = (cardsModel.refCarId == null)
          ? cardsModel.carProvince
          : cardsModel.refCarProvince;
      informertoken = cardsModel.informerDeviceToken;
      ownertoken = cardsModel.ownerDeviceToken;
      owner_contact = cardsModel.ownerContact;
      owner_contact_hidden = MyPhone().replacePhoneNo(owner_contact);
      informer_contact = cardsModel.informerContact;
      informer_contact_hidden = MyPhone().replacePhoneNo(informer_contact);

      //print('>>> pref_membertype = $pref_membertype');
      //print('>>> pref_name = $pref_name');

      print('rec_id >> $rec_id');
      print('car_id ==>> ${cardsModel.refCarId}');
      //print('car_identify ==>> ${cardsModel.carIdentify}');
      print('car_identify ==>> $car_identify');

      //print('informertoken >> $informertoken');
      //print('deviceToken >> $deviceToken');
    });

    //print('Device Token : $deviceToken');
    //print('Owner Token : $ownertoken');
  }

  Future<Null> sendNotification(String mytoken) async {
    String title = 'การแจ้งเตือน';
    String body = '';
    String dns = MyConstant().domain_url;
    String url = '';

    (cardsModel != null)
        ? body =
            'รถยนต์ทะเบียน [$car_identify  $car_province] รับทราบข้อมูลแล้ว'
        : body = 'รับทราบข้อมูลจอดกีดขวางแล้ว';
    url =
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
          title: Text(
            'รถจอดกีดขวาง',
            style: TextStyle(
              //color: Colors.black,
              fontSize: 25.0,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => routeToShow(),
            ),
          ]),
      body: rec_id.isEmpty == true || rec_id == ''
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
              imageField(),
              MyStyle().mySizedbox(),
              carField(),
              provinceField(),
              (cardsModel.ownerName != null)
                  ? ownernameField()
                  : MyStyle().mylittleSizedbox(),
              (cardsModel.ownerContact != null)
                  ? ownercontactField()
                  : MyStyle().mylittleSizedbox(),
              ((deviceToken == ownertoken) ||
                      deviceToken == informertoken ||
                      pref_membertype == 'admin')
                  ? showRadio()
                  : MyStyle().mySizedbox(),
              stationField(),
              issueDatetimeField(),
              nameField(),
              contactField(),
              MyStyle().mySizedbox(),
              ((pref_membertype != null) && (pref_membertype == 'admin'))
                  ? showCheckBox()
                  : MyStyle().mySizedbox(),
              ((deviceToken == ownertoken) ||
                      deviceToken == informertoken ||
                      pref_membertype == 'admin')
                  ? showEditButton()
                  : MyStyle().mySizedbox(),
            ],
          ),
        ),
      );

  Container showCheckBox() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: 300.0,
      child: CheckboxListTile(
        title: MyStyle().showTitleH3Green('ประกาศเสียงตามสายแล้ว'),
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = newValue;
          });
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

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

  Widget ownernameField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                style: TextStyle(color: Colors.green.shade800),
                initialValue:
                    (cardsModel.ownerName != '') ? cardsModel.ownerName : '',
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อเจ้าของรถ',
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

  Widget ownercontactField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 260.0,
              child: TextFormField(
                style: TextStyle(color: Colors.green.shade800),
                initialValue: owner_contact_hidden,
                enabled: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'กรุณาติดต่อ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
            Container(
              width: 60.0,
              child: showCallbutton1(),
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

  Widget carField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                style: TextStyle(color: Colors.green.shade800),
                initialValue: car_identify,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.directions_car,
                    color: Colors.black,
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
                style: TextStyle(color: Colors.green.shade800),
                initialValue: car_province,
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.local_activity,
                    color: Colors.black,
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

  Widget issueDatetimeField() => Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.0,
              child: TextFormField(
                initialValue: changeDateFormat(cardsModel.issueDatetime),
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.time_to_leave,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'แจ้งเหตุเมื่อ',
                  //helperText: 'กรุณาระบุจังหวัด',
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

  String changeDateFormat(String myDatetime) {
    return DateUtil().formattedDateTime(DateTime.parse(myDatetime));
  }

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
                  labelText: 'ผู้แจ้งเหตุ',
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
                initialValue: informer_contact_hidden,
                enabled: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ติดต่อผู้แจ้งเหตุ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              ),
            ),
            Container(
              width: 60.0,
              child: showCallbutton2(),
            ),
          ],
        ),
      );

  Row imageField() {
    String car_picture = cardsModel.refCarPicture;
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
              Text('แก้ไขแล้ว', style: TextStyle(color: MyStyle().darkColor))
            ],
          ),
        ),
      ],
    );
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
            if ((rec_id == null || rec_id.isEmpty)) {
              warningDialog(context, 'กรุณากรอกข้อมูลผู้แจ้งให้ครบถ้วน.');
            } else {
              if (fixed_status == true) {
                EditObstacleInfo();
              }

              if (checkedValue == true) {
                checkDup_Announce();
              } else {
                CancelAnnounceInfo();
              }
            }
          },
          icon: Icon(Icons.save), textColor: Colors.white,
          label: Text(
            'บันทึกข้อมูล',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  Future<Null> EditObstacleInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/fixedObstacle.php?isAdd=true&car_identify=$car_identify&car_province=$car_province&station_id=$pref_Station_ID';

    print(' url >>> $url');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
        print('Save Fixed Obstacle completed');
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);

        print('device Token ==> $deviceToken');
        print('owner token ==> $ownertoken');
        print('informer token ==> $informertoken');

        (deviceToken == ownertoken)
            ? sendNotification(informertoken)
            : sendNotification(ownertoken);

        //routeToShowList();
      } else {
        warningDialog(
            context, 'บันทึกข้อมูลผิดพลาด, กรุณาทำรายการใหม่อีกครั้ง');
      }
    } catch (e) {}
  }

  Future<Null> checkDup_Announce() async {
    String dns = MyConstant().domain_url;

    String url =
        '$dns/SMILEPARK/getAnnounce.php?isAdd=true&obstacle_id=${cardsModel.id}';

    //print('url >>> $url ');

    try {
      Response response = await Dio().get(url);
      //print('res = $response');
      if (response.toString() == 'null') {
        EditAnnounceInfo();
        //Navigator.pop(context);
      }
    } catch (e) {}
  }

  Future<Null> EditAnnounceInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/addAnnounce.php?isAdd=true&obstacle_id=${cardsModel.id}';

    //print('url >>> $url ');

    try {
      //print('>Edit obstacle. > url > $url');

      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
        print('Save announcement for Obstacle completed');
        //normalDialog(context, 'Save completed');
        //Navigator.pop(context);

        //print('device Token ==> $deviceToken');
        //print('owner token ==> $ownertoken');
        print('informer token ==> $informertoken');

        if (informertoken.isEmpty || informertoken == '') {
          sendNotification(informertoken);
        }

        routeToShowList();
      }
    } catch (e) {}
  }

  Future<Null> CancelAnnounceInfo() async {
    String dns = MyConstant().domain_url;
    String url =
        '$dns/SMILEPARK/cancelAnnounce.php?isAdd=true&obstacle_id=${cardsModel.id}';

    //print('url >>> $url ');

    try {
      //print('>cancel Announce. > url > $url');

      Response response = await Dio().get(url);
      //print('res = $response');

      if (response.toString() == 'true') {
        print('Cancel announcement for Obstacle completed');
        //normalDialog(context, 'Update completed');
        //Navigator.pop(context);

        routeToShowList();
      }
    } catch (e) {}
  }

  Future<Null> getAnnounce() async {
    String dns = MyConstant().domain_url;

    String url =
        '$dns/SMILEPARK/getAnnounce.php?isAdd=true&obstacle_id=${cardsModel.id}';

    //print('url >>> $url ');

    try {
      Response response = await Dio().get(url);

      //print('res = ${response.toString()}');

      if (response.toString() != 'null') {
        setState(() {
          checkedValue = true;
        });

        //print('checkedValue = $checkedValue');
        //Navigator.pop(context);
      }
    } catch (e) {}
  }

  Widget showCall() {
    return RaisedButton.icon(
      color: Colors.blue[200],
      onPressed: () => setState(() {
        _launched = _makePhoneCall('tel:${cardsModel.informerContact}');
      }),
      icon: Icon(Icons.phone_in_talk),
      label: Text(
        '',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget showCallbutton1() {
    return SizedBox.fromSize(
      size: Size(56, 56), // button width and height
      child: ClipOval(
        child: Material(
          color: Colors.greenAccent.shade400, // button color
          child: InkWell(
            splashColor: Colors.white, // splash color
            onTap: () => setState(() {
              _launched = _makePhoneCall('tel:${cardsModel.ownerContact}');
            }), // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call), // icon
                Text("Call"), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showCallbutton2() {
    return SizedBox.fromSize(
      size: Size(56, 56), // button width and height
      child: ClipOval(
        child: Material(
          color: Colors.orange, // button color
          child: InkWell(
            splashColor: Colors.green, // splash color
            onTap: () => setState(() {
              _launched = _makePhoneCall('tel:${cardsModel.informerContact}');
            }), // button pressed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.call), // icon
                Text("Call"), // text
              ],
            ),
          ),
        ),
      ),
    );
  }

  void routeToShowList() {
    //print('Button click search');
    Widget myWidget = ShowList();

    MaterialPageRoute routepage = MaterialPageRoute(
      builder: (context) => myWidget,
    );

    Navigator.pushAndRemoveUntil(context, routepage, (route) => false);
  }
}
