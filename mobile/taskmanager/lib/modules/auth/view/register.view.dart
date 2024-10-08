import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/constants/state_status.constant.dart';
import 'package:taskmanager/modules/auth/bloc/register/register_bloc.dart';
import 'package:taskmanager/modules/auth/widget/auth_elevated_button.widget.dart';
import 'package:taskmanager/modules/auth/widget/register_form.widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: RegisterView(),
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

  void _listenToStateChanges(BuildContext context, RegisterState state) {
    if (state.status == StateStatus.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/home",
        (route) => false,
      );
    }

    if (state.status == StateStatus.failed) {
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Try again"))
          ],
          title: const Text("Cannot register"),
          content: Text(state.errorString ?? "Unknown error"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        return BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            _listenToStateChanges(context, state);
          },
          builder: (context, state) {
            switch (state.status) {
              case (StateStatus.loading):
                return const Center(child: CircularProgressIndicator());
              default:
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Add your username, email, and password.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        RegisterForm(
                          formkey: _formkey,
                          emailFieldController: _emailFieldController,
                          usernameFieldController: _usernameFieldController,
                          passwordFieldController: _passwordFieldController,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AuthElevatedButton(
                                label: "Register",
                                onPressed: () => _onRegisterTapped(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        );
      }),
    );
  }
}
