import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';
import 'package:taskmanager/modules/task/bloc/task_list/task_list.bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String username = "Quantum";
  final String email = "SampleE@gmail.com";
  final String password = "Super secured password";

  Widget _getSection({
    String? title,
    required Widget buttonTitle,
    void Function()? onPressed,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) Text(title.toUpperCase()),
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white70),
          ),
          child: buttonTitle,
        )
      ],
    );
  }

  void _onLogOut(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLogOut());
  }

  @override
  Widget build(BuildContext context) {
    return CommonTitleAppbar(
      title: const Text("Account"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _getSection(
              title: "Username",
              buttonTitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    username,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _getSection(
              title: "Email",
              buttonTitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    email,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Icon(Icons.chevron_right)
                ],
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _getSection(
              title: "Password",
              buttonTitle: const Text(
                "Change password",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            _getSection(
                buttonTitle: const Text(
                  "Log out",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () => _onLogOut(context))
          ],
        ),
      ),
    );
  }
}
