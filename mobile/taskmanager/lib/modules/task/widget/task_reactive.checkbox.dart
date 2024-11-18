import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class ReactiveCheckbox extends StatelessWidget {
  const ReactiveCheckbox(
      {super.key,
      double size = 1.4,
      required int taskPriority,
      required bool taskStatus,
      required void Function(bool?)? onChanged})
      : _size = size,
        _priority = taskPriority,
        _status = taskStatus,
        _onChanged = onChanged;

  final int _priority;
  final bool _status;
  final double _size;

  final void Function(bool?)? _onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Transform.scale(
      scale: _size,
      child: Checkbox(
          checkColor: Colors.white,
          fillColor: WidgetStateProperty.resolveWith<Color?>(
            (states) {
              if (_status) {
                return palette.getPriorityPrimary(_priority);
              } else {
                return palette.getPriorityLight(_priority);
              }
            },
          ),
          side: WidgetStateBorderSide.resolveWith((state) => BorderSide(
                width: 2,
                color: palette.getPriorityPrimary(_priority),
              )),
          value: _status,
          onChanged: _onChanged),
    );
  }
}
