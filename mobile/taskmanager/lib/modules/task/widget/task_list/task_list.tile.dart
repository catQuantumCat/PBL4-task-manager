import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';

import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/datetime_extension.dart';

import 'package:taskmanager/data/model/task_model.dart';

import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_detail/task_detail.view.dart';
import 'package:taskmanager/modules/task/widget/task_reactive.checkbox.dart';

class TaskListTile extends StatefulWidget {
  final TaskModel task;

  final Future<void> Function(TaskModel)? taskCompleteHandler;

  const TaskListTile({super.key, required this.task, this.taskCompleteHandler});

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
    await CommonBottomSheet.show(
      context: context,
      child: BlocProvider.value(
        value: BlocProvider.of<TaskListBloc>(context),
        child: TaskDetailPage(
          task: widget.task,
        ),
      ),
    );
  }

  void changeTaskStatus(value, TaskListBloc bloc) async {
    bloc.add(TapCheckboxOneTask(taskId: widget.task.id, taskStatus: value!));
    widget.task.editStatus(value);
    setState(() {
      _taskStatus = value;
    });

    if (widget.taskCompleteHandler != null) {
      await widget.taskCompleteHandler!(widget.task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<TaskListBloc>();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.top,
      tileColor: context.palette.scaffoldBackground,
      onTap: () {
        context.read<TaskListBloc>().add(TapOneTask(task: widget.task));
        _showDetailTaskSheet(context);
      },
      leading: ReactiveCheckbox(
        taskPriority: widget.task.priority,
        taskStatus: _taskStatus,
        onChanged: (p0) async => changeTaskStatus(p0, _bloc),
      ),
      title: Text(
        widget.task.name,
        style: widget.task.status == false
            ? context.appTextStyles.body1
            : context.appTextStyles.strikedBody1,
      ),
      subtitle: Text(
        widget.task.deadTime.relativeToToday(),
      ),
    );
  }
}
