import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/sheet.constants.dart';
import 'package:taskmanager/modules/task/bloc/task_detail/task_detail.bloc.dart';
import 'package:taskmanager/modules/task/widget/task_detail/task_detail_edit.widget.dart';
import 'package:taskmanager/modules/task/widget/task_detail/task_detail_success.widget.dart';

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
            Navigator.pop(context);
          }

          if (state.status == DetailHomeStatus.initial) {
            _closeOnMinHeight = true;
          }

          if (state.status == DetailHomeStatus.editing) {
            _initialSheetHeight = SheetConstants.maxHeight;
            _closeOnMinHeight = false;
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onVerticalDragEnd: (details) {
              log(details.primaryVelocity.toString());
              setState(() {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity! > 0) {
                  if (_initialSheetHeight < SheetConstants.minHeight &&
                      _closeOnMinHeight) {
                    //swipe to exit
                    context.read<TaskDetailBloc>().add(HomeTaskDetailClose());
                  } else {
                    _initialSheetHeight = SheetConstants.minHeight;
                  }
                } else if (details.primaryVelocity != null &&
                    details.primaryVelocity! <= 0) {
                  _initialSheetHeight =
                      _initialSheetHeight > SheetConstants.minHeight
                          ? SheetConstants.maxHeight
                          : SheetConstants.minHeight;
                }
              });
            },
            onVerticalDragUpdate: (details) {
              setState(() {
                _initialSheetHeight -=
                    (details.delta.dy / MediaQuery.sizeOf(context).height);
              });
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
                      return const TaskDetailSuccess();
                    case DetailHomeStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case DetailHomeStatus.editing:
                      return const TaskDetailEdit();
                    case DetailHomeStatus.failed:
                    default:
                      return Container();
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
