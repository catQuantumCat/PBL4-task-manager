// ignore_for_file: public_member_api_docsort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/presentation/home/bloc/list/list_home.bloc.dart';
import 'package:taskmanager/presentation/home/view/modal/detail_task.modal.dart';

class TaskTileWidget extends StatefulWidget {
  final TaskModel task;

  const TaskTileWidget({
    super.key,
    required this.task,
  });

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  late bool _taskStatus;

  @override
  void initState() {
    super.initState();
    _taskStatus = widget.task.status;
  }

  void _showTaskSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) => DetailTaskModal(
        task: widget.task,
      ),
    ).whenComplete(() {
      if (!mounted) return;
      context.read<ListHomeBloc>().add(FetchTaskList());
    });
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
      onTap: _showTaskSheet,
      leading: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            shape: const CircleBorder(),
            visualDensity: VisualDensity.compact,
            value: _taskStatus,
            onChanged: (newVal) {
              context.read<ListHomeBloc>().add(
                  ListHomeCheckTask(taskId: widget.task.id, taskStatus: newVal!));
              changeTaskStatus(newVal);
            }),
      ),
      title: Text(widget.task.name),
      subtitle:
          Text(DateFormat("dd/MM/yyyy | HH:mm").format(widget.task.deadTime)),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
