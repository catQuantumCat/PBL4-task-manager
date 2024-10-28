import 'package:flutter/material.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key, required String query})
      : _query = query;

  final String _query;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_outlined,
            size: 50.0,
          ),
          Text("No result for $_query")
        ],
      ),
    );
  }
}
