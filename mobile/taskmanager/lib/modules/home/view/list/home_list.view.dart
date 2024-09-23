import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/list_home.bloc.dart';
import 'package:taskmanager/modules/home/bloc/new/new_home.bloc.dart';

import 'package:taskmanager/modules/home/view/new/new_task.view.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';



class HomeListView extends StatefulWidget {
  const HomeListView({super.key});

  @override
  State<HomeListView> createState() => _HomeListViewState();
}

class _HomeListViewState extends State<HomeListView> {
  void _showTaskSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => BlocProvider(
              create: (context) => NewHomeBloc(),
              child: const NewTaskView(),
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
      body: const HomeListWidget(),
    );
  }
}
