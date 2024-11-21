import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/datetime_extension.dart';
import 'package:taskmanager/common/widget/common_list_section.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';

import 'package:taskmanager/modules/home/bloc/home_bloc.dart';

import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<TaskListBloc>(context),
        ),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  List<CommonListSection> _getSections(BuildContext context, HomeState state) {
    if (state.status == StateStatus.success) {
      return [
        if (state.overdueList.isEmpty == false)
          CommonListSection(
            title: "Overdue",
            child: TaskListView(taskList: state.overdueList),
          ),
        CommonListSection(
          title: DateTime.now().dateToString(),
          child: (state.todayList.isNotEmpty)
              ? TaskListView(taskList: state.todayList)
              : null,
        )
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.palette.scaffoldBackground,
      body: RefreshIndicator(
        color: context.palette.primaryColor,
        backgroundColor: context.palette.onPrimary,
        onRefresh: () async =>
            context.read<HomeBloc>().add(const HomeRefresh()),
        child: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              (previous.overdueList != current.todayList),
          builder: (context, state) {
            return CommonTitleAppbar(
              title: "Today",
              section: _getSections(context, state),
              child: Builder(builder: (context) {
                switch (state.status) {
                  case StateStatus.initial:
                    return const Center(
                      child: Text("Initial state"),
                    );
                  case StateStatus.failed:
                    return const Center(child: CircularProgressIndicator());
                  case StateStatus.loading:
                    return const Center(child: CircularProgressIndicator());
                  case StateStatus.success:
                    return const SizedBox.shrink();
                }
              }),
            );
          },
        ),
      ),
    );
  }
}
