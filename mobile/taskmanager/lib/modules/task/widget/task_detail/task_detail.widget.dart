import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';

import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/theme/color_enum.dart';

import 'package:taskmanager/common/timeofday_extension.dart';

import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_detail/task_detail_menu.button.dart';
import 'package:taskmanager/modules/task/widget/task_priority.sheet.dart';
import 'package:taskmanager/modules/task/widget/task_reactive.checkbox.dart';

class TaskDetailWidget extends StatelessWidget {
  const TaskDetailWidget({super.key});

  void _showDateHandle(TaskDetailState state, BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2032));

    if (!context.mounted) return;
    context
        .read<TaskDetailBloc>()
        .add(DetailPropertiesChange(date: selectedDate));
  }

  void _showTimeHandle(TaskDetailState state, BuildContext context) async {
    final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (!context.mounted) return;
    context
        .read<TaskDetailBloc>()
        .add(DetailPropertiesChange(time: selectedTime));
  }

  void _checkBoxHandle(
      TaskDetailState state, BuildContext context, bool? newStatus) async {
    context
        .read<TaskDetailBloc>()
        .add(HomeDetailTaskCompleteTask(status: newStatus));
  }

  void _openEditHandle(BuildContext context, {required bool focusOnTitle}) {
    context
        .read<TaskDetailBloc>()
        .add(HomeDetailTaskEdit(focusOnTitle: focusOnTitle));
  }

  void _showPrioritySelection(BuildContext context, int priorityIndex) {
    showCupertinoModalPopup(
        context: context,
        builder: (sheetContext) => TaskPrioritySheet(
              onPriorityTap: (newPriority) => context
                  .read<TaskDetailBloc>()
                  .add(DetailPropertiesChange(priority: newPriority)),
            ));
  }

  @override
  Widget build(BuildContext context) {
    {
      final state = context.read<TaskDetailBloc>().state;

      return CustomSheet(
          showCancelButton: false,
          body: SingleChildScrollView(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Task ID: ${state.task!.id}",
                    style: context.appTextStyles.metadata1,
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const TaskDetailMenuButton(),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                            backgroundColor: context.palette.buttonBackground,
                            foregroundColor: context.palette.buttonForeground),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 28,
                    width: 24,
                    child: ReactiveCheckbox(
                        size: 1.2,
                        taskPriority: state.task!.priority,
                        taskStatus: state.task!.status,
                        onChanged: (bool? value) =>
                            _checkBoxHandle(state, context, value)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _openEditHandle(context, focusOnTitle: true),
                      child: Text(
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        state.task!.name,
                        style: state.task!.status == false
                            ? context.appTextStyles.subHeading1
                            : context.appTextStyles.strikedSubHeading1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (state.task!.description != null &&
                  state.task!.description!.isEmpty == false)
                InkWell(
                  onTap: () => _openEditHandle(context, focusOnTitle: false),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              state.task!.description ?? "",
                              style: context.appTextStyles.body1,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                dense: true,
                onTap: () => _showDateHandle(state, context),
                horizontalTitleGap: 8,
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(Icons.calendar_month_sharp, size: 24),
                title: Text(
                  state.task!.deadTime.relativeToToday(),
                  style: context.appTextStyles.body1,
                ),
              ),
              const Divider(
                height: 20,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                dense: true,
                onTap: () => _showTimeHandle(state, context),
                horizontalTitleGap: 8,
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                leading: const Icon(Icons.access_time_filled, size: 24),
                title: Text(
                  TimeOfDay.fromDateTime(state.task!.deadTime).toLabel(),
                  style: context.appTextStyles.body1,
                ),
              ),
              const Divider(
                height: 20,
              ),
              ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                dense: true,
                onTap: () =>
                    _showPrioritySelection(context, state.task!.priority),
                horizontalTitleGap: 8,
                minVerticalPadding: 0,
                contentPadding: const EdgeInsets.all(0),
                leading: Icon(
                  Icons.flag,
                  color:
                      context.palette.getPriorityPrimary(state.task!.priority),
                ),
                title: Text(
                  PriorityEnum.getLabel(state.task!.priority),
                  style: context.appTextStyles.body1,
                ),
              ),
            ]),
          ));
    }
  }
}
