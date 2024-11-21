import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonTitleAppbar extends StatefulWidget {
  const CommonTitleAppbar(
      {super.key,
      required String title,
      Widget? stickyWidget,
      List<Widget> section = const [],
      Widget? child,
      bool compactEnabled = false,
      Color? titleBackgroundColor})
      : _stickyWidget = stickyWidget,
        _title = title,
        _compactEnabled = compactEnabled,
        _section = section,
        _child = child,
        _titleBackgroundColor = titleBackgroundColor;
  final String _title;
  final Widget? _stickyWidget;

  final bool _compactEnabled;

  final Widget? _child;
  final List<Widget> _section;
  final Color? _titleBackgroundColor;

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
            backgroundColor: widget._titleBackgroundColor ??
                context.palette.scaffoldBackground,
            toolbarHeight: widget._compactEnabled == true ? 32 : kToolbarHeight,
            title: widget._compactEnabled == true
                ? Text(
                    widget._title,
                    style: context.appTextStyles.subHeading1,
                  )
                : null,
            centerTitle: true,
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
            expandedHeight: widget._compactEnabled ? null : 96,
            pinned: true,
            floating: false,
            flexibleSpace: widget._compactEnabled == true
                ? null
                : FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.only(
                        left: 16, right: 16, top: 0, bottom: 16),
                    title: Text(widget._title,
                        style: context.appTextStyles.subHeading1),
                  ),
            stretch: true,
          ),
          if (widget._stickyWidget != null)
            PinnedHeaderSliver(
              child:
                  Container(color: Colors.white, child: widget._stickyWidget),
            ),
          if (_isAppBarCollapsed)
            const PinnedHeaderSliver(
              child: Divider(
                height: 1,
                thickness: 1,
              ),
            ),
          if (widget._section.isEmpty)
            SliverToBoxAdapter(child: widget._child)
          else
            ...widget._section,
        ],
      ),
    );
  }
}
