import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/home_bloc.dart';
import 'package:taskmanager/presentation/home/view/home_task_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  get builder => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Task Manager'),
          backgroundColor: Colors.blueAccent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO
          print("pressed");
        },
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc()..add(FetchTaskList()),
        child: const HomeTaskList(),
      ),
    );
  }
}
