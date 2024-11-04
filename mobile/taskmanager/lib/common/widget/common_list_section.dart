import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommonListSection extends MultiSliver {
  CommonListSection({
    super.key,
    required String title,
    Color headerColor = Colors.white,
    Widget? trailing,
    Color titleColor = Colors.black,
    required Widget child,
    bool isHidden = false,
  }) : super(
          pushPinnedChildren: true,
          children: isHidden == true
              ? []
              : [
                  SliverPinnedHeader(
                    child: ColoredBox(
                      color: headerColor,
                      child: ListTile(
                        trailing: trailing,
                        textColor: titleColor,
                        title: Text(title),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: child,
                  )
                ],
        );
}
