import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonErrorPage extends StatelessWidget {
  const CommonErrorPage(
      {super.key, required void Function() onReloadTap, String? errorMessage})
      : _onReloadTap = onReloadTap,
        _errorMessage = errorMessage ?? "Something went wrong";

  final void Function() _onReloadTap;

  final String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(image: AssetImage("assets/error.png")),
        const SizedBox(height: 32),
        Column(
          children: [
            Text("Uh oh! Something isn't right.",
                style: context.appTextStyles.heading2),
            const SizedBox(height: 4),
            Text(_errorMessage,
                style: context.appTextStyles.disabledSubHeading2),
          ],
        ),
        const SizedBox(height: 64),
        OutlinedButton.icon(
          onPressed: () => _onReloadTap(),
          label: const Text("Try again"),
          icon: const Icon(Icons.replay_outlined),
        )
      ],
    );
  }
}
