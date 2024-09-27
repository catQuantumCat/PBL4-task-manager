import 'package:flutter/material.dart';

class HomeListAppbarWidget extends StatelessWidget {
  const HomeListAppbarWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
          centerTitle: true,
          primary: true,
          expandedHeight: 96,
          pinned: true,
          flexibleSpace: const FlexibleSpaceBar(
            titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(
              "Today",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          stretch: true,
        ),
        SliverToBoxAdapter(
          child: child,
        )
      ],
    );
  }
}
