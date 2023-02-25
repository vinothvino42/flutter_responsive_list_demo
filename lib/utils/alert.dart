import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Alert {
  Alert._();

  static void showToast(String text,
      {bool isLong = true, ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: gravity,
    );
  }
}
