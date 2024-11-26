import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/toast/common_toast.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/main.dart';

import 'package:taskmanager/common/widget/common_textfield_section.dart';
import 'package:taskmanager/common/widget/common_collapsed_textfield.dart';

class ProfileEmailEdit extends StatefulWidget {
  const ProfileEmailEdit({super.key});

  @override
  State<ProfileEmailEdit> createState() => _ProfileEmailEditState();
}

class _ProfileEmailEditState extends State<ProfileEmailEdit> {
  final TextEditingController _newController = TextEditingController();

  final TextEditingController _confirmController = TextEditingController();

  final TextEditingController _passwordFieldController =
      TextEditingController();

  bool _isSaveEnabled = false;

  void _verifyInputFields() {
    final status = (_newController.text.isNotEmpty &&
        _confirmController.text.isNotEmpty &&
        _passwordFieldController.text.isNotEmpty);

    setState(() {
      log(_isSaveEnabled.toString(), name: "Save enabled?");
      _isSaveEnabled = status;
    });
  }

  @override
  void initState() {
    super.initState();
    _newController.addListener(_verifyInputFields);
    _confirmController.addListener(_verifyInputFields);
    _passwordFieldController.addListener(_verifyInputFields);
  }

  @override
  void dispose() {
    _newController.dispose();
    _confirmController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  void _onCancel(BuildContext sheetContext) {
    Navigator.pop(sheetContext);
  }

  void _onSave(BuildContext sheetContext) {
    if (_newController.text != _confirmController.text) {
      showDialog(
          context: sheetContext,
          builder: (dialogContext) {
            return AlertDialog(
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text("Try again"))
              ],
              title: const Text("Cannot proceed"),
              content: const Text(
                  "Your confirmation email does not match your new email"),
            );
          });
      return;
    }
    final emailValidation = ValidationUtils.validateEmail(_newController.text);

    if (emailValidation != null) {
      {
        showDialog(
            context: sheetContext,
            builder: (dialogContext) {
              return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text("Try again"))
                ],
                title: const Text("Cannot proceed"),
                content: Text(emailValidation),
              );
            });
        return;
      }
    }

    CommonToast.showStatusToast(sheetContext, "Email updated sucessfully");

    Navigator.pop<Map<String, String>>(sheetContext, {
      'email': _newController.text,
      'password': _passwordFieldController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      showCancelButton: true,
      backgroundColor: context.palette.scaffoldBackgroundDim,
      showHandle: false,
      onCancel: () => _onCancel(context),
      onSave: _isSaveEnabled == false ? null : () => _onSave(context),
      header: "Edit email",
      body: ListView(
        children: [
          const SizedBox(
            height: 16,
          ),
          CommonTextFieldSection(
            items: [
              CommonCollapsedTextField(
                label: "New",
                hintText: "enter email",
                controller: _newController,
              ),
              CommonCollapsedTextField(
                label: "Confirm",
                hintText: "re-enter email",
                controller: _confirmController,
              ),
            ],
            hintText: "Enter a new email for your account.",
          ),
          const SizedBox(
            height: 32,
          ),
          CommonTextFieldSection(
            items: [
              CommonCollapsedTextField(
                label: "Password",
                hintText: "enter password",
                controller: _passwordFieldController,
                isSecured: true,
              )
            ],
            hintText: "Use your current password to confirm.",
          ),
        ],
      ),
    );
  }
}
