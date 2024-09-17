import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/new/new_home.bloc.dart';
import 'package:taskmanager/presentation/home/view/widget/new_task_button.widget.dart';

class NewTaskModal extends StatefulWidget {
  const NewTaskModal({super.key});

  @override
  State<NewTaskModal> createState() => _NewTaskModalState();
}

class _NewTaskModalState extends State<NewTaskModal> {
  final taskFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();

  void _showDateHandle(NewHomeState state) async {
    final DateTime? selectedDate = await showDatePicker(
        initialDate: context.read<NewHomeBloc>().state.date,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2032));

    if (!mounted) return;
    context.read<NewHomeBloc>().add(NewHomeDateTapped(date: selectedDate));
  }

  void _showTimeHandle(NewHomeState state) async {
    final TimeOfDay? time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(state.date));
    if (!mounted) {
      return;
    }
    context.read<NewHomeBloc>().add(NewHomeTimeTapped(time: time));
  }

  @override
  dispose() {
    taskFieldController.dispose();
    descriptionFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewHomeBloc, NewHomeState>(
      listener: (context, state) async {
        if (state.status case NewHomeStatus.success) {
          Navigator.pop(context, "success");
          return;
        }
        if (state.status == NewHomeStatus.success) {}
      },
      builder: (context, state) {
        if (state.status == NewHomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return DraggableScrollableSheet(
            shouldCloseOnMinExtent: true,
            expand: false,
            maxChildSize: 0.95,
            minChildSize: 0.64,
            initialChildSize: 0.65,
            snap: true,
            snapSizes: const [0.65, 0.95],
            builder: (context, scrollController) => ListView(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                const SizedBox(height: 24),
                TextFormField(
                  controller: taskFieldController,
                  style: const TextStyle(fontSize: 24),
                  maxLines: null,
                  minLines: 1,
                  decoration: const InputDecoration.collapsed(
                      hintText: "Task name",
                      hintStyle: TextStyle(
                          color: Colors.black45, fontWeight: FontWeight.w500)),
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
                          color: Colors.black45, fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      BlocBuilder<NewHomeBloc, NewHomeState>(
                        builder: (context, state) {
                          return NewTaskButtonWidget(
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
                      BlocBuilder<NewHomeBloc, NewHomeState>(
                        builder: (context, state) {
                          return NewTaskButtonWidget(
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
                      context.read<NewHomeBloc>().add(NewHomeSubmitTapped(
                          missionName: taskFieldController.text,
                          discription: descriptionFieldController.text));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          );
        }
      },
    );
  }
}
