import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CommonListSection extends MultiSliver {
  CommonListSection({
    super.key,
    required String title,
    Color headerColor = Colors.white,
    Color titleColor = Colors.black,
    required Widget child,
  }) : super(
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: ColoredBox(
                color: headerColor,
                child: ListTile(
                  textColor: titleColor,
                  title: Text(title),
                ),
              ),
            ),
            // SliverList(
            //   delegate: SliverChildListDelegate.fixed(items),
            // )
            SliverToBoxAdapter(
              child: child,
            )
          ],
        );
}
