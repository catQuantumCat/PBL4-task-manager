import 'package:flutter/material.dart';

class RecentlySearchedTile extends StatelessWidget {
  const RecentlySearchedTile(
      {super.key, required String recentQuery, void Function(String)? onTap})
      : _recentQuery = recentQuery,
        _onTap = onTap;

  final String _recentQuery;

  final void Function(String)? _onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (_onTap != null) {
          _onTap(_recentQuery);
        }
      },
      leading: const Icon(
        Icons.history,
        size: 28,
      ),
      title: Text(_recentQuery),
    );
  }
}
