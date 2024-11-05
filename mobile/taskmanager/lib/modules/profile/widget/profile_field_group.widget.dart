import 'package:flutter/material.dart';

class ProfileFieldGroup extends StatelessWidget {
  const ProfileFieldGroup(
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
            child: Text(groupLabel?.toUpperCase() ?? ""),
          ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(hintText ?? ""),
        )
      ],
    );
  }
}
