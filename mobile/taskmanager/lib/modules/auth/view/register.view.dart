import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/common/context_extension.dart';

import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:taskmanager/modules/auth/bloc/register/register_bloc.dart';
import 'package:taskmanager/common/helpers/dialog_helper.dart';
import 'package:taskmanager/modules/auth/widget/common_filled_button.dart';
import 'package:taskmanager/modules/auth/widget/register_form.widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _listenToStateChanges(BuildContext context, RegisterState state) {
    if (state.status == StateStatus.failed) {
      DialogHelper.showError(context,
          title: "Cannot register",
          content: state.errorString ?? "Unknown error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
          authBloc: context.read<AuthBloc>(),
          userRepository: getIt<UserRepository>()),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          _listenToStateChanges(context, state);
        },
        child: RegisterView(),
      ),
    );
  }
}

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();

  void _onRegisterTapped(BuildContext context) {
    if (!_formkey.currentState!.validate()) return;

    context.read<RegisterBloc>().add(
          SubmitRegisterTapped(
            email: _emailFieldController.text,
            username: _usernameFieldController.text,
            password: _passwordFieldController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      backgroundColor: context.palette.scaffoldBackgroundDim,
      body: SingleChildScrollView(
        child: Builder(builder: (context) {
          return BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state) {
              switch (state.status) {
                case (StateStatus.loading):
                  return const Center(child: CircularProgressIndicator());
                default:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Register",
                          style: context.appTextStyles.heading2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Add your username, email, and password.",
                          style: context.appTextStyles.body1,
                        ),
                      ),
                      const SizedBox(height: 28),
                      RegisterForm(
                        formkey: _formkey,
                        emailFieldController: _emailFieldController,
                        usernameFieldController: _usernameFieldController,
                        passwordFieldController: _passwordFieldController,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CommonFilledButton(
                              label: "Register",
                              onPressed: () => _onRegisterTapped(context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
              }
            },
          );
        }),
      ),
    );
  }
}
