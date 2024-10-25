import 'package:flutter/material.dart';

class AppbarSearchbarWidget extends StatelessWidget {
  const AppbarSearchbarWidget({super.key, void Function(String)? onChanged})
      : _onChanged = onChanged;

  final void Function(String)? _onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextField(
        onChanged: (value) => _onChanged?.call(value),
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
