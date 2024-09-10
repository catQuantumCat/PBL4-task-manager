import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/presentation/home/bloc/home_bloc.dart';
import 'package:taskmanager/presentation/home/widget/task_widget.dart';

class HomeTaskList extends StatelessWidget {
  const HomeTaskList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
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
                      .read<HomeBloc>()
                      .add(RemoveOneTask(taskToRemoveIndex: index));
                  context.read<HomeBloc>().add(FetchTaskList());
                },
                key: Key(state.taskList[index].name),
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
