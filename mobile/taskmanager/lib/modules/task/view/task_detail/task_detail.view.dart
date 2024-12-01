import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/bottomSheet/sheet.constants.dart';
import 'package:taskmanager/data/model/task_model.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';

import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

import 'package:taskmanager/modules/task/widget/task_detail/task_detail_edit.widget.dart';
import 'package:taskmanager/modules/task/widget/task_detail/task_detail.widget.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage(
      {super.key, required TaskModel task, required TaskListBloc taskListBloc})
      : _task = task,
        _taskListBloc = taskListBloc;

  final TaskModel _task;
  final TaskListBloc _taskListBloc;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (providerContext) {
            return TaskDetailBloc(
                taskRepository: getIt<TaskRepository>(),
                taskListBloc: _taskListBloc)
              ..add(HomeDetailTaskOpen(task: _task));
          },
        ),
      ],
      child: const TaskDetailView(),
    );
  }
}

class TaskDetailView extends StatefulWidget {
  const TaskDetailView({super.key});

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  double _initialSheetHeight = SheetConstants.minHeight;
  bool _closeOnMinHeight = true;

  @override
  void initState() {
    _initialSheetHeight.clamp(
        SheetConstants.minHeight, SheetConstants.maxHeight);

    super.initState();
  }

  double getHeight() {
    return _initialSheetHeight * MediaQuery.sizeOf(context).height;
  }

  @override
  Widget build(BuildContext context) {
    {
      return BlocConsumer<TaskDetailBloc, TaskDetailState>(
        listener: (context, state) {
          if (state.status == DetailHomeStatus.finished) {
            Navigator.pop(context, true);
          }

          if (state.status == DetailHomeStatus.initial) {
            _closeOnMinHeight = true;
          }

          if (state.status == DetailHomeStatus.loading) {
            _closeOnMinHeight = false;
          }

          if (state.status == DetailHomeStatus.editing) {
            _initialSheetHeight = SheetConstants.maxHeight;
            _closeOnMinHeight = false;
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onVerticalDragEnd: (_) {
              setState(() {
                switch (_initialSheetHeight) {
                  case < SheetConstants.closingMark:
                    if (_closeOnMinHeight == true) {
                      Navigator.pop(context);
                    } else {
                      _initialSheetHeight = SheetConstants.minHeight;
                    }

                  case >= SheetConstants.closingMark &&
                        < SheetConstants.expandingMark:
                    _initialSheetHeight = SheetConstants.minHeight;

                  case >= SheetConstants.expandingMark:
                    _initialSheetHeight = SheetConstants.maxHeight;
                }
              });
            },
            onVerticalDragUpdate: (details) {
              final currentHeight = _initialSheetHeight -
                  (details.delta.dy / MediaQuery.sizeOf(context).height);

              if (currentHeight <= 0) {
                _initialSheetHeight = 0;
              } else {
                setState(() {
                  _initialSheetHeight = currentHeight;
                });
              }
            },
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuint,
              child: SizedBox(
                height: getHeight(),
                child: Builder(builder: (
                  _,
                ) {
                  switch (state.status) {
                    case DetailHomeStatus.finished:
                    case DetailHomeStatus.initial:
                      return const TaskDetailWidget();
                    case DetailHomeStatus.loading:
                      return const CustomSheet(
                          body: SingleChildScrollView(
                              child:
                                  Center(child: CircularProgressIndicator())));
                    case DetailHomeStatus.editing:
                      return TaskDetailEdit(
                          focusOnTitle:
                              (state as TaskDetailStateEditing).focusOnTitle);
                    case DetailHomeStatus.failed:
                    default:
                      return const SizedBox.shrink();
                  }
                }),
              ),
            ),
          );
        },
      );
    }
  }
}
