import 'package:flutter/material.dart';
import 'package:taskmanager/data/task_model.dart';
import 'package:taskmanager/modules/home/widget/list/home_list_tile.widget.dart';

class HomeListWidget extends StatelessWidget {
  final List<TaskModel> taskList;
  final void Function(int)? onDismissed;

  const HomeListWidget({
    super.key,
    required this.taskList,
    this.onDismissed,
  });

  Future<bool?> _deleteConfirm(BuildContext context) async {
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
        if (onDismissed == null) {
          return HomeListTileWidget(
            task: taskList[index],
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
            return _deleteConfirm(context);
          },
          onDismissed: (_) {
            onDismissed!(taskList[index].id);
          },
          child: HomeListTileWidget(
            task: taskList[index],
          ),
        );
      },
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
    );
  }
}
