import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const Color primary = Color(0xFFDE483A);

  static const Color gray100 = Color(0xFFE6E6E6);
  static const Color gray200 = Color(0xFFCCCCCC);
  static const Color gray300 = Color(0xFFB3B3B3);
  static const Color gray400 = Color(0xFF999999);
  static const Color gray500 = Color(0xFF808080);
  static const Color gray600 = Color(0xFF666666);
  static const Color gray700 = Color(0xFF4D4D4D);
  static const Color black = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color beige = Color(0xFFFCFAF8);

  static const Color blueAccent = Color(0xFF266FE1);
  static const Color blueAccentLight = Color(0x26266FE1);
  static const Color yellowAccent = Color(0xFFEA8907);
  static const Color yellowAccentLight = Color(0x26EA8907);
  static const Color redAccent = Color(0xFFD2463D);
  static const Color redAccentLight = Color(0x26D2463D);
}

@immutable
class Palette extends ThemeExtension<Palette> {
  final Brightness brightness;

  final Color primaryColor;
  final Color onPrimary;
  final Color scaffoldBackgroundDim;
  final Color scaffoldBackground;
  final Color buttonForeground;
  final Color buttonBackground;
  final Color normalText;
  final Color disabledText;
  final Color textFieldBackground;
  final Color hintTextField;
  final Color errorButtonLabel;
  final Color disabledButtonLabel;
  final Color dialogBackground;
  final Color divider;
  final Color navigationBarBackground;

  final Color primary0;
  final Color primary1;
  final Color primary2;
  final Color primary3;

  final Color primaryLight0;
  final Color primaryLight1;
  final Color primaryLight2;
  final Color primaryLight3;

  const Palette({
    required this.primaryColor,
    required this.onPrimary,
    required this.brightness,
    required this.scaffoldBackgroundDim,
    required this.scaffoldBackground,
    required this.buttonBackground,
    required this.normalText,
    required this.textFieldBackground,
    required this.errorButtonLabel,
    required this.dialogBackground,
    required this.buttonForeground,
    this.hintTextField = const Color.fromARGB(255, 125, 125, 125),
    required this.disabledButtonLabel,
    required this.disabledText,
    required this.divider,
    required this.navigationBarBackground,
    required this.primary0,
    required this.primary1,
    required this.primary2,
    required this.primary3,
    required this.primaryLight0,
    required this.primaryLight1,
    required this.primaryLight2,
    required this.primaryLight3,
  });

  factory Palette.light() {
    return const Palette(
        primaryColor: ColorPalette.primary,
        onPrimary: Colors.white,
        brightness: Brightness.light,
        scaffoldBackgroundDim: Color(0xFFF2F2F2),
        scaffoldBackground: Colors.white,
        buttonBackground: ColorPalette.gray100,
        buttonForeground: ColorPalette.gray600,
        normalText: Color(0xFF0F1828),
        textFieldBackground: Color(0xFFF7F7FC),
        errorButtonLabel: Color(0xFFFF3333),
        dialogBackground: Color(0xFFFFFFFF),
        disabledButtonLabel: Colors.grey,
        disabledText: Colors.grey,
        divider: Color(0x22545456),
        navigationBarBackground: Color(0xFFFCFAF8),
        primary0: ColorPalette.gray600,
        primaryLight0: ColorPalette.black,
        primary1: ColorPalette.blueAccent,
        primaryLight1: ColorPalette.blueAccentLight,
        primary2: ColorPalette.yellowAccent,
        primaryLight2: ColorPalette.yellowAccentLight,
        primary3: ColorPalette.redAccent,
        primaryLight3: ColorPalette.redAccentLight);
  }

  Color getPriorityPrimary(int priorityIndex) {
    switch (priorityIndex) {
      case 0:
        return primary0;
      case 1:
        return primary1;
      case 2:
        return primary2;
      case 3:
        return primary3;
      default:
        return primary0;
    }
  }

  Color getPriorityLight(int priorityIndex) {
    switch (priorityIndex) {
      case 0:
        return primaryLight0;
      case 1:
        return primaryLight1;
      case 2:
        return primaryLight2;
      case 3:
        return primaryLight3;
      default:
        return primaryLight0;
    }
  }

