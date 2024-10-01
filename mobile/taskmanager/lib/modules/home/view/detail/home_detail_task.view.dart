import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/detail/home_detail_task.bloc.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_edit.view.dart';
import 'package:taskmanager/modules/home/view/detail/home_detail_loaded.view.dart';

class HomeDetailTaskView extends StatefulWidget {
  const HomeDetailTaskView({super.key});

  @override
  State<HomeDetailTaskView> createState() => _HomeDetailTaskViewState();
}

class _HomeDetailTaskViewState extends State<HomeDetailTaskView> {
  double initialSheetHeight = 0.601;

  @override
  Widget build(BuildContext context) {
    {
      return BlocConsumer<HomeDetailTaskBloc, HomeDetailTaskState>(
        listener: (context, state) {
          if (state.status == DetailHomeStatus.finished) {
            Navigator.pop(context, state.isEdited);
          }
        },
        builder: (context, state) {
          return DraggableScrollableSheet(
              shouldCloseOnMinExtent: true,
              expand: false,
              maxChildSize: 0.95,
              minChildSize: 0.6,
              initialChildSize: initialSheetHeight,
              snap: true,
              snapSizes: const [0.601, 0.95],
              builder: (context, scrollController) {
                if (state.status == DetailHomeStatus.editing) {
                  initialSheetHeight = 0.9;
                }
                switch (state.status) {
                  case DetailHomeStatus.initial:
                    return HomeDetailLoadedView(
                      scrollController: scrollController,
                    );
                  case DetailHomeStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case DetailHomeStatus.editing:
                    return HomeDetailTaskEditView(
                      scrollController: scrollController,
                    );
                  case DetailHomeStatus.failed:
                  default:
                    return Container();
                }
              });
        },
      );
    }
  }
}
