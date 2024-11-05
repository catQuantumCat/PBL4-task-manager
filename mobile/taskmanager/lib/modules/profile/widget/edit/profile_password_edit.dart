import 'package:flutter/material.dart';

import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/utils/ux_writing.util.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';

import 'package:taskmanager/modules/profile/widget/profile_field_group.widget.dart';
import 'package:taskmanager/modules/profile/widget/profile_labaled_textfield.dart';

class ProfilePasswordEdit extends StatefulWidget {
  const ProfilePasswordEdit({super.key});

  @override
  State<ProfilePasswordEdit> createState() => _ProfilePasswordEditState();
}

class _ProfilePasswordEditState extends State<ProfilePasswordEdit> {
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
                  "Your confirmation password does not match your new password"),
            );
          });
      return;
    }
    final passwordValidation =
        ValidationUtils.validatePassword(_newController.text);

    if (passwordValidation != null) {
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
                content: Text(passwordValidation),
              );
            });
        return;
      }
    }

    Navigator.pop<Map<String, String>>(sheetContext, {
      'new_password': _newController.text,
      'password': _passwordFieldController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet.inputSheet(
      onCancel: () => _onCancel(context),
      onSave: _isSaveEnabled == false ? null : () => _onSave(context),
      header: "Edit email",
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
                label: "Current",
                hintText: "current password",
                controller: _passwordFieldController,
                isSecured: true,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileFieldGroup(
            items: [
              ProfileLabaledTextfield(
                label: "New",
                hintText: "enter password",
                controller: _newController,
                isSecured: true,
              ),
              ProfileLabaledTextfield(
                label: "Confirm",
                hintText: "re-enter password",
                controller: _confirmController,
                isSecured: true,
              ),
            ],
            hintText: UXWritingEnum.authInvalidPassword.value,
          ),
        ],
      ),
    );
  }
}
