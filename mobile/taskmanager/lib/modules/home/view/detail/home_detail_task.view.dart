import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/detail/home_detail_task.bloc.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_edit.view.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_loaded.view.dart';

class HomeDetailTaskView extends StatelessWidget {
  const HomeDetailTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    {
      return BlocConsumer<HomeDetailTaskBloc, HomeDetailTaskState>(
        listener: (context, state) {
          if (state.status == DetailHomeStatus.success) {
            log(state.isEdited.toString());
            Navigator.pop(context, state.isEdited);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case DetailHomeStatus.initial:
            case DetailHomeStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DetailHomeStatus.loaded:
              return const HomeDetailLoadedView();
            case DetailHomeStatus.editing:
              return const HomeDetailTaskEditView();
            case DetailHomeStatus.error:
            // TODO: Handle this case.
            default:
              return Container();
          }
        },
      );
    }
  }
}
