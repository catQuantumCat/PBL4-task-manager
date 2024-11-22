import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/common/context_extension.dart';

abstract class CommonToast {
  static showStatusToast(BuildContext context, String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.TOP,
        textColor: context.palette.normalText,
        backgroundColor: context.palette.scaffoldBackground);
  }
}
