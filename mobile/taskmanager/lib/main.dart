import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/view/list/home_list.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => HomeListBloc()..add(FetchTaskList()),
        child: const HomeListView(),
      ),
    );
  }
}
