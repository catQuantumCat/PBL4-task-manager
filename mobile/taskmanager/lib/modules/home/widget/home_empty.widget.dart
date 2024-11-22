import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';

class HomeEmptyWidget extends StatelessWidget {
  const HomeEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage("assets/empty_task.png"),
        ),
        const SizedBox(
          height: 40,
        ),
        Column(children: [
          Text("You're done for today!",
              style: context.appTextStyles.subHeading1),
          const SizedBox(
            height: 2,
          ),
          Text(
            "Enjoy the rest of your day.",
            style: context.appTextStyles.disabledSubHeading3,
          ),
        ]),
      ],
    );
  }
}
