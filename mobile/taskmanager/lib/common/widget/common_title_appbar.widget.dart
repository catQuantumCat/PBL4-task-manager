import 'package:flutter/material.dart';

class CommonTitleAppbar extends StatelessWidget {
  const CommonTitleAppbar(
      {super.key,
      required this.child,
      required Widget topWidget,
      Widget? searchBar,
      this.searchBarHeight = 0})
      : _searchBar = searchBar,
        _topWidget = topWidget;
  final Widget _topWidget;
  final Widget? _searchBar;
  final double searchBarHeight;
  final Widget child;

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
          expandedHeight: 96 + searchBarHeight,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
                left: 16, right: 16, top: 0, bottom: searchBarHeight + 10),
            title: _topWidget,
          ),
          stretch: true,
        ),
        SliverFillRemaining(
          child: child,
        )
      ],
    );
  }
}
