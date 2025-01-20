import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CommonFilledButton extends StatelessWidget {
  const CommonFilledButton({super.key, required this.label, this.onPressed});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle().copyWith(
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(vertical: 12)),
        backgroundColor: onPressed != null
            ? WidgetStatePropertyAll<Color>(context.palette.primaryColor)
            : WidgetStatePropertyAll<Color>(
                context.palette.disabledButtonLabel),
        shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium),
        )),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: context.appTextStyles.subHeading2
            .copyWith(color: context.palette.onPrimary),
      ),
    );
  }
}
