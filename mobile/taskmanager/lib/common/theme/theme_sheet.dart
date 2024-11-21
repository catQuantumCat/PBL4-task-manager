import 'package:flutter/material.dart';
import 'package:taskmanager/common/constants/ui_constant.dart';
import 'package:taskmanager/common/theme/palette.dart';
import 'package:taskmanager/common/theme/text_style.dart';

class ThemeSheet {
  final ThemeData themeData;
  final Palette palette;
  final AppTextStyles appTextStyles;

  ThemeSheet({required this.palette, required this.appTextStyles})
      : themeData = ThemeData(
            colorSchemeSeed: palette.primaryColor,
            progressIndicatorTheme: ProgressIndicatorThemeData(
              color: palette.primaryColor,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: palette.scaffoldBackground,
            ),
            iconButtonTheme: const IconButtonThemeData(
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.all(4)),
              ),
            ),
            textButtonTheme: const TextButtonThemeData(
                style: ButtonStyle(
              visualDensity: VisualDensity.compact,
            )),
            popupMenuTheme: PopupMenuThemeData(
              color: palette.scaffoldBackground,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UIConstant.cornerRadiusWeak),
              ),
            ),
            scaffoldBackgroundColor: palette.scaffoldBackgroundDim,
            appBarTheme: AppBarTheme(color: palette.scaffoldBackground),
            brightness: palette.brightness,
            fontFamily: Fonts.fontFamily,
            dividerColor: palette.divider,
            outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
              side: WidgetStateProperty.all(
                  const BorderSide(width: 1, color: ColorPalette.gray100)),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )),
            buttonTheme: ButtonThemeData(
                buttonColor: palette.primaryColor,
                disabledColor: palette.disabledButtonLabel,
                splashColor: Colors.transparent),
            checkboxTheme: const CheckboxThemeData(
              shape: CircleBorder(),
              visualDensity: VisualDensity.compact,
            ),
            listTileTheme: ListTileThemeData(
              tileColor: palette.scaffoldBackground,
            ),
            extensions: [palette, appTextStyles]);
}
