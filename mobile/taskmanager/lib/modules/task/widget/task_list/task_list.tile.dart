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

  const TaskListTile({
    super.key,
    required this.task,
  });

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  late bool _taskStatus;
  late final TaskListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _taskStatus = widget.task.status;
    _bloc = context.read<TaskListBloc>();
  }

  Future<void> _showDetailTaskSheet(BuildContext context) async {
    await CommonBottomSheet.show(
      context: context,
      child: TaskDetailPage(
        task: widget.task,
        taskListBloc: _bloc,
      ),
    );
  }

  void changeTaskStatus(value) {
    _bloc.add(TapCheckboxOneTask(taskId: widget.task.id, taskStatus: value!));

    widget.task.editStatus(value);
    setState(() {
      _taskStatus = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      tileColor: context.palette.scaffoldBackground,
      onTap: () {
        _bloc.add(TapOneTask(task: widget.task));
        _showDetailTaskSheet(context);
      },
      leading: ReactiveCheckbox(
        taskPriority: widget.task.priority,
        taskStatus: _taskStatus,
        onChanged: (p0) => changeTaskStatus(p0),
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
