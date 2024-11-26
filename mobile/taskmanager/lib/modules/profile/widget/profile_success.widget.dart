import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/bottomSheet/sheet.constants.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:taskmanager/modules/profile/bloc/profile_bloc.dart';
import 'package:taskmanager/modules/profile/widget/edit/profile_email_edit.dart';
import 'package:taskmanager/common/widget/common_textfield_section.dart';

import 'package:taskmanager/modules/profile/widget/edit/profile_password_edit.dart';
import 'package:taskmanager/modules/profile/widget/edit/profile_username_edit.dart';

class ProfileSuccessWidget extends StatelessWidget {
  const ProfileSuccessWidget({super.key, required this.state});

  final ProfileState state;

  Future<void> _onUsernameTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.show(
      context: context,
      isDismissible: false,
      heightRatio: SheetConstants.maxHeight,
      child: const ProfileUsernameEdit(),
    );

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          username: v["username"], password: v["password"] ?? ""));
    }
  }

  Future<void> _onEmailTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.show(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        // builder: (sheetContext) => const ProfileEmailEdit(),
        child: const ProfileEmailEdit());

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(
          ProfileSetInfo(email: v["email"], password: v["password"] ?? ""));
    }
  }

  Future<void> _onPasswordTapped(BuildContext context) async {
    dynamic v = await CommonBottomSheet.show(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        // builder: (sheetContext) => const ProfilePasswordEdit(),
        child: const ProfilePasswordEdit());

    if (v is Map<String, String> && context.mounted) {
      context.read<ProfileBloc>().add(ProfileSetInfo(
          newPassword: v["new_password"], password: v["password"] ?? ""));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          const SizedBox(height: 16),
          CommonTextFieldSection(
            groupLabel: "Username",
            items: [
              InkWell(
                onTap: () => _onUsernameTapped(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.userInfo?.username ?? "",
                        style: context.appTextStyles.body2),
                    const Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ],
          ),
          CommonTextFieldSection(
            groupLabel: "Email",
            items: [
              InkWell(
                onTap: () => _onEmailTapped(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.userInfo?.email ?? "",
                      style: context.appTextStyles.body2,
                    ),
                    const Icon(Icons.chevron_right)
                  ],
                ),
              ),
            ],
          ),
          CommonTextFieldSection(
            groupLabel: "Password",
            items: [
              InkWell(
                onTap: () => _onPasswordTapped(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      " Change Password",
                      style: context.appTextStyles.body2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          CommonTextFieldSection(
            items: [
              InkWell(
                onTap: () => context.read<AuthBloc>().add(const AuthLogOut()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Log out",
                      style: context.appTextStyles.errorButtonLabel,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
