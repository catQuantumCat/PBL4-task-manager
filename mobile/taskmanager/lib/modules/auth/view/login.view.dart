import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/modules/auth/bloc/login/login_bloc.dart';

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

  void _onLoginTapped(BuildContext context) {
    context.read<LoginBloc>().add(LoginSubmitTapped(
          username: _usernameFieldController.text,
          password: _passwordFieldController.text,
        ));
  }

  Widget authTextFormField(
      {String? hintText,
      bool obscureText = false,
      TextEditingController? controller,
      FormFieldValidator? validator}) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        filled: true,
        fillColor: Colors.grey[300],
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget authElevatedButton(
      {required String label, void Function()? onPressed}) {
    return ElevatedButton(
      style: const ButtonStyle().copyWith(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: const WidgetStatePropertyAll(Colors.redAccent),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          label,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        log("HERE");
        if (state.status == LoginStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/home",
            (route) => false,
          );
        }
      },
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
                          Form(
                            child: Column(
                              children: [
                                authTextFormField(
                                    hintText: "Username",
                                    controller: _usernameFieldController),
                                const SizedBox(height: 16),
                                authTextFormField(
                                    hintText: "Password",
                                    obscureText: true,
                                    controller: _passwordFieldController),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(
                                      child: authElevatedButton(
                                        label: "Log in",
                                        onPressed: () =>
                                            _onLoginTapped(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
