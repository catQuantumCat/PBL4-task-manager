import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/list_home.bloc.dart';
import 'package:taskmanager/presentation/home/view/home_task_list.dart';
import 'package:taskmanager/presentation/home/widget/new_task_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get builder => null;

  void _showTaskSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => const NewTaskWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: Colors.blueAccent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO
          _showTaskSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => ListHomeBloc()..add(FetchTaskList()),
        child: const HomeTaskList(),
      ),
    );
  }
}
