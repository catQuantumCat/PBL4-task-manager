import 'package:flutter/material.dart';
import 'package:taskmanager/common/bottomSheet/sheet.constants.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';

class CommonBottomSheet {
  static Future<dynamic> show({
    required BuildContext context,
    double heightRatio = SheetConstants.maxHeight,
    bool isDismissible = true,
    required Widget child,
  })
  // required Widget Function(BuildContext) builder}) async {
  async {
    dynamic v = await showModalBottomSheet<dynamic>(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * heightRatio),
        isDismissible: isDismissible,
        isScrollControlled: true,
        enableDrag: isDismissible,
        context: context,
        builder: (_) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                UIConstant.cornerRadiusMedium,
              ),
            ),
            child: child),
        sheetAnimationStyle: AnimationStyle(
            curve: Curves.easeIn, duration: const Duration(milliseconds: 300)));
    return v;
  }
}
