import 'package:flutter/material.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key, required String query}) : _query = query;

  final String _query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            color: Colors.black54,
            Icons.search_off_outlined,
            size: 140.0,
          ),
          Center(
            child: Text(
              "No result for \"$_query\"",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
