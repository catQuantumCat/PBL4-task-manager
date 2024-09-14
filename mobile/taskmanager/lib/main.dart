import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/list/list_home.bloc.dart';
import 'package:taskmanager/presentation/home/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ListHomeBloc()..add(FetchTaskList()),
        child: const HomeScreen(),
      ),
    );
  }
}
