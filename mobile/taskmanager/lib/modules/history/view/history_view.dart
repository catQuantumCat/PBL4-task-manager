import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/widget/common_error.page.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/history/bloc/history_bloc.dart';

import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(repository: getIt<TaskRepository>()),
      child: const HistoryView(),
    );
  }
}

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        switch (state.status) {
          case StateStatus.loading:
            return const CircularProgressIndicator();
          case StateStatus.success:
            return CustomSheet(
                header: "History",
                body: SingleChildScrollView(
                  child: TaskListPage(
                      allowDissiable: false,
                      showTilePadding: false,
                      taskList:
                          context.read<HistoryBloc>().state.completedTasks),
                ));
          case StateStatus.failed:
            return CommonErrorPage(onReloadTap: () {});
          default:
            break;
        }
        return const SizedBox.shrink();
      },
    );
  }
}
