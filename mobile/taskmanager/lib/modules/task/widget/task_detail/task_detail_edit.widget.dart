import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';

class TaskDetailEdit extends StatefulWidget {
  const TaskDetailEdit({super.key});

  @override
  State<TaskDetailEdit> createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  final TextEditingController nameFieldController = TextEditingController();
  final TextEditingController descriptionFieldController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    nameFieldController.text = context.read<TaskDetailBloc>().state.task!.name;
    descriptionFieldController.text =
        context.read<TaskDetailBloc>().state.task!.description ?? "";
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
            const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Icon(Icons.check_box_outline_blank_rounded)),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                autofocus: true,
                controller: nameFieldController,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                controller: descriptionFieldController,
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

    return CommonBottomSheet.inputSheet(
      onSave: _saveTapped,
      onCancel: _cancelTapped,
      body: body,
    );
  }
}
