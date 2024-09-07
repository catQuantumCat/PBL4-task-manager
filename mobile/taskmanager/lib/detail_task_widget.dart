import 'package:flutter/material.dart';

class DetailTaskWidget extends StatelessWidget {
  const DetailTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) {
          return Container(
            color: Colors.blue,
          );
        });
  }
}
