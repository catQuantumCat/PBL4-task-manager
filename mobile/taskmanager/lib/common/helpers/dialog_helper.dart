import 'package:flutter/material.dart';

import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/main.dart';

abstract class DialogHelper {
  static Future<void> showError(
    BuildContext context, {
    String title = "Error",
    String content = "Something went wrong",
    void Function()? onPressed
  }) async {
    return await _showDialog(
      context,
      dialog: AlertDialog(
        title: Text(title),
        titleTextStyle: navigatorContext.appTextStyles.heading2,
        content: Text(content),
        contentTextStyle: navigatorContext.appTextStyles.body1,
        actions: [
          TextButton(
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            child: const Text('Try again'),
          )
        ],
      ),
    );
  }

  static Future<void> _showDialog(BuildContext context,
      {required Widget dialog}) async {
    showDialog(context: context, builder: (dialogContext) => dialog);
  }
}