  @override
  ThemeExtension<Palette> copyWith({
    Brightness? brightness,
    Color? primaryColor,
    Color? onPrimary,
    Color? scaffoldBackground,
    Color? onScaffoldBackground,
    Color? buttonForeground,
    Color? buttonBackground,
    Color? text,
    Color? textFieldBackground,
    Color? hintTextField,
    Color? errorButtonLabel,
    Color? dialogBackground,
    Color? focusedBorderColor,
    Color? disabledButtonLabel,
    Color? disabledText,
    Color? divider,
    Color? navigationBarBackground,
    Color? primary0,
    Color? primary1,
    Color? primary2,
    Color? primary3,
    Color? primaryLight0,
    Color? primaryLight1,
    Color? primaryLight2,
    Color? primaryLight3,
  }) {
    return Palette(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      onPrimary: onPrimary ?? this.onPrimary,
      scaffoldBackgroundDim: scaffoldBackground ?? this.scaffoldBackgroundDim,
      scaffoldBackground: onScaffoldBackground ?? this.scaffoldBackground,
      buttonBackground: buttonBackground ?? this.buttonBackground,
      buttonForeground: buttonForeground ?? this.buttonForeground,
      normalText: text ?? normalText,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      hintTextField: hintTextField ?? this.hintTextField,
      errorButtonLabel: errorButtonLabel ?? this.errorButtonLabel,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      disabledButtonLabel: disabledButtonLabel ?? this.disabledButtonLabel,
      disabledText: disabledText ?? this.disabledText,
      divider: divider ?? this.divider,
      navigationBarBackground:
          navigationBarBackground ?? this.navigationBarBackground,
      primary0: primary0 ?? this.primary0,
      primary1: primary1 ?? this.primary1,
      primary2: primary2 ?? this.primary2,
      primary3: primary3 ?? this.primary3,
      primaryLight0: primaryLight0 ?? this.primaryLight0,
      primaryLight1: primaryLight1 ?? this.primaryLight1,
      primaryLight2: primaryLight2 ?? this.primaryLight2,
      primaryLight3: primaryLight3 ?? this.primaryLight3,
    );
  }

  @override
  ThemeExtension<Palette> lerp(
      covariant ThemeExtension<Palette>? other, double t) {
    if (other is! Palette || identical(this, other)) {
      return this;
    }

    return Palette(
      brightness: brightness,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      scaffoldBackgroundDim:
          Color.lerp(scaffoldBackgroundDim, other.scaffoldBackgroundDim, t)!,
      scaffoldBackground:
          Color.lerp(scaffoldBackground, other.scaffoldBackground, t)!,
      buttonBackground:
          Color.lerp(buttonBackground, other.buttonBackground, t)!,
      buttonForeground:
          Color.lerp(buttonForeground, other.buttonForeground, t)!,
      normalText: Color.lerp(normalText, other.normalText, t)!,
      textFieldBackground:
          Color.lerp(textFieldBackground, other.textFieldBackground, t)!,
      hintTextField: Color.lerp(hintTextField, other.hintTextField, t)!,
      errorButtonLabel:
          Color.lerp(errorButtonLabel, other.errorButtonLabel, t)!,
      dialogBackground:
          Color.lerp(dialogBackground, other.dialogBackground, t)!,
      disabledButtonLabel:
          Color.lerp(disabledButtonLabel, other.disabledButtonLabel, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      navigationBarBackground: Color.lerp(
          navigationBarBackground, other.navigationBarBackground, t)!,
      primary0: Color.lerp(primary0, other.primary0, t)!,
      primary1: Color.lerp(primary1, other.primary1, t)!,
      primary2: Color.lerp(primary2, other.primary2, t)!,
      primary3: Color.lerp(primary3, other.primary3, t)!,
      primaryLight0: Color.lerp(primaryLight0, other.primaryLight0, t)!,
      primaryLight1: Color.lerp(primaryLight1, other.primaryLight1, t)!,
      primaryLight2: Color.lerp(primaryLight2, other.primaryLight2, t)!,
      primaryLight3: Color.lerp(primaryLight3, other.primaryLight3, t)!,
    );
  }
}
