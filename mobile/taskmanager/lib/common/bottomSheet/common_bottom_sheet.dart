import 'package:flutter/material.dart';

class CommonBottomSheet {
  static Future<dynamic> showBottomSheet(
      {required BuildContext context,
      double? heightRatio,
      bool isDismissible = true,
      required Widget Function(BuildContext) builder}) async {
    dynamic v = await showModalBottomSheet<dynamic>(
      constraints: BoxConstraints(
        maxHeight: heightRatio != null
            ? MediaQuery.of(context).size.height * heightRatio
            : double.infinity,
      ),
      isDismissible: isDismissible,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      isScrollControlled: true,
      enableDrag: isDismissible,
      context: context,
      builder: builder,
    );
    return v;
  }

  static Widget inputSheet(
      {void Function()? onCancel,
      void Function()? onSave,
      String? header,
      required Widget body}) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 6,
              width: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(horizontal: 4)),
                onPressed: onCancel,
                child: const Text("Cancel"),
              ),
            ),
            Text(header ?? ""),
            SizedBox(
              width: 60,
              child: TextButton(
                style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero),
                onPressed: onSave,
                child: const Text("Save"),
              ),
            )
          ],
        ),
        const SizedBox(height: 28),
        body
      ],
    );
  }
}
