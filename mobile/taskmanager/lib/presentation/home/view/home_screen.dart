import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/list/list_home.bloc.dart';
import 'package:taskmanager/presentation/home/bloc/new/new_home.bloc.dart';
import 'package:taskmanager/presentation/home/view/home_task_list.dart';
import 'package:taskmanager/presentation/home/view/modal/new_task.modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showTaskSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) => NewHomeBloc(),
              child: const NewTaskModal(),
            )).then((val) {
      if (mounted && val == "success") {
        context.read<ListHomeBloc>().add(FetchTaskList());
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
          _showTaskSheet();
        },
        child: const Icon(Icons.add),
      ),
      body: const HomeTaskList(),
    );
  }
}
