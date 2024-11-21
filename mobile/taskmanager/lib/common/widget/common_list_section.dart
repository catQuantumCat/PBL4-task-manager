import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonListSection extends StatefulWidget {
  const CommonListSection(
      {super.key,
      required this.title,
      this.trailing,
      this.child,
      this.isCollapsed = false,
      this.collapsedEnabled = true});

  final String title;
  final Widget? trailing;
  final Widget? child;
  final bool isCollapsed;

  final bool collapsedEnabled;

  @override
  State<CommonListSection> createState() => _CommonListSectionState();
}

class _CommonListSectionState extends State<CommonListSection> {
  late bool _isCollapsed;

  @override
  void initState() {
    super.initState();
    _isCollapsed = widget.isCollapsed;
  }

  void _onCollapseTapped() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        SliverPinnedHeader(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.palette.scaffoldBackground,
              border: Border(
                bottom: BorderSide(
                  color: context.palette.divider,
                  width: 1.0,
                ),
              ),
            ),
            child: SizedBox(
              height: 40,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: UIConstant.padding, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: (widget.child != null)
                          ? context.appTextStyles.subHeading3
                          : context.appTextStyles.disabledSubHeading3,
                    ),
                    Wrap(
                      children: [
                        if (widget.collapsedEnabled == true)
                          IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () => _onCollapseTapped(),
                            icon: Icon(_isCollapsed == true
                                ? Icons.keyboard_arrow_right
                                : Icons.keyboard_arrow_down),
                          ),
                        if (widget.trailing != null) widget.trailing!
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AnimatedOpacity(
            curve: Easing.standard,
            opacity: _isCollapsed ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: AnimatedSlide(
              curve: Easing.standard,
              offset: _isCollapsed ? const Offset(0, -1) : const Offset(0, 0),
              duration: const Duration(milliseconds: 300),
              child: widget.child,
            ),
          ),
        )
      ],
    );
  }
}
