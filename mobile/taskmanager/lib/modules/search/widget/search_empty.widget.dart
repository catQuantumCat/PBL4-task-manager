import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class SearchFailedWidget extends StatelessWidget {
  const SearchFailedWidget({super.key, required String query}) : _query = query;

  final String _query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: UIConstant.padding),
      child: Column(
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
      ),
    );
  }
}
