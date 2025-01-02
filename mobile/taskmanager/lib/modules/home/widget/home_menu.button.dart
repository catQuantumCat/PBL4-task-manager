import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/modules/history/view/history_view.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

class HomeMenuButton extends StatelessWidget {
  const HomeMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        constraints: const BoxConstraints.tightFor(width: 220),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: context.palette.buttonBackground),
          padding: const EdgeInsets.all(4),
          child: Icon(
            Icons.more_horiz_outlined,
            color: context.palette.buttonForeground,
          ),
        ),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
              onTap: () {
                CommonBottomSheet.show(
                  isDismissible: false,
                    context: context,
                    child: BlocProvider.value(
                      value: BlocProvider.of<TaskListBloc>(context),
                      child: const HistoryPage(),
                    ));
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style: context.appTextStyles.buttonLabel,
                    ),
                    const Icon(Icons.history)
                  ]),
            ),
          ];
        });
  }
}
