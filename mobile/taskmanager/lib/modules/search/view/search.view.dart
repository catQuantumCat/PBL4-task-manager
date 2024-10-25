import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/home/bloc/list/home_list.bloc.dart';
import 'package:taskmanager/modules/home/widget/list/home_list.widget.dart';
import 'package:taskmanager/modules/home/widget/list/home_list_appbar.widget.dart';
import 'package:taskmanager/modules/search/bloc/search_bloc.dart';
import 'package:taskmanager/modules/search/widget/appbar_searchbar.widget.dart';
import 'package:taskmanager/modules/search/widget/search_initial.widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
          taskRepository: getIt<TaskRepository>(),
          homeListBloc: BlocProvider.of<HomeListBloc>(context)),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  Timer? _debounce;

  String previousSearch = "";

  void _onTextChange(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      context.read<SearchBloc>().add(const SearchCancel());
      return;
    }

    setState(() {
      previousSearch = query;
    });

    _debounce = Timer(const Duration(milliseconds: 500),
        () => context.read<SearchBloc>().add(SearchEnterQuery(query: query)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          body: HomeListAppbarWidget(
            searchBar: AppbarSearchbarWidget(onChanged: _onTextChange),
            searchBarHeight: 60,
            topWidget: const Text(
              "Search",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            child: Builder(builder: (context) {
              switch (state.status) {
                case (StateStatus.initial):
                  return const SearchInitialWidget();
                case (StateStatus.success):
                  return HomeListWidget(taskList: state.taskList!);
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
