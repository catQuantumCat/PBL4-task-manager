import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonPillOutlinedButton extends StatelessWidget {
  const CommonPillOutlinedButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.handle,
  });

  final Icon icon;
  final String label;
  final Color color;
  final Function()? handle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(context.palette.primaryColor),
      ),
      onPressed: handle,
      label: Text(label),
      icon: icon,
    );
  }
}
