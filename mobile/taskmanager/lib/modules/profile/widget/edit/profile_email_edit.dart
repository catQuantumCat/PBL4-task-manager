import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/helpers/dialog_helper.dart';
import 'package:taskmanager/common/toast/common_toast.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';

import 'package:taskmanager/common/widget/common_textfield_section.dart';
import 'package:taskmanager/common/widget/common_collapsed_textfield.dart';
import 'package:taskmanager/modules/profile/bloc/profile_bloc.dart';

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
    final emailValidation = ValidationUtils.validateEmail(_newController.text);

    if (_newController.text != _confirmController.text) {
      DialogHelper.showError(context,
          title: "Cannot proceed", content: "Emails do not match");
    } else if (emailValidation != null) {
      DialogHelper.showError(context,
          title: "Cannot proceed", content: emailValidation);
    } else {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          email: _newController.text, password: _passwordFieldController.text));
    }
    _passwordFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          CommonToast.showStatusToast(context, "Email updated sucessfully");

          Navigator.pop(context);
        }
      },
      child: CustomSheet(
        showCancelButton: true,
        showSaveButton: true,
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
              hintText:
                  "Your current email is ${context.read<ProfileBloc>().state.userInfo?.email} \nEnter a new email for your account.",
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
      ),
    );
  }
}
