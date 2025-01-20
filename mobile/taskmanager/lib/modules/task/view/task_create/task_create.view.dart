import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/toast/common_toast.dart';

import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_create/task_create_form.widget.dart';

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
  final GlobalKey taskFieldKey = GlobalKey();
  final GlobalKey descriptionFieldKey = GlobalKey();

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
        taskFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? descriptionFieldBox =
        descriptionFieldKey.currentContext?.findRenderObject() as RenderBox?;
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
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == NewHomeStatus.initial) {
          CommonToast.showStatusToast(context, "New task added");
        }

        if (state.status == NewHomeStatus.loading) {
          taskFieldController.clear();
          descriptionFieldController.clear();
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
                case NewHomeStatus.loading:
                case NewHomeStatus.initial:
                  return TaskCreateForm(
                    taskFieldKey: taskFieldKey,
                    taskFieldController: taskFieldController,
                    descriptionFieldKey: descriptionFieldKey,
                    descriptionFieldController: descriptionFieldController,
                  );

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
