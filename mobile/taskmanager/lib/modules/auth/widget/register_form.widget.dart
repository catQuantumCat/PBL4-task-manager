import 'package:flutter/material.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';
import 'package:taskmanager/common/widget/common.text_form_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required formkey,
    required emailFieldController,
    required usernameFieldController,
    required passwordFieldController,
  })  : _formkey = formkey,
        _usernameFieldController = usernameFieldController,
        _passwordFieldController = passwordFieldController,
        _emailFieldController = emailFieldController;

  final GlobalKey<FormState> _formkey;
  final TextEditingController _usernameFieldController;
  final TextEditingController _passwordFieldController;
  final TextEditingController _emailFieldController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          CommonTextFormField(
              validator: (p0) => ValidationUtils.validateEmail(p0),
              hintText: "Email",
              controller: _emailFieldController),
          const SizedBox(height: 16),
          CommonTextFormField(
              validator: (p0) => ValidationUtils.validateField(p0),
              hintText: "Username",
              controller: _usernameFieldController),
          const SizedBox(height: 16),
          CommonTextFormField(
              validator: (p0) => ValidationUtils.validatePassword(p0),
              hintText: "Password",
              obscureText: true,
              controller: _passwordFieldController),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
