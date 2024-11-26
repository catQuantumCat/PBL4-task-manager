import 'package:flutter/material.dart';
import 'package:taskmanager/common/bottomSheet/common_bottom_sheet.dart';

import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/modules/auth/view/login.view.dart';
import 'package:taskmanager/modules/auth/view/register.view.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WelcomeView();
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  void _onLoginTapped(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      child: const LoginPage(),
    );
  }

  void _onRegisterTapped(BuildContext context) {
    CommonBottomSheet.show(
      context: context,
      child: const RegisterPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.palette.scaffoldBackground,
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            UIConstant.padding, kToolbarHeight, UIConstant.padding, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/full_logo.png")),
            const SizedBox(
              height: 64,
            ),
            Column(
              children: [
                const Image(image: AssetImage("assets/welcome.png")),
                const SizedBox(height: 28),
                Text(
                  "Oranize your work \n and life, finally",
                  textAlign: TextAlign.center,
                  style: context.appTextStyles.heading1,
                ),
              ],
            ),
            const Spacer(),
            FilledButton(
                onPressed: () => _onLoginTapped(context),
                style: const ButtonStyle().copyWith(
                  padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12)),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      context.palette.primaryColor),
                ),
                child: Text(
                  "Login",
                  style: context.appTextStyles.subHeading2
                      .copyWith(color: context.palette.onPrimary),
                )),
            const SizedBox(
              height: 8,
            ),
            TextButton(
                onPressed: () => _onRegisterTapped(context),
                child: Text(
                  "Sign up",
                  style: context.appTextStyles.subHeading2
                      .copyWith(color: context.palette.primaryColor),
                ))
          ],
        ),
      ),
    );
  }
}
