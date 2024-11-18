import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CustomSheet extends StatelessWidget {
  const CustomSheet(
      {super.key,
      required Widget body,
      String? header,
      bool showHandle = true,
      bool enableControl = false,
      void Function()? onCancel,
      void Function()? onSave,
      Color backgroundColor = Colors.white})
      : _body = body,
        _header = header,
        _showHandle = showHandle,
        _enableControl = enableControl,
        _onCancel = onCancel,
        _onSave = onSave,
        _backgroundColor = backgroundColor;

  final void Function()? _onCancel;
  final void Function()? _onSave;
  final Widget _body;
  final String? _header;
  final Color _backgroundColor;
  final bool _showHandle;
  final bool _enableControl;

  @override
  Widget build(BuildContext context) {
    if (_enableControl == false && (_onCancel != null || _onSave != null)) {
      throw Exception('Control is disabled but onCancel or onSave is provided');
    }

    return Container(
      decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium)),
      child: ListView(
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
                decoration: _showHandle
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      )
                    : null,
              ),
            ],
          ),
          if (_enableControl)
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
                    onPressed: _onCancel,
                    child: const Text("Cancel"),
                  ),
                ),
                Text(
                  _header ?? "",
                  style: context.appTextStyles.subHeading2,
                ),
                SizedBox(
                  width: 60,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.zero),
                    onPressed: _onSave,
                    child: const Text("Save"),
                  ),
                )
              ],
            ),
          if (_enableControl) const SizedBox(height: 28),
          _body
        ],
      ),
    );
  }
}
