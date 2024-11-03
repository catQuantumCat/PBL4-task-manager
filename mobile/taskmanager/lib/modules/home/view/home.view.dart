import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/widget/common_list_section.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/home/bloc/home_bloc.dart';

import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_create/home_new_task.view.dart';
import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<TaskListBloc>(context),
        ),
        // BlocProvider(
        //   create: (context) =>
        //       HomeBloc(taskRepository: getIt.get<TaskRepository>())
        //         ..add(const HomeOpen()),
        // ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) =>
                  TaskCreateBloc(taskRepository: getIt<TaskRepository>()),
              child: const TaskCreateView(),
            ));
  }

  @override
  Widget build(BuildContext context) {
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
            context.read<HomeBloc>().add(const HomeRefresh()),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              (previous.todayList != previous.todayList) ||
              (previous.overdueList != current.todayList),
          builder: (context, state) {
            if (state.status == StateStatus.success) {
              return CommonTitleAppbar(
                title: const Text("Today",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                section: [
                  CommonListSection(
                    title: "Overdue",
                    child: TaskListView(taskList: state.overdueList),
                  ),
                  CommonListSection(
                    title: "Today",
                    child: TaskListView(taskList: state.todayList),
                  )
                ],
              );
            } else {
              return CommonTitleAppbar(
                title: const Text("Today",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                child: Builder(builder: (context) {
                  switch (state.status) {
                    case StateStatus.initial:
                      return const Center(
                        child: Text("Initial state"),
                      );
                    case StateStatus.failed:
                      return const Center(child: CircularProgressIndicator());
                    case StateStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                    case StateStatus.success:
                      return const SizedBox.shrink();
                  }
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
