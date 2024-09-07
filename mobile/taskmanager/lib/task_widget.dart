// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String title;

  const TaskWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false,
      onChanged: (newValue) {},
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(title),
      subtitle: const Text("Overdue"),
      controlAffinity: ListTileControlAffinity.leading,
      checkboxShape: const CircleBorder(),
      secondary: const Icon(Icons.chevron_right),
    );
  }
}
