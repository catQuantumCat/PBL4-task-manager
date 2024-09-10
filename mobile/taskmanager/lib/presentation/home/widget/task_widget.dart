// ignore_for_file: public_member_api_docsort_constructors_first
import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/presentation/home/widget/detail_task_widget.dart';

class TaskWidget extends StatefulWidget {
  final TaskModel task;

  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool _taskStatus;

  @override
  void initState() {
    super.initState();
    _taskStatus = widget.task.status;
  }

  void _showTaskSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => DetailTaskWidget(
              task: widget.task,
            ));
  }

  void changeTaskStatus(value) {
    widget.task.editStatus(value);
    setState(() {
      _taskStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showTaskSheet(),
      leading: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            shape: const CircleBorder(),
            visualDensity: VisualDensity.compact,
            value: _taskStatus,
            onChanged: (newVal) {
              changeTaskStatus(newVal);
            }),
      ),
      title: Text(widget.task.name),
      subtitle: Text(widget.task.deadTime.toString()),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
