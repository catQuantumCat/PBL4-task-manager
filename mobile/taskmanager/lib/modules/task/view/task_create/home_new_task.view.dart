import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/widget/common_pill_outlined_button.widget.dart';
import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';

class TaskCreateView extends StatefulWidget {
  const TaskCreateView({super.key});

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  final taskFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  void _showDateHandle(TaskCreateStatus state) async {
    final DateTime? selectedDate = await showDatePicker(
        initialDate: context.read<TaskCreateBloc>().state.date,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2032));

    if (!mounted) return;
    context.read<TaskCreateBloc>().add(NewHomeDateTapped(date: selectedDate));
  }

  void _showTimeHandle(TaskCreateStatus state) async {
    final TimeOfDay? time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(state.date));
    if (!mounted) {
      return;
    }
    context.read<TaskCreateBloc>().add(NewHomeTimeTapped(time: time));
  }

  @override
  dispose() {
    taskFieldController.dispose();
    descriptionFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCreateBloc, TaskCreateStatus>(
        listener: (context, state) async {
      if (state.status case NewHomeStatus.success) {
        Navigator.pop(context, "success");
        return;
      }
    }, builder: (context, state) {
      return DraggableScrollableSheet(
        expand: false,
        shouldCloseOnMinExtent: true,
        maxChildSize: 0.95,
        minChildSize: MediaQuery.of(context).viewInsets.bottom /
                MediaQuery.sizeOf(context).height +
            0.3,
        initialChildSize: MediaQuery.of(context).viewInsets.bottom /
                MediaQuery.sizeOf(context).height +
            0.3,
        builder: (context, scrollController) {
          switch (state.status) {
            case NewHomeStatus.initial:
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  const SizedBox(height: 24),
                  TextFormField(
                    autofocus: true,
                    controller: taskFieldController,
                    style: const TextStyle(fontSize: 24),
                    maxLines: null,
                    minLines: 1,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Task name",
                        hintStyle: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: descriptionFieldController,
                    style: const TextStyle(fontSize: 16),
                    maxLines: null,
                    minLines: 2,
                    decoration: const InputDecoration.collapsed(
                        hintText: "Description",
                        hintStyle: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        BlocBuilder<TaskCreateBloc, TaskCreateStatus>(
                          builder: (context, state) {
                            return CommonPillOutlinedButton(
                              label: state.dateLabel,
                              icon: const Icon(Icons.date_range),
                              color: Colors.deepPurple,
                              handle: () => _showDateHandle(state),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        BlocBuilder<TaskCreateBloc, TaskCreateStatus>(
                          builder: (context, state) {
                            return CommonPillOutlinedButton(
                              label: state.timeLabel,
                              icon: const Icon(Icons.access_time_outlined),
                              color: Colors.deepPurple,
                              handle: () => _showTimeHandle(state),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  IconButton.filled(
                      onPressed: () {
                        context.read<TaskCreateBloc>().add(NewHomeSubmitTapped(
                            missionName: taskFieldController.text,
                            description: descriptionFieldController.text));
                      },
                      icon: const Icon(Icons.add))
                ],
              );
            case NewHomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case NewHomeStatus.success:
              return const Center(child: Text(''));
            case NewHomeStatus.failure:
              return const Center(child: Text('Something went wrong!'));
            default:
              return const Center(child: Text('NO WIDGET FOUND!'));
          }
        },
      );
    });
  }
}
