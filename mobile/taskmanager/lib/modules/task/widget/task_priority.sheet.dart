import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/theme/color_enum.dart';

class TaskPrioritySheet extends StatelessWidget {
  const TaskPrioritySheet(
      {super.key, required void Function(int) onPriorityTap})
      : _onPriorityTap = onPriorityTap;

  final void Function(int) _onPriorityTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      actions: [
        for (var val in PriorityEnum.values)
          CupertinoActionSheetAction(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  val.label,
                  style: context.appTextStyles.buttonLabel.copyWith(
                      color: context.palette.getPriorityPrimary(val.key)),
                ),
              ],
            ),
            onPressed: () {
              _onPriorityTap(val.key);
              Navigator.pop(context);
            },
          ),
      ],
    );
  }
}
