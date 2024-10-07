import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/widget/list/home_list_tile.widget.dart';

class HomeListWidget extends StatelessWidget {
  const HomeListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      builder: (context, state) {
        switch (state.status) {
          case HomeListStatus.initial:
          case HomeListStatus.failed:
            return const Center(
              child: Text("Fetching data failed "),
            );
          case HomeListStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case HomeListStatus.success:
            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              itemCount: state.taskList.length,
              itemBuilder: (_, index) => Dismissible(
                direction: DismissDirection.endToStart,
                background: Container(
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
                  context.read<HomeListBloc>().add(RemoveOneTask(
                      taskToRemoveIndex: state.taskList[index].id));
                },
                key: Key(state.taskList[index].name),
                child: HomeListTileWidget(
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
