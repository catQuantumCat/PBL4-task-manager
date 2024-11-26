import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonTextFieldSection extends StatelessWidget {
  const CommonTextFieldSection(
      {super.key, required this.items, this.hintText, this.groupLabel});

  final List<Widget> items;
  final String? hintText;
  final String? groupLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (groupLabel != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text(
              groupLabel?.toUpperCase() ?? "",
              style: context.appTextStyles.metadata1,
            ),
          ),
        Container(
          padding: EdgeInsets.all(UIConstant.padding),
          decoration: BoxDecoration(
              color: context.palette.buttonBackground,
              borderRadius:
                  BorderRadius.circular(UIConstant.cornerRadiusMedium)),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0)
                  const Divider(
                    height: 32,
                  ),
                items[i],
              ],
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        if (hintText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              hintText!,
              style: context.appTextStyles.metadata1,
            ),
          ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
