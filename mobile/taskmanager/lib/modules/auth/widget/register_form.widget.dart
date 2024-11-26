import 'package:flutter/material.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';
import 'package:taskmanager/common/widget/common_textfield_section.dart';
import 'package:taskmanager/common/widget/common_collapsed_textfield.dart';

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
          CommonTextFieldSection(
            groupLabel: "your email",
            items: [
              CommonCollapsedTextField(
                  validator: (p0) => ValidationUtils.validateEmail(p0),
                  hintText: "Email",
                  controller: _emailFieldController)
            ],
          ),
          CommonTextFieldSection(
            groupLabel: "Your username",
            items: [
              CommonCollapsedTextField(
                  validator: (p0) => ValidationUtils.validateField(p0),
                  hintText: "Username",
                  controller: _usernameFieldController)
            ],
          ),
          CommonTextFieldSection(
            groupLabel: "Your password",
            items: [
              CommonCollapsedTextField(
                  validator: (p0) => ValidationUtils.validatePassword(p0),
                  hintText: "Password",
                  isSecured: true,
                  controller: _passwordFieldController)
            ],
          ),
        ],
      ),
    );
  }
}
