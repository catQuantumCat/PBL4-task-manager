import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/data/model/task_model.dart';

import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_list/task_list.tile.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage(
      {super.key,
      required this.taskList,
      this.allowDissiable = true,
      this.showTilePadding = true,
      this.animatedOnCompletion = true});

  final List<TaskModel> taskList;
  final bool allowDissiable;
  final bool showTilePadding;
  final bool animatedOnCompletion;

  @override
  Widget build(BuildContext context) {
    return TaskListView(
      taskList: taskList,
      allowDissiable: allowDissiable,
      showTilePadding: showTilePadding,
      animatedOnCompletion: animatedOnCompletion,
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<TaskModel> taskList;
  final bool allowDissiable;
  final bool showTilePadding;
  final bool animatedOnCompletion;

  final _taskListKey = GlobalKey<AnimatedListState>();

  TaskListView(
      {super.key,
      required this.taskList,
      required this.allowDissiable,
      required this.showTilePadding,
      required this.animatedOnCompletion});

  //Animation when task is completed
  Future<void> _taskCompleteHanlder(TaskModel task) async {
    if (task.status == false || animatedOnCompletion == false) return;
    final index = taskList.indexWhere((rawTask) => task.id == rawTask.id);

    if (index == -1) return;

    taskList.removeAt(index);

    await Future.delayed(const Duration(milliseconds: 500));

    _taskListKey.currentState?.removeItem(
      index,
      (context, animation) => SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        ),
        child: TaskListTile(
          task: task,
        ),
      ),
    );
  }

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

  Widget _taskTileProvider(BuildContext context, int index) {
    if (allowDissiable == false) {
      return Column(
        children: [
          TaskListTile(
            key: UniqueKey(),
            task: taskList[index],
            taskCompleteHandler: _taskCompleteHanlder,
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
            taskCompleteHandler: _taskCompleteHanlder,
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
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _taskListKey,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      initialItemCount: taskList.length,
      itemBuilder: (_, index, animation) => Padding(
        padding: EdgeInsets.symmetric(horizontal: showTilePadding ? 16 : 0),
        child: _taskTileProvider(context, index),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 0,
      ),
    );
  }
}
