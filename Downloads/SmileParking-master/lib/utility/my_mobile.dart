import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:smileparking/model/mobilemodel.dart';

class MyMobile {
  
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<MobileModel> initPlatformState() async {
    var jsonData;
    var parsedJson;
    MobileModel mobileModel;

    String platformImei;
    String idunique;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);
      idunique = await ImeiPlugin.getId();

      jsonData = '{ "Imei" : "$platformImei", "uniqueId" : "$idunique"  }';
      parsedJson = json.decode(jsonData);
      mobileModel = MobileModel.fromJson(parsedJson);
    } on PlatformException {
      platformImei = 'Failed to get platform version.';
    }

    return mobileModel;
  }

  MyMobile();
}
