import 'package:flutter/material.dart';

class NewTaskButtonWidget extends StatelessWidget {
  const NewTaskButtonWidget({
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
        side: WidgetStateProperty.all(BorderSide(color: color, width: 1)),
        foregroundColor: WidgetStatePropertyAll(color),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onPressed: handle,
      label: Text(label),
      icon: icon,
    );
  }
}
