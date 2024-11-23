import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/data/model/task_model.dart';

import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_list/task_list.tile.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage(
      {super.key, required this.taskList, this.allowDissiable = true});

  final List<TaskModel> taskList;
  final bool allowDissiable;

  @override
  Widget build(BuildContext context) {
    return TaskListView(taskList: taskList);
  }
}

class TaskListView extends StatelessWidget {
  final List<TaskModel> taskList;

  final bool allowDissiable;

  const TaskListView(
      {super.key, required this.taskList, this.allowDissiable = true});

  Future<bool?> _deleteConfirm(BuildContext context, int taskId) async {
    return await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Delete task?"),
            content: const Text("Action cannot be undone"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    context
                        .read<TaskListBloc>()
                        .add(RemoveOneTask(taskToRemoveIndex: taskId));

                    Navigator.pop(dialogContext, true);
                  },
                  child: const Text("Delete"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      itemCount: taskList.length,
      itemBuilder: (_, index) {
        if (allowDissiable == false) {
          return Column(
            children: [
              TaskListTile(
                key: UniqueKey(),
                task: taskList[index],
              ),
              if (index != taskList.length - 1)
                const Divider(
                  height: 0.2,
                  thickness: 0.2,
                  indent: 20,
                )
            ],
          );
        }
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.redAccent,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            return _deleteConfirm(context, taskList[index].id);
          },
          onDismissed: (_) => (),
          child: Column(
            children: [
              TaskListTile(
                task: taskList[index],
              ),
              if (index != taskList.length - 1)
                const Divider(
                  height: 0.2,
                  thickness: 0.2,
                  indent: 20,
                )
            ],
          ),
        );
      },
      padding: const EdgeInsets.symmetric(
        vertical: 0,
      ),
    );
  }
}
