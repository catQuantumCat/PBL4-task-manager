import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/theme/color_enum.dart';

import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';

import 'package:taskmanager/modules/task/widget/task_priority.sheet.dart';

class TaskCreateForm extends StatefulWidget {
  const TaskCreateForm({
    super.key,
    required this.taskFieldKey,
    required this.descriptionFieldKey,
    required this.taskFieldController,
    required this.descriptionFieldController,
  });

  final Key taskFieldKey;
  final Key descriptionFieldKey;
  final TextEditingController taskFieldController;
  final TextEditingController descriptionFieldController;

  @override
  State<TaskCreateForm> createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends State<TaskCreateForm> {
  bool _formFilled = false;

  @override
  void initState() {
    widget.taskFieldController.addListener(() {
      setState(() {
        _formFilled = widget.taskFieldController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  void _showDateHandle(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        initialDate: context.read<TaskCreateBloc>().state.date,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2032));

    if (!context.mounted) return;
    context.read<TaskCreateBloc>().add(NewHomeDateTapped(date: selectedDate));
  }

  void _showTimeHandle(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(context.read<TaskCreateBloc>().state.date));
    if (!context.mounted) {
      return;
    }
    context.read<TaskCreateBloc>().add(NewHomeTimeTapped(time: time));
  }

  void _showPriorityHandle(BuildContext context, int priorityIndex) {
    showCupertinoModalPopup(
        context: context,
        builder: (sheetContext) => TaskPrioritySheet(
              onPriorityTap: (newPriority) => context
                  .read<TaskCreateBloc>()
                  .add(NewHomePriorityTapped(priority: newPriority)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskCreateBloc>();
    return Container(
      decoration: BoxDecoration(
        color: context.palette.scaffoldBackground,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            TextFormField(
              key: widget.taskFieldKey,
              autofocus: true,
              controller: widget.taskFieldController,
              style: context.appTextStyles.heading2,
              maxLines: null,
              minLines: 1,
              decoration: InputDecoration.collapsed(
                hintText: "Task name",
                hintStyle: context.appTextStyles.hintTextField.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: context.appTextStyles.heading2.fontSize,
                ),
              ),
            ),
            const SizedBox(height: 2),
            TextFormField(
              key: widget.descriptionFieldKey,
              controller: widget.descriptionFieldController,
              style: context.appTextStyles.body1,
              maxLines: null,
              minLines: 2,
              decoration: InputDecoration.collapsed(
                hintText: "Description",
                hintStyle: context.appTextStyles.hintTextField,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  OutlinedButton.icon(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStatePropertyAll(context.palette.normalText),
                    ),
                    onPressed: () => _showDateHandle(context),
                    label: Text(bloc.state.dateLabel),
                    icon: const Icon(Icons.date_range),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton.icon(
                    style: ButtonStyle(
                      foregroundColor:
                          WidgetStatePropertyAll(context.palette.normalText),
                    ),
                    label: Text(bloc.state.timeLabel),
                    icon: const Icon(Icons.access_time_outlined),
                    onPressed: () => _showTimeHandle(context),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  OutlinedButton.icon(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(context.palette
                          .getPriorityPrimary(bloc.state.priority)),
                    ),
                    label: Text(PriorityEnum.getLabel(bloc.state.priority)),
                    icon: const Icon(Icons.flag),
                    onPressed: () =>
                        _showPriorityHandle(context, bloc.state.priority),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
            const SizedBox(height: 24),
            IconButton.filled(
                style: const ButtonStyle().copyWith(
                    backgroundColor: WidgetStatePropertyAll(
                      _formFilled
                          ? context.palette.primaryColor
                          : context.palette.disabledButtonLabel,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      context.palette.onPrimary,
                    )),
                onPressed: _formFilled == true
                    ? () {
                        bloc.add(NewHomeSubmitTapped(
                            missionName: widget.taskFieldController.text,
                            description:
                                widget.descriptionFieldController.text));
                      }
                    : null,
                icon: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
