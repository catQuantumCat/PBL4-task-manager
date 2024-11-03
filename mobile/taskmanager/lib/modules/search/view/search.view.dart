import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';

import 'package:taskmanager/modules/search/bloc/search_bloc.dart';
import 'package:taskmanager/modules/search/widget/appbar_searchbar.widget.dart';
import 'package:taskmanager/modules/search/widget/search_empty.widget.dart';
import 'package:taskmanager/modules/search/widget/search_initial.widget.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';
import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
          taskRepository: getIt<TaskRepository>(),
          homeListBloc: BlocProvider.of<TaskListBloc>(context))
        ..add(const SearchOpen()),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  void _onTextChange(BuildContext context, String query) {
    if (query.isEmpty) {
      context.read<SearchBloc>().add(const SearchCancel());
      return;
    }
    context.read<SearchBloc>().add(SearchEnterQuery(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          body: CommonTitleAppbar(
            searchBar: AppbarSearchbarWidget(
                onChanged: (query) => _onTextChange(context, query)),
            searchBarHeight: 60,
            title: const Text(
              "Search",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            child: Builder(builder: (context) {
              switch (state.status) {
                case (StateStatus.initial):
                  return const SearchInitialWidget();
                case (StateStatus.success):
                  if (state.taskList.isEmpty) {
                    log(state.query);
                    return SearchEmptyWidget(query: state.query);
                  } else {
                    return TaskListView(
                      taskList: state.taskList,
                      allowDissiable: false,
                    );
                  }
                default:
                  return const Center(
                    child: Text(""),
                  );
              }
            }),
          ),
        );
      },
    );
  }
}
