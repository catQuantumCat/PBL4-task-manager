import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_detail/task_detail.view.dart';

class TaskListTile extends StatefulWidget {
  final TaskModel task;

  const TaskListTile({
    super.key,
    required this.task,
  });

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  late bool _taskStatus;

  @override
  void initState() {
    super.initState();
    _taskStatus = widget.task.status;
  }

  Future<void> _showDetailTaskSheet(BuildContext context) async {
    CommonBottomSheet.showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) {
            return TaskDetailBloc(taskRepository: getIt<TaskRepository>())
              ..add(HomeDetailTaskOpen(task: widget.task));
          },
          child: const TaskDetailView(),
        );
      },
    );
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
      onTap: () {
        context.read<TaskListBloc>().add(TapOneTask(task: widget.task));
        _showDetailTaskSheet(context);
      },
      leading: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            shape: const CircleBorder(),
            visualDensity: VisualDensity.compact,
            value: _taskStatus,
            onChanged: (newVal) {
              context.read<TaskListBloc>().add(ListHomeCheckTask(
                  taskId: widget.task.id, taskStatus: newVal!));
              changeTaskStatus(newVal);
            }),
      ),
      title: Text(widget.task.name),
      subtitle: Text(widget.task.deadTime.relativeToToday()),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
