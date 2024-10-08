import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/modules/home/bloc/detail/home_detail_task.bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_task.view.dart';

class HomeListTileWidget extends StatefulWidget {
  final TaskModel task;

  const HomeListTileWidget({
    super.key,
    required this.task,
  });

  @override
  State<HomeListTileWidget> createState() => _HomeListTileWidgetState();
}

class _HomeListTileWidgetState extends State<HomeListTileWidget> {
  late bool _taskStatus;

  @override
  void initState() {
    super.initState();
    _taskStatus = widget.task.status;
  }

  Future<void> _showDetailTaskSheet() async {
    final homeDetailTaskBloc = HomeDetailTaskBloc()
      ..add(HomeDetailTaskOpen(task: widget.task));

    await showModalBottomSheet<bool>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: homeDetailTaskBloc,
          child: const HomeDetailTaskView(),
        );
      },
    );

    if (mounted && homeDetailTaskBloc.state.isEdited == true) {
      context.read<HomeListBloc>().add(FetchTaskList());
    }
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
      contentPadding: const EdgeInsets.all(0),
      onTap: _showDetailTaskSheet,
      leading: Transform.scale(
        scale: 1.5,
        child: Checkbox(
            shape: const CircleBorder(),
            visualDensity: VisualDensity.compact,
            value: _taskStatus,
            onChanged: (newVal) {
              context.read<HomeListBloc>().add(ListHomeCheckTask(
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
