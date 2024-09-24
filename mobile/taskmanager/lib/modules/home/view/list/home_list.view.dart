import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/bloc/new/home_new_task.bloc.dart';

import 'package:taskmanager/modules/home/view/new/home_new_task.view.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  void _showNewTaskSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
              iconSize: 32,
            )
          ],
        ),
      ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeListBloc>().add(FetchTaskList());
          },
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
              Expanded(child: HomeListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
