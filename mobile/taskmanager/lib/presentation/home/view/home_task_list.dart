import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/list_home.bloc.dart';
import 'package:taskmanager/presentation/home/widget/task_widget.dart';

class HomeTaskList extends StatelessWidget {
  const HomeTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListHomeBloc, ListHomeState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initial:
          case HomeStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeStatus.success:
            return ListView.builder(
              addAutomaticKeepAlives: false,
              itemCount: state.taskList.length,
              itemBuilder: (_, index) => Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.redAccent,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onDismissed: (_) {
                  context
                      .read<ListHomeBloc>()
                      .add(RemoveOneTask(taskToRemoveIndex: index));
                  context.read<ListHomeBloc>().add(FetchTaskList());
                },
                key: Key(state.taskList[index].missionName),
                child: TaskWidget(
                  task: state.taskList[index],
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
            );
        }
      },
    );
  }
}
