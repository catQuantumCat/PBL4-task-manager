import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/bloc/new/home_new_task.bloc.dart';

import 'package:taskmanager/modules/home/view/new/home_new_task.view.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  void _showTaskSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) => HomeNewTaskBloc(),
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
      appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: Colors.blueAccent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: const HomeListWidget(),
    );
  }
}
