import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:taskmanager/common/widget/common_list_section.dart';

const APPBARHEIGHT = 96;

class CommonTitleAppbar extends StatelessWidget {
  const CommonTitleAppbar(
      {super.key,
      // required this.child,
      required Widget title,
      Widget? searchBar,
      this.searchBarHeight = 0,
      this.section = const [],
      this.child})
      : _searchBar = searchBar,
        _title = title;
  final Widget _title;
  final Widget? _searchBar;
  final double searchBarHeight;
  final Widget? child;
  final List<CommonListSection> section;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          bottom: _searchBar == null
              ? null
              : PreferredSize(
                  preferredSize: Size.fromHeight(searchBarHeight.toDouble()),
                  child: _searchBar,
                ),
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_horiz,
                  size: 32,
                ))
          ],
          primary: true,
          expandedHeight: APPBARHEIGHT + searchBarHeight,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                left: 16, right: 16, top: 0, bottom: searchBarHeight + 10),
            title: _title,
          ),
          stretch: true,
        ),
        SliverToBoxAdapter(child: child),
        ...section,
      ],
    );
  }
}
