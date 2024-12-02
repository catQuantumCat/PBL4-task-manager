import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/common/theme/color_enum.dart';
import 'package:taskmanager/common/toast/common_toast.dart';

import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_priority.sheet.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskCreateView();
  }
}

class TaskCreateView extends StatefulWidget {
  const TaskCreateView({super.key});

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  final taskFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();
  final GlobalKey _taskFieldKey = GlobalKey();
  final GlobalKey _descriptionFieldKey = GlobalKey();

  double _minChildSize = 0;

  @override
  void initState() {
    super.initState();

    taskFieldController.addListener(_scheduleHeightUpdate);
    descriptionFieldController.addListener(_scheduleHeightUpdate);

    _onHeightChanged();
  }

  void _scheduleHeightUpdate() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _onHeightChanged());
  }

  void _onHeightChanged() {
    if (!mounted) return;

    final RenderBox? taskFieldBox =
        _taskFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? descriptionFieldBox =
        _descriptionFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (taskFieldBox == null || descriptionFieldBox == null) return;

    final taskFieldHeight = taskFieldBox.size.height;
    final descriptionFieldHeight = descriptionFieldBox.size.height;

    final newSheetSize = ((taskFieldHeight + descriptionFieldHeight) /
            MediaQuery.of(context).size.height) +
        0.2;

    setState(() {
      _minChildSize = newSheetSize;
    });
  }

  void _showDateHandle(TaskCreateState state) async {
    final DateTime? selectedDate = await showDatePicker(
        initialDate: context.read<TaskCreateBloc>().state.date,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2032));

    if (!mounted) return;
    context.read<TaskCreateBloc>().add(NewHomeDateTapped(date: selectedDate));
  }

  void _showTimeHandle(TaskCreateState state) async {
    final TimeOfDay? time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(state.date));
    if (!mounted) {
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
  dispose() {
    taskFieldController.dispose();
    descriptionFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).viewInsets.bottom /
                MediaQuery.of(context).size.height +
            _minChildSize)
        .clamp(0.3, 0.9);
    return BlocConsumer<TaskCreateBloc, TaskCreateState>(
      listener: (context, state) {
        if (state.status == NewHomeStatus.success) {
          taskFieldController.clear();
          descriptionFieldController.clear();
          CommonToast.showStatusToast(context, "New task added");
        }
      },
      builder: (context, state) {
        return BlocBuilder<TaskCreateBloc, TaskCreateState>(
            builder: (context, state) {
          return DraggableScrollableSheet(
            expand: false,
            maxChildSize: 0.9,
            minChildSize: height,
            initialChildSize: height,
            builder: (context, scrollController) {
              switch (state.status) {
                case NewHomeStatus.initial:
                  return Container(
                    decoration: BoxDecoration(
                      color: context.palette.scaffoldBackground,
                      shape: BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.circular(UIConstant.cornerRadiusMedium),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      children: [
                        const SizedBox(height: 24),
                        TextFormField(
                          key: _taskFieldKey,
                          autofocus: true,
                          controller: taskFieldController,
                          style: context.appTextStyles.heading2,
                          maxLines: null,
                          minLines: 1,
                          decoration: InputDecoration.collapsed(
                            hintText: "Task name",
                            hintStyle:
                                context.appTextStyles.hintTextField.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: context.appTextStyles.heading2.fontSize,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        TextFormField(
                          key: _descriptionFieldKey,
                          controller: descriptionFieldController,
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
                                  foregroundColor: WidgetStatePropertyAll(
                                      context.palette.normalText),
                                ),
                                onPressed: () => _showDateHandle(state),
                                label: Text(state.dateLabel),
                                icon: const Icon(Icons.date_range),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              OutlinedButton.icon(
                                style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll(
                                      context.palette.normalText),
                                ),
                                label: Text(state.timeLabel),
                                icon: const Icon(Icons.access_time_outlined),
                                onPressed: () => _showTimeHandle(state),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              OutlinedButton.icon(
                                style: ButtonStyle(
                                  foregroundColor: WidgetStatePropertyAll(
                                      context.palette
                                          .getPriorityPrimary(state.priority)),
                                ),
                                label:
                                    Text(PriorityEnum.getLabel(state.priority)),
                                icon: const Icon(Icons.flag),
                                onPressed: () => _showPriorityHandle(
                                    context, state.priority),
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        IconButton.filled(
                            style: const ButtonStyle().copyWith(
                                backgroundColor: WidgetStatePropertyAll(
                                  context.palette.primaryColor,
                                ),
                                foregroundColor: WidgetStatePropertyAll(
                                  context.palette.onPrimary,
                                )),
                            onPressed: () {
                              context.read<TaskCreateBloc>().add(
                                  NewHomeSubmitTapped(
                                      missionName: taskFieldController.text,
                                      description:
                                          descriptionFieldController.text));
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
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
      },
    );
  }
}
