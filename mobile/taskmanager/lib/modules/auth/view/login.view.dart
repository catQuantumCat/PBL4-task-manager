import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskmanager/modules/auth/bloc/login/login_bloc.dart';
import 'package:taskmanager/modules/auth/widget/login_form.widget.dart';
import 'package:taskmanager/modules/auth/widget/auth_elevated_button.widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void _onLoginTapped(BuildContext context) {
    if (!_formkey.currentState!.validate()) return;

    context.read<LoginBloc>().add(LoginSubmitTapped(
          username: _usernameFieldController.text,
          password: _passwordFieldController.text,
        ));
  }

  void _onNavigateToRegisterTapped(BuildContext context) {
    Navigator.pushNamed(context, '/authRegister');
  }

  void _listenToStateChanges(BuildContext context, LoginState state) {
    if (state.status == LoginStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (route) => false,
      );
    }

    if (state.status == LoginStatus.failed) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Try again"))
          ],
          title: const Text("Cannot sign in"),
          content: Text(state.errorString ?? "Unknown error"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) => _listenToStateChanges(context, state),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Builder(
            builder: (_) {
              switch (state.status) {
                case (LoginStatus.loading):
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Add your username and password.",
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          LoginForm(
                            formkey: _formkey,
                            usernameFieldController: _usernameFieldController,
                            passwordFieldController: _passwordFieldController,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: AuthElevatedButton(
                                  label: "Log in",
                                  onPressed: () => _onLoginTapped(context),
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: TextButton(
                              child: const Text("New here? Register now!"),
                              onPressed: () =>
                                  _onNavigateToRegisterTapped(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
        );
      },
    );
  }
}
