import 'package:flutter/material.dart';

import 'package:taskmanager/common/datetime_extension.dart';

import 'package:taskmanager/common/timeofday_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/detail/home_detail_task.bloc.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_edit.view.dart';

class HomeDetailTaskView extends StatelessWidget {
  const HomeDetailTaskView({super.key});

  void _showDateHandle(HomeDetailTaskState state, BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context, firstDate: DateTime.now(), lastDate: DateTime(2032));

    if (!context.mounted) return;
    context
        .read<HomeDetailTaskBloc>()
        .add(HomeDetailTaskChangeMetadata(date: selectedDate));
  }

  void _showTimeHandle(HomeDetailTaskState state, BuildContext context) async {
    final TimeOfDay? selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (!context.mounted) return;
    context
        .read<HomeDetailTaskBloc>()
        .add(HomeDetailTaskChangeMetadata(time: selectedTime));
  }

  void _checkBoxHandle(
      HomeDetailTaskState state, BuildContext context, bool? newStatus) async {
    context
        .read<HomeDetailTaskBloc>()
        .add(HomeDetailTaskChangeMetadata(status: newStatus));
  }

  void _openEditHandle(BuildContext context) {
    context.read<HomeDetailTaskBloc>().add(HomeDetailTaskEdit());
  }

  @override
  Widget build(BuildContext context) {
    {
      return BlocBuilder<HomeDetailTaskBloc, HomeDetailTaskState>(
        builder: (context, state) {
          switch (state.status) {
            case DetailHomeStatus.initial:
            case DetailHomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DetailHomeStatus.loaded:
              return DraggableScrollableSheet(
                shouldCloseOnMinExtent: true,
                expand: false,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                initialChildSize: 0.601,
                snap: true,
                snapSizes: const [0.601, 0.95],
                builder: (context, scrollController) => ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 6,
                          width: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(state.task!.createTime.relativeToToday()),
                        Wrap(
                          children: [
                            IconButton.filled(
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                              onPressed: () => _openEditHandle(context),
                              icon: Icon(
                                Icons.edit,
                                color: Colors.deepPurple[100],
                              ),
                            ),
                            IconButton.filled(
                              constraints: const BoxConstraints(),
                              padding: const EdgeInsets.all(4),
                              onPressed: () {
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  context
                                      .read<HomeDetailTaskBloc>()
                                      .add(HomeTaskDetailClose());
                                }
                              },
                              icon: Icon(
                                Icons.clear,
                                color: Colors.deepPurple[100],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28,
                          width: 24,
                          child: Checkbox(
                              value: state.task!.status,
                              onChanged: (bool? value) =>
                                  _checkBoxHandle(state, context, value)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () => _openEditHandle(context),
                          child: Text(state.task!.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      onTap: () => _showDateHandle(state, context),
                      horizontalTitleGap: 8,
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.calendar_month_sharp, size: 24),
                      title: Text(
                        state.task!.deadTime.relativeToToday(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Divider(),
                    const SizedBox(height: 4),
                    ListTile(
                      visualDensity:
                          const VisualDensity(horizontal: 0, vertical: -4),
                      dense: true,
                      onTap: () => _showTimeHandle(state, context),
                      horizontalTitleGap: 8,
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.all(0),
                      leading: const Icon(Icons.access_time_filled, size: 24),
                      title: Text(
                        TimeOfDay.fromDateTime(state.task!.deadTime).toLabel(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      maxLines: null,
                      minLines: 6,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                      ),
                      initialValue: state.task!.description,
                      readOnly: true,
                    )
                  ],
                ),
              );
            case DetailHomeStatus.editing:
              return const HomeDetailTaskEditView();
            case DetailHomeStatus.success:
            // TODO: Handle this case.
            case DetailHomeStatus.error:
            // TODO: Handle this case.
            default:
              return Container();
          }
        },
      );
    }
  }
}
