import 'package:flutter/material.dart';
import 'package:taskmanager/common/context_extension.dart';
import 'package:taskmanager/common/widget/common_title_appbar.widget.dart';

class SearchFailedWidget extends StatelessWidget {
  const SearchFailedWidget({super.key, required String query}) : _query = query;

  final String _query;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(image: AssetImage("assets/search.png")),
        const SizedBox(
          height: 20,
        ),
        Text(
          _query,
          textAlign: TextAlign.center,
          style: context.appTextStyles.subHeading2,
        ),
      ],
    );
  }
}
