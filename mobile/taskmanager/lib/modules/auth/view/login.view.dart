import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  Widget authTextFormField(
      {String? hintText,
      bool obscureText = false,
      FormFieldValidator? validator}) {
    return TextFormField(
      obscureText: obscureText,
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

  Widget authElevatedButton({required String label}) {
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
      onPressed: () {},
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
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Add your email and password.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Form(
                child: Column(
                  children: [
                    authTextFormField(hintText: "Email"),
                    const SizedBox(height: 16),
                    authTextFormField(hintText: "Password", obscureText: true),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: authElevatedButton(label: "Log in"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
