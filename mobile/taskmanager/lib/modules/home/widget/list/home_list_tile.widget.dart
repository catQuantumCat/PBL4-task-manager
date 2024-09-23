// ignore_for_file: public_member_api_docsort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/modules/home/bloc/detail/detail_home.bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/list_home.bloc.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail.view.dart';

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

  void _showTaskSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) =>
                DetailHomeBloc()..add(DetailHomeOpen(task: widget.task)),
            child: const HomeDetailView(),
          );
        }).whenComplete(() {
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
              context.read<ListHomeBloc>().add(ListHomeCheckTask(
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

class DetailTaskModal {
  const DetailTaskModal();
}
