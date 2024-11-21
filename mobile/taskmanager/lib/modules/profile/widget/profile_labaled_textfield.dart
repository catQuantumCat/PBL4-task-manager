import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';

class ProfileLabaledTextfield extends StatelessWidget {
  const ProfileLabaledTextfield({
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
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (label != null)
          SizedBox(
            width: 96,
            child: Text(
              label!,
              style: context.appTextStyles.metadata1,
            ),
          ),
        Expanded(
            child: TextFormField(
          style: context.appTextStyles.textField,
          obscureText: isSecured,
          decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: context.appTextStyles.hintTextField),
          controller: controller,
          validator: validator,
        )),
      ],
    );
  }
}
