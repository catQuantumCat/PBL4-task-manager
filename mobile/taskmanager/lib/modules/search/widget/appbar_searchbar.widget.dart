import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextFormField(
        cursorColor: context.palette.primaryColor,
        controller: _textController,
        onFieldSubmitted: (value) {
          FocusManager.instance.primaryFocus?.unfocus();
          _onReturn?.call(value);
        },
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: context.palette.disabledText),
          filled: true,
          fillColor: context.palette.textFieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: UIConstant.textBoxContentPadding),
          prefixIcon: Icon(Icons.search, color: context.palette.disabledText),
        ),
      ),
    );
  }
}
