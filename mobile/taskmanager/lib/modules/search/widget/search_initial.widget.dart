import 'package:flutter/material.dart';

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            color: Colors.black54,
            Icons.search,
            size: 140,
          ),
          Text("Search for any task.")
        ],
      ),
    );
  }
}
