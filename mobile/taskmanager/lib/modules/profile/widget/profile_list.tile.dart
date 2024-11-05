import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {super.key, this.title, required this.buttonTitle, this.onPressed});

  final String? title;
  final Widget buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) Text(title!.toUpperCase()),
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
}
