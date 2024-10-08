import 'package:flutter/material.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';
import 'package:taskmanager/modules/auth/widget/round_text_form_field.widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required formkey,
    required usernameFieldController,
    required passwordFieldController,
  })  : _formkey = formkey,
        _usernameFieldController = usernameFieldController,
        _passwordFieldController = passwordFieldController;

  final GlobalKey<FormState> _formkey;
  final TextEditingController _usernameFieldController;
  final TextEditingController _passwordFieldController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          RoundTextFormField(
              validator: (p0) => ValidationUtils.validateField(p0),
              hintText: "Username",
              controller: _usernameFieldController),
          const SizedBox(height: 16),
          RoundTextFormField(
              validator: (p0) => ValidationUtils.validateField(p0),
              hintText: "Password",
              obscureText: true,
              controller: _passwordFieldController),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
