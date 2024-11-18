import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';

class TaskDetailEdit extends StatefulWidget {
  const TaskDetailEdit({super.key, required this.focusOnTitle});

  final bool focusOnTitle;

  @override
  State<TaskDetailEdit> createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController descriptionFieldController =
      TextEditingController();

  final FocusNode nameFieldFocusNode = FocusNode();
  final FocusNode descriptionFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    nameFieldController.text = context.read<TaskDetailBloc>().state.task!.name;
    descriptionFieldController.text =
        context.read<TaskDetailBloc>().state.task!.description ?? "";

    widget.focusOnTitle == true
        ? nameFieldFocusNode.requestFocus()
        : descriptionFieldFocusNode.requestFocus();
  }

  void _cancelTapped() {
    context.read<TaskDetailBloc>().add(HomeDetailTaskCancelEdit());
  }

  void _saveTapped() {
    context.read<TaskDetailBloc>().add(HomeDetailTaskSaveEdit(
        taskName: nameFieldController.text,
        taskDescription: descriptionFieldController.text));
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SizedBox(
                  height: 28,
                  width: 24,
                  child: Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: false,
                      onChanged: (_) {},
                    ),
                  ),
                )),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                style: context.appTextStyles.subHeading1,
                controller: nameFieldController,
                focusNode: nameFieldFocusNode,
                maxLines: null,
                minLines: 1,
                decoration: const InputDecoration.collapsed(
                  hintText: "Enter your task",
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.notes),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                style: context.appTextStyles.body1,
                controller: descriptionFieldController,
                focusNode: descriptionFieldFocusNode,
                maxLines: null,
                minLines: 1,
                decoration:
                    const InputDecoration.collapsed(hintText: "Description"),
              ),
            ),
          ],
        )
      ],
    );

    return CustomSheet(
      header: "Edit Task",
      enableControl: true,
      onSave: _saveTapped,
      onCancel: _cancelTapped,
      body: body,
    );
  }
}
