import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskListBloc, TaskListState>(
      buildWhen: (previous, current) =>
          previous.recentlyViewedTasks != current.recentlyViewedTasks,
      builder: (context, state) {
        return TaskListView(
          taskList: state.recentlyViewedTasks,
          allowDissiable: false,
        );
      },
    );
  }
}
