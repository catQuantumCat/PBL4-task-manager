import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';

class CommonBottomSheet {
  static Future<dynamic> showBottomSheet(
      {required BuildContext context,
      double? heightRatio,
      bool isDismissible = true,
      required Widget Function(BuildContext) builder}) async {
    dynamic v = await showModalBottomSheet<dynamic>(
      constraints: BoxConstraints(
        maxHeight: heightRatio != null
            ? MediaQuery.of(context).size.height * heightRatio
            : double.infinity,
      ),
      isDismissible: isDismissible,
      isScrollControlled: true,
      enableDrag: isDismissible,
      context: context,
      builder: builder,
    );
    return v;
  }
}
