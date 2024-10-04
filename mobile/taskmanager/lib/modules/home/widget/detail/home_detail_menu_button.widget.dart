import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/home/bloc/detail/home_detail_task.bloc.dart';

class HomeDetailMenuButtonWidget extends StatefulWidget {
  const HomeDetailMenuButtonWidget({super.key});

  @override
  State<HomeDetailMenuButtonWidget> createState() =>
      _HomeDetailMenuButtonWidgetState();
}

class _HomeDetailMenuButtonWidgetState
    extends State<HomeDetailMenuButtonWidget> {
  void _onDelete() {
    showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Delete task?"),
            content: const Text("Action cannot be undone."),
            actions: [
              TextButton(
                  onPressed: () {
                    context
                        .read<HomeDetailTaskBloc>()
                        .add(HomeDetailTaskDelete());
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("No")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.deepPurple[100]),
          padding: const EdgeInsets.all(4),
          child: const Icon(Icons.more_horiz_outlined),
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: () =>
                  context.read<HomeDetailTaskBloc>().add(HomeDetailTaskEdit()),
              child: const Text("Edit"),
            ),
            PopupMenuItem(
              onTap: () {
                _onDelete();
              },
              child: const Text("Delete"),
            ),
          ];
        });
  }
}
