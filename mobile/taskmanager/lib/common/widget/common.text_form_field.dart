import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField(
      {super.key,
      this.obscureText = false,
      required this.controller,
      this.validator,
      this.hintText});

  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        errorMaxLines: 3,
        focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(UIConstant.cornerRadiusWeak))),
        filled: true,
        fillColor: Colors.grey[300],
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(UIConstant.cornerRadiusWeak),
          ),
        ),
      ),
    );
  }
}
