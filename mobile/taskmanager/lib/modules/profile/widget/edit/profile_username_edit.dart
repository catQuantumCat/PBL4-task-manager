import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/toast/common_toast.dart';

import 'package:taskmanager/modules/profile/widget/profile_field_group.widget.dart';
import 'package:taskmanager/modules/profile/widget/profile_labaled_textfield.dart';

class ProfileUsernameEdit extends StatefulWidget {
  const ProfileUsernameEdit({super.key});

  @override
  State<ProfileUsernameEdit> createState() => _ProfileUsernameEditState();
}

class _ProfileUsernameEditState extends State<ProfileUsernameEdit> {
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
                  "Your confirmation username does not match your new username"),
            );
          });
    } else {
      CommonToast.showStatusToast(sheetContext, "Username updated sucessfully");
      Navigator.pop<Map<String, String>>(sheetContext, {
        'username': _newController.text,
        'password': _passwordFieldController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      enableControl: true,
      backgroundColor: context.palette.scaffoldBackgroundDim,
      showHandle: false,
      onCancel: () => _onCancel(context),
      onSave: _isSaveEnabled == false ? null : () => _onSave(context),
      header: "Edit username",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16,
          ),
          ProfileFieldGroup(
            items: [
              ProfileLabaledTextfield(
                label: "New",
                hintText: "enter username",
                controller: _newController,
              ),
              ProfileLabaledTextfield(
                label: "Confirm",
                hintText: "re-enter username",
                controller: _confirmController,
              ),
            ],
            hintText: "Enter a new username for your account.",
          ),
          const SizedBox(
            height: 32,
          ),
          ProfileFieldGroup(
            items: [
              ProfileLabaledTextfield(
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
