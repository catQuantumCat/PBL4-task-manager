import 'package:flutter/material.dart';

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
            child: Text(label!),
          ),
        Expanded(
            child: TextFormField(
          obscureText: isSecured,
          decoration: InputDecoration.collapsed(
            hintText: hintText,
          ),
          controller: controller,
          validator: validator,
        )),
      ],
    );
  }
}
