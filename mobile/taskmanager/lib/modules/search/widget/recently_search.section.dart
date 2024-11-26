import 'package:flutter/material.dart';

class RecentlySearchedListTile extends StatelessWidget {
  const RecentlySearchedListTile(
      {super.key,
      required List<String> recentlySearched,
      void Function(String)? onTap})
      : _recentlySearched = recentlySearched,
        _onTap = onTap;

  final List<String> _recentlySearched;
  final void Function(String)? _onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: _recentlySearched.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(_recentlySearched[index]),
        onTap: () => _onTap?.call(_recentlySearched[index]),
        leading: const Icon(Icons.history),
      ),
    );
  }
}
