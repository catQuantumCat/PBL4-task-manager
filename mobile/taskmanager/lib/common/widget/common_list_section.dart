import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonListSection extends MultiSliver {
  CommonListSection({
    required BuildContext context,
    super.key,
    required String title,
    Widget? trailing,
    Widget? child,
    bool isHidden = false,
  }) : super(
          pushPinnedChildren: true,
          children: isHidden == true
              ? []
              : [
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: UIConstant.padding, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: (child != null)
                                  ? context.appTextStyles.subHeading2
                                  : context.appTextStyles.disabledsubHeading2,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.chevron_right_sharp)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: child,
                  )
                ],
        );
}
