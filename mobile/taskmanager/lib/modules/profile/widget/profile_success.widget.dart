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

class ProfileSuccessWidget extends StatelessWidget {
  const ProfileSuccessWidget({super.key});

  Future<void> _onEmailTapped(BuildContext context) async {
    await CommonBottomSheet.show(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        child: BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: const ProfileEmailEdit(),
        ));
  }

  Future<void> _onPasswordTapped(BuildContext context) async {
    await CommonBottomSheet.show(
        context: context,
        isDismissible: false,
        heightRatio: SheetConstants.maxHeight,
        child: BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: const ProfilePasswordEdit(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 16),
        CommonTextFieldSection(
          groupLabel: "Email",
          items: [
            InkWell(
              onTap: () => _onEmailTapped(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.read<ProfileBloc>().state.userInfo?.email ?? "",
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
                    "Change Password",
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
    );
  }
}
