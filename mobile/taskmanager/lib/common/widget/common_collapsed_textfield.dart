import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonCollapsedTextField extends StatefulWidget {
  const CommonCollapsedTextField({
    super.key,
    required this.controller,
    this.label,
    this.hintText,
    this.isSecured = false,
    this.validator,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool isSecured;
  final String? Function(String?)? validator;

  @override
  State<CommonCollapsedTextField> createState() =>
      _CommonCollapsedTextFieldState();
}

class _CommonCollapsedTextFieldState extends State<CommonCollapsedTextField> {
  String? Function(String?)? _validator;
  bool _isSecureVisible = true;

  void _changeSecureVisibility() {
    setState(() {
      _isSecureVisible = !_isSecureVisible;
    });
  }

  void _changeValidator(String? Function(String?)? newValidator) {
    setState(() {
      _validator = newValidator;
    });
  }

  @override
  void initState() {
    _validator = widget.validator;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.label != null)
          SizedBox(
            width: 96,
            child: Text(
              widget.label!,
              style: context.appTextStyles.metadata1,
            ),
          ),
        Expanded(
          child: Focus(
            onFocusChange: (isFocused) {
              if (isFocused == false) {
                _changeValidator(widget.validator);
              }
            },
            child: TextFormField(
              onChanged: (_) => _changeValidator(null),
              textInputAction: TextInputAction.next,
              
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: context.appTextStyles.textField,
              obscureText: widget.isSecured && _isSecureVisible,
              
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                errorMaxLines: 2,
                hintText: widget.hintText,
                hintStyle: context.appTextStyles.hintTextField,
              ),
              controller: widget.controller,
              validator: _validator,
            ),
          ),
        ),
        if (!widget.isSecured && widget.controller.text.isNotEmpty)
          SizedBox(
            height: 16,
            child: IconButton(
              iconSize: 16,
              onPressed: () => widget.controller.clear(),
              icon: const Icon(
                Icons.clear,
              ),
            ),
          ),
        if (widget.isSecured)
          SizedBox(
            height: 16,
            child: IconButton(
              onPressed: widget.controller.text != ""
                  ? () => _changeSecureVisibility()
                  : null,
              icon: _isSecureVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
              iconSize: 16,
            ),
          )
      ],
    );
  }
}
