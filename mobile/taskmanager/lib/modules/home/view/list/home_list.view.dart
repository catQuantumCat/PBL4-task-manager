import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/bloc/new/home_new_task.bloc.dart';

import 'package:taskmanager/modules/home/view/new/home_new_task.view.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';
import 'package:taskmanager/modules/home/widget/list/home_list_appbar.widget.dart';

class HomeListPage extends StatelessWidget {
  const HomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeListBloc(taskRepository: getIt<TaskRepository>())
        ..add(FetchTaskList()),
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
            )).then((val) {
      if (context.mounted && val == "success") {
        context.read<HomeListBloc>().add(FetchTaskList());
      }
    });
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
      // ignore: prefer_const_constructors
      body: RefreshIndicator(
        onRefresh: () async =>
            context.read<HomeListBloc>().add(FetchTaskList()),
        child: const HomeListAppbarWidget(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: HomeListWidget(),
          ),
        ),
      ),
    );
  }
}
