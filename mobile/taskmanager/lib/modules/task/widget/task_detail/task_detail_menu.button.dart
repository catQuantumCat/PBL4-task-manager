import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';

class TaskDetailMenuButton extends StatelessWidget {
  const TaskDetailMenuButton({super.key});

  void _onDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Delete task?"),
            content: const Text("Action cannot be undone."),
            actions: [
              TextButton(
                  onPressed: () {
                    context.read<TaskDetailBloc>().add(HomeDetailTaskDelete());
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("No")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskDetailBloc>();
    return PopupMenuButton(
        constraints: const BoxConstraints.tightFor(width: 220),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: context.palette.buttonBackground),
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.more_horiz_outlined,
            color: context.palette.buttonForeground,
          ),
        ),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              enabled: false,
              height: 40,
              child: bloc.state.task?.createTime != null
                  ? Text(
                      "Added on ${DateFormat("MMM d HH:mm").format(bloc.state.task!.createTime)}",
                      style: context.appTextStyles.metadata1,
                    )
                  : null,
            ),
            const PopupMenuDivider(
              height: 0,
            ),
            PopupMenuItem(
              onTap: () => bloc.add(HomeDetailTaskEdit(focusOnTitle: true)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit task",
                      style: context.appTextStyles.buttonLabel,
                    ),
                    const Icon(Icons.mode_edit_outlined)
                  ]),
            ),
            PopupMenuItem(
                onTap: () => _onDelete(context),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delete task",
                        style: context.appTextStyles.errorButtonLabel,
                      ),
                      Icon(
                        Icons.delete_outline,
                        color: context.palette.errorButtonLabel,
                      )
                    ])),
          ];
        });
  }
}
