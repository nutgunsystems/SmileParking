import 'package:flutter/material.dart';

import 'my_style.dart';


Future<void> warningDialog(BuildContext context, String message) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(
              message,
              style: TextStyle(color: Colors.red[700], fontSize: 18.0),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'OK',
                      style: TextStyle(color: MyStyle().primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ));
}
