import 'package:flutter/material.dart';

class AppbarSearchbarWidget extends StatelessWidget {
  const AppbarSearchbarWidget({
    super.key,
    void Function(String)? onReturn,
    String? initialText,
    required TextEditingController textController,
  })  : _onReturn = onReturn,
        _textController = textController;

  final void Function(String)? _onReturn;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextFormField(
        controller: _textController,
        onFieldSubmitted: (value) {
          FocusManager.instance.primaryFocus?.unfocus();
          _onReturn?.call(value);
        },
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
