import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/bloc/new/home_new_task.bloc.dart';
import 'package:taskmanager/modules/home/view/list/cubit/home_cubit.dart';

import 'package:taskmanager/modules/home/view/new/home_new_task.view.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';
import 'package:taskmanager/modules/home/widget/list/home_list_appbar.widget.dart';

class HomeListPage extends StatelessWidget {
  const HomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<TaskListBloc>(context),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: const HomeListView(),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  void _showNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) =>
                  HomeNewTaskBloc(taskRepository: getIt<TaskRepository>()),
              child: const HomeNewTaskView(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final TaskListBloc taskListBloc = context.read<TaskListBloc>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        shape: const CircleBorder(),
        backgroundColor: Colors.red[400],
        foregroundColor: Colors.white,
        onPressed: () {
          _showNewTaskSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            taskListBloc.add(const ForceReloadTask()),
        child: HomeListAppbarWidget(
          topWidget: const Text(
            "Today",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          child: BlocBuilder<TaskListBloc, TaskListState>(
            builder: (context, state) {
              switch (state.status) {
                case StateStatus.initial:
                  return const Center(
                    child: Text("Initial state"),
                  );
                case StateStatus.failed:
                  return const Center(
                    child: Text("Fetching data failed "),
                  );
                case StateStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case StateStatus.success:
                  return HomeListWidget(
                    taskList: state.taskList,
                    onDismissed: (index) => taskListBloc.add(
                          RemoveOneTask(taskToRemoveIndex: index),
                        ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
