import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

abstract class CommonToast {
  static late FToast fToast;

  static void initToast(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
  }

  static showStatusToast(BuildContext context, String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.TOP,
        textColor: context.palette.normalText,
        backgroundColor: context.palette.scaffoldBackground);
  }

  static clearToast() {
    fToast.removeCustomToast();
  }

  static showUndoToast(BuildContext context, void Function() onUndoTapped) {
    fToast.removeCustomToast();

    fToast.showToast(
        isDismissable: true,
        child: UndoToast(
          onUndoTapped: () {
            onUndoTapped.call();
            fToast.removeCustomToast();
          },
        ),
        toastDuration: const Duration(seconds: 3),
        positionedToastBuilder: (navigatorContext, child) => Positioned(
              left: UIConstant.padding,
              bottom:
                  UIConstant.bottomNavBarHeight + kFloatingActionButtonMargin,
              child: child,
            ));
  }
}

class UndoToast extends StatelessWidget {
  const UndoToast({super.key, required void Function() onUndoTapped})
      : _onUndoTapped = onUndoTapped;

  final void Function() _onUndoTapped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium),
      onTap: () => _onUndoTapped(),
      child: Container(
          width: MediaQuery.sizeOf(context).width * 0.6,
          padding:
              EdgeInsets.symmetric(vertical: 8, horizontal: UIConstant.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium),
            border: Border.all(color: context.palette.divider, width: 2),
            color: context.palette.scaffoldBackground,
          ),
          child: Row(
            children: [
              Icon(Icons.undo, color: context.palette.primaryColor),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Undo",
                      style: context.appTextStyles.subHeading2
                          .copyWith(color: context.palette.primaryColor)),
                  Text(
                    "Completed",
                    style: context.appTextStyles.metadata1,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
