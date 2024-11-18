import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/bottomSheet/sheet.constants.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:taskmanager/modules/profile/bloc/profile_bloc.dart';
import 'package:taskmanager/modules/profile/widget/edit/profile_email_edit.dart';
import 'package:taskmanager/modules/profile/widget/profile_field_group.widget.dart';

import 'package:taskmanager/modules/profile/widget/edit/profile_password_edit.dart';
import 'package:taskmanager/modules/profile/widget/edit/profile_username_edit.dart';
import 'package:taskmanager/modules/search/view/search.view.dart';

class ProfileSuccessWidget extends StatelessWidget {
  const ProfileSuccessWidget({super.key, required this.state});

  final ProfileState state;

  Future<void> _onUsernameTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.showBottomSheet(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        builder: (sheetContext) => const ProfileUsernameEdit());

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          username: v["username"], password: v["password"] ?? ""));
    }
  }

  Future<void> _onEmailTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.showBottomSheet(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        builder: (sheetContext) => const ProfileEmailEdit());

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(
          ProfileSetInfo(email: v["email"], password: v["password"] ?? ""));
    }
  }

  Future<void> _onPasswordTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.showBottomSheet(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        builder: (sheetContext) => const ProfilePasswordEdit());

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          newPassword: v["new_password"], password: v["password"] ?? ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        ProfileFieldGroup(
          groupLabel: "Username",
          items: [
            InkWell(
              onTap: () => _onUsernameTapped(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(state.userInfo?.username ?? "",
                      style: context.appTextStyles.buttonLabel),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ],
        ),
        ProfileFieldGroup(
          groupLabel: "Email",
          items: [
            InkWell(
              onTap: () => _onEmailTapped(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.userInfo?.email ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
            ),
          ],
        ),
        ProfileFieldGroup(
          groupLabel: "Password",
          items: [
            InkWell(
              onTap: () => _onPasswordTapped(context),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Change Password",
                  ),
                ],
              ),
            ),
          ],
        ),
        ProfileFieldGroup(
          items: [
            InkWell(
              onTap: () => context.read<AuthBloc>().add(const AuthLogOut()),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Log out",
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
