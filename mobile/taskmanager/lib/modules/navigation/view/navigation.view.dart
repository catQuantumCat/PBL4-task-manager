import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/home/bloc/home_bloc.dart';

import 'package:taskmanager/modules/home/view/home.view.dart';
import 'package:taskmanager/modules/navigation/bloc/navigation_bloc.dart';
import 'package:taskmanager/modules/navigation/widget/navigation.widget.dart';
import 'package:taskmanager/modules/profile/view/profile.view.dart';
import 'package:taskmanager/modules/search/bloc/search_bloc.dart';
import 'package:taskmanager/modules/search/view/search.view.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

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
          create: (context) =>
              TaskListBloc(taskRepository: getIt<TaskRepository>())
                ..add(const initTaskList()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(taskRepository: getIt<TaskRepository>())
            ..add(const HomeOpen()),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: const NavigationWidget(),
          body: <Widget>[
            const HomePage(),
            const SearchPage(),
            const ProfilePage(),
          ][state.index],
        );
      },
    );
  }
}
