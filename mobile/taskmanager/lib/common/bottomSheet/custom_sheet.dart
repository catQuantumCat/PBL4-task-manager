import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/context_extension.dart';

class CustomSheet extends StatelessWidget {
  const CustomSheet(
      {super.key,
      required Widget body,
      String? header,
      bool showHandle = true,
      bool showCancelButton = true,
      bool showSaveButton = false,
      void Function()? onCancel,
      void Function()? onSave,
      Color backgroundColor = Colors.white})
      : assert(body is ScrollView || body is SingleChildScrollView, 'The body must be a ScrollView or SingleChildScrollView to ensure proper scrolling behavior.'),
        _body = body,
        _header = header,
        _showHandle = showHandle,
        _showSaveButton = showSaveButton,
        _showCancelButton = showCancelButton,
        _onCancel = onCancel,
        _onSave = onSave,
        _backgroundColor = backgroundColor;

  final void Function()? _onCancel;
  final void Function()? _onSave;
  final Widget _body;
  final String? _header;
  final Color _backgroundColor;
  final bool _showHandle;
  final bool _showCancelButton;
  final bool _showSaveButton;

  Widget _getHeader(BuildContext context) {
    return Container(
      color: _backgroundColor,
      child: Column(
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
          if (_showCancelButton || _showSaveButton)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 60,
                  child: _showCancelButton
                      ? TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4)),
                          onPressed:
                              _onCancel ?? () => Navigator.of(context).pop(),
                          child: const Text("Cancel"),
                        )
                      : null,
                ),
                Text(
                  _header ?? "",
                  style: context.appTextStyles.subHeading2,
                ),
                SizedBox(
                  width: 60,
                  child: _showSaveButton
                      ? TextButton(
                          style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.zero),
                          onPressed: _onSave,
                          child: const Text("Save"),
                        )
                      : null,
                )
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(UIConstant.padding, 0, UIConstant.padding,
          MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(UIConstant.cornerRadiusMedium)),
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          PinnedHeaderSliver(
            child: _getHeader(context),
          ),
          if (_showCancelButton || _showSaveButton)
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          SliverFillRemaining(
            child: _body,
          )
        ],
      ),
    );
  }
}
