import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/helpers/dialog_helper.dart';
import 'package:taskmanager/common/toast/common_toast.dart';
import 'package:taskmanager/common/utils/ux_writing.util.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';

import 'package:taskmanager/common/widget/common_textfield_section.dart';
import 'package:taskmanager/common/widget/common_collapsed_textfield.dart';

import 'package:taskmanager/modules/profile/bloc/profile_bloc.dart';

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
    final passwordValidation =
        ValidationUtils.validatePassword(_newController.text);
    if (_newController.text != _confirmController.text) {
      DialogHelper.showError(
        context,
        title: "Cannot proceed",
        content: "Your confirmation password does not match your new password",
      );
    } else if (passwordValidation != null) {
      {
        DialogHelper.showError(
          context,
          title: "Cannot proceed",
          content: passwordValidation,
        );
      }
    } else {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          password: _passwordFieldController.text,
          newPassword: _newController.text));
    }

    _passwordFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == StateStatus.success) {
          CommonToast.showStatusToast(context, "Password updated sucessfully");

          Navigator.pop(context);
        }
      },
      child: CustomSheet(
        showSaveButton: true,
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
            CommonTextFieldSection(
              items: [
                CommonCollapsedTextField(
                  label: "New",
                  hintText: "enter password",
                  controller: _newController,
                  isSecured: true,
                ),
                CommonCollapsedTextField(
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
      ),
    );
  }
}
