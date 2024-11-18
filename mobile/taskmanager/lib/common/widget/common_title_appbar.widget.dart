import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/common/widget/common_list_section.dart';

const APPBARHEIGHT = 96;

class CommonTitleAppbar extends StatefulWidget {
  const CommonTitleAppbar(
      {super.key,
      required String title,
      Widget? searchBar,
      this.section = const [],
      this.child})
      : _searchBar = searchBar,
        _title = title;
  final String _title;
  final Widget? _searchBar;
  final Widget? child;
  final List<CommonListSection> section;

  @override
  State<CommonTitleAppbar> createState() => _CommonTitleAppbarState();
}

class _CommonTitleAppbarState extends State<CommonTitleAppbar> {
  final _scrollController = ScrollController();
  bool _isAppBarCollapsed = false;

  void _onListener() {
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      bool isCollapsed = offset > 80 - kToolbarHeight;
      if (isCollapsed != _isAppBarCollapsed) {
        setState(() {
          _isAppBarCollapsed = isCollapsed;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
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
            expandedHeight: 96,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                  left: 16, right: 16, top: 0, bottom: 16),
              title:
                  Text(widget._title, style: context.appTextStyles.subHeading1),
            ),
            stretch: true,
          ),
          if (widget._searchBar != null)
            PinnedHeaderSliver(
              child: Container(color: Colors.white, child: widget._searchBar),
            ),
          if (_isAppBarCollapsed)
            const PinnedHeaderSliver(
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
          if (widget.section.isEmpty)
            SliverToBoxAdapter(child: widget.child)
          else
            ...widget.section,
        ],
      ),
    );
  }
}
