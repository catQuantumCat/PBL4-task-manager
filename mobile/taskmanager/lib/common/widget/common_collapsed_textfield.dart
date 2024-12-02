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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: context.appTextStyles.textField,
              obscureText: widget.isSecured,
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
      ],
    );
  }
}
