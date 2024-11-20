import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/widget/common_list_section.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';

import 'package:taskmanager/modules/search/bloc/search_bloc.dart';
import 'package:taskmanager/modules/search/widget/appbar_searchbar.widget.dart';
import 'package:taskmanager/modules/search/widget/recently_search.section.dart';
import 'package:taskmanager/modules/search/widget/search_empty.widget.dart';
import 'package:taskmanager/modules/search/widget/search_initial.widget.dart';
import 'package:taskmanager/modules/task/view/task_list/task_list.view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchView();
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _textController.text = context.read<SearchBloc>().state.query;
    _textController.addListener(() => _onTextChange());
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onTextChange() {
    final query = _textController.text;
    if (query.isEmpty) {
      context.read<SearchBloc>().add(const SearchCancel());
      return;
    }
    context.read<SearchBloc>().add(SearchEnterQuery(query: query));
  }

  void _onReturnTapped() {
    final searchQuery = _textController.text;
    if (searchQuery.isEmpty) return;
    context.read<SearchBloc>().add(SearchReturnTapped(query: searchQuery));
  }

  void _onRecentSearchQueryTapped(String tappedQuery) {
    _textController.text = tappedQuery;
    context.read<SearchBloc>().add(SearchEnterQuery(query: tappedQuery));
  }

  void _onClearRecentTapped() {
    context.read<SearchBloc>().add(const SearchClearRecent());
  }

  List<CommonListSection> _buildSections(SearchState state) {
    if (state.status == StateStatus.initial) {
      return [
        CommonListSection(
          context: context,
          title: "Recent searches",
          trailing: TextButton(
            onPressed: _onClearRecentTapped,
            child: const Text("Clear"),
          ),
          isHidden: state.recentlySearched.isEmpty,
          child: RecentlySearchedListTile(
            recentlySearched: state.recentlySearched,
            onTap: (tappedQuery) {
              _onRecentSearchQueryTapped(tappedQuery);
            },
          ),
        ),
        CommonListSection(
          context: context,
          title: "Recently Viewed",
          child: const SearchInitialWidget(),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.palette.scaffoldBackground,
          body: CommonTitleAppbar(
            section: _buildSections(state),
            stickyWidget: AppbarSearchbarWidget(
              textController: _textController,
              onReturn: (query) => _onReturnTapped(),
            ),
            title: "Search",
            child: Builder(builder: (context) {
              switch (state.status) {
                case (StateStatus.failed):
                  return SearchFailedWidget(
                      query: state.errorMessage ?? "Something went wrong!");
                case (StateStatus.success):
                  return TaskListView(
                    taskList: state.taskList,
                    allowDissiable: false,
                  );
                default:
                  return const SizedBox.shrink();
              }
            }),
          ),
        );
      },
    );
  }
}
