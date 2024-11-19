import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/calendar/view/calendar.view.dart';
import 'package:taskmanager/modules/home/bloc/home_bloc.dart';

import 'package:taskmanager/modules/home/view/home.view.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';
import 'package:taskmanager/modules/navigation/widget/navigation.widget.dart';
import 'package:taskmanager/modules/profile/view/profile.view.dart';
import 'package:taskmanager/modules/search/bloc/search_bloc.dart';
import 'package:taskmanager/modules/search/view/search.view.dart';
import 'package:taskmanager/modules/task/bloc/task_create/task_create.bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_create/task_create.view.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        BlocProvider<TaskListBloc>(
          create: (context) {
            return TaskListBloc(taskRepository: getIt<TaskRepository>());
          },
        ),
        BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(taskRepository: getIt<TaskRepository>()),
        ),
        BlocProvider<SearchBloc>(
            create: (context) =>
                SearchBloc(taskRepository: getIt<TaskRepository>())
                  ..add(const SearchOpen()))
      ],
      child: const NavigationView(),
    );
  }
}

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  void _showNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) =>
                  TaskCreateBloc(taskRepository: getIt<TaskRepository>()),
              child: const TaskCreatePage(),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 4,
            shape: const CircleBorder(),
            backgroundColor: context.palette.primaryColor,
            foregroundColor: Colors.white,
            onPressed: () {
              _showNewTaskSheet(context);
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: const NavigationWidget(),
          body: <Widget>[
            const HomePage(),
            const CalendarPage(),
            const SearchPage(),
            const ProfilePage(),
            
          ][state.index],
        );
      },
    );
  }
}
