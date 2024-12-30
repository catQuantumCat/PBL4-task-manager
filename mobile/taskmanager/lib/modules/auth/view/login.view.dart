import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/bottomSheet/custom_sheet.dart';

import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/utils/validation.utils.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

import 'package:taskmanager/modules/auth/bloc/login/login_bloc.dart';
import 'package:taskmanager/common/helpers/dialog_helper.dart';
import 'package:taskmanager/modules/auth/widget/login_form.widget.dart';
import 'package:taskmanager/modules/auth/widget/common_filled_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void listenToStateChanges(BuildContext context, LoginState state) {
      if (state.status == LoginStatus.failed) {
        DialogHelper.showError(
          context,
          title: "Cannot sign in",
          content: state.errorString ?? "Unknown error",
        );
      }
    }

    return BlocProvider(
      create: (context) => LoginBloc(
          authBloc: context.read<AuthBloc>(),
          userRepository: getIt<UserRepository>()),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) => listenToStateChanges(context, state),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isValidated = false;

  final TextEditingController _usernameFieldController =
      TextEditingController();

  final TextEditingController _passwordFieldController =
      TextEditingController();

  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _validate() {
    final usernameValidate =
        ValidationUtils.validateField(_usernameFieldController.text);
    final passwordValidate =
        ValidationUtils.validateField(_passwordFieldController.text);

    setState(() {
      _isValidated = (usernameValidate == null && passwordValidate == null);
    });
  }

  void _onLoginTapped(BuildContext context) {
    if (_isValidated == false) {
      DialogHelper.showError(context,
          title: "Cannot log in", content: "Fields must not be empty");
      return;
    }

    context.read<LoginBloc>().add(LoginSubmitTapped(
          username: _usernameFieldController.text,
          password: _passwordFieldController.text,
        ));
  }

  @override
  void initState() {
    _usernameFieldController.addListener(_validate);
    _passwordFieldController.addListener(_validate);
    super.initState();
  }

  @override
  void dispose() {
    _usernameFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.failed) {
          _usernameFieldController.clear();
          _passwordFieldController.clear();
        }
      },
      builder: (context, state) {
        return BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return CustomSheet(
              showCancelButton: true,
              onCancel: () => Navigator.pop(context),
              backgroundColor: context.palette.scaffoldBackgroundDim,
              body: SingleChildScrollView(
                child: Builder(
                  builder: (_) {
                    switch (state.status) {
                      case (LoginStatus.loading):
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      default:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Login",
                                style: context.appTextStyles.heading2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Add your username and password.",
                                style: context.appTextStyles.body1,
                              ),
                            ),
                            const SizedBox(height: 28),
                            LoginForm(
                              // formkey: _formkey,
                              usernameFieldController: _usernameFieldController,
                              passwordFieldController: _passwordFieldController,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CommonFilledButton(
                                    label: "Log in",
                                    onPressed: _isValidated
                                        ? () => _onLoginTapped(context)
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
