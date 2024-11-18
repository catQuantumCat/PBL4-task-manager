import 'package:flutter/material.dart';
import 'package:taskmanager/common/theme/palette.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_template/common/theme/palette.dart';
// import 'package:flutter_template/generated/fonts.gen.dart';

extension on TextStyle {
  TextStyle get w3 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w4 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w5 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w6 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w7 => copyWith(fontWeight: FontWeight.w700);
}

class Fonts {
  static const String fontFamily = 'Roboto';
  static const TextStyle _defaultTextStyle = TextStyle(fontFamily: fontFamily);

  static final TextStyle s10w4 = _defaultTextStyle.copyWith(fontSize: 10).w4;
  static final TextStyle s10w6 = _defaultTextStyle.copyWith(fontSize: 10).w6;
  static final TextStyle s13w4 = _defaultTextStyle.copyWith(fontSize: 13).w4;
  static final TextStyle s14w4 = _defaultTextStyle.copyWith(fontSize: 14).w4;
  static final TextStyle s14w6 = _defaultTextStyle.copyWith(fontSize: 14).w6;
  static final TextStyle s16w4 = _defaultTextStyle.copyWith(fontSize: 16).w4;
  static final TextStyle s16w6 = _defaultTextStyle.copyWith(fontSize: 16).w6;
  static final TextStyle s20w7 = _defaultTextStyle.copyWith(fontSize: 20).w7;
  static final TextStyle s24w7 = _defaultTextStyle.copyWith(fontSize: 24).w7;
  static final TextStyle s32w7 = _defaultTextStyle.copyWith(fontSize: 32).w7;
}

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle subHeading1;
  final TextStyle subHeading2;
  final TextStyle subHeading3;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle metadata1;
  final TextStyle metadata2;
  final TextStyle metadata3;

  final TextStyle errorButtonLabel;

  final TextStyle buttonLabel;

  final TextStyle textFieldLabel;
  final TextStyle textField;
  final TextStyle hintTextField;
  final TextStyle errorTextField;
  final TextStyle helperTexField;

  final TextStyle strikedBody1;

  final TextStyle disabledHeading1;
  final TextStyle disabledHeading2;

  final TextStyle disabledSubHeading1;
  final TextStyle disabledsubHeading2;

  final TextStyle strikedSubHeading1;
  final TextStyle strikedSubHeading2;

  const AppTextStyles({
    required this.heading1,
    required this.heading2,
    required this.subHeading1,
    required this.subHeading2,
    required this.subHeading3,
    required this.body1,
    required this.body2,
    required this.metadata1,
    required this.metadata2,
    required this.metadata3,
    required this.errorButtonLabel,
    required this.buttonLabel,
    required this.textFieldLabel,
    required this.textField,
    required this.hintTextField,
    required this.errorTextField,
    required this.helperTexField,
    required this.strikedBody1,
    required this.disabledHeading1,
    required this.disabledHeading2,
    required this.disabledSubHeading1,
    required this.disabledsubHeading2,
    required this.strikedSubHeading1,
    required this.strikedSubHeading2,
  });

  factory AppTextStyles.fromPalette(Palette palette) {
    return AppTextStyles(
      heading1: Fonts.s32w7.copyWith(color: palette.normalText),
      heading2: Fonts.s24w7.copyWith(color: palette.normalText),
      subHeading1: Fonts.s20w7.copyWith(color: palette.normalText),
      subHeading2: Fonts.s16w6.copyWith(color: palette.normalText),
      subHeading3: Fonts.s14w6.copyWith(color: palette.normalText),
      body1: Fonts.s16w4.copyWith(color: palette.normalText),
      body2: Fonts.s14w4.copyWith(color: palette.normalText),
      metadata1: Fonts.s13w4.copyWith(color: palette.normalText),
      metadata2: Fonts.s10w4.copyWith(color: palette.normalText),
      metadata3: Fonts.s10w6.copyWith(color: palette.normalText),
      errorButtonLabel: Fonts.s14w6.copyWith(color: palette.errorButtonLabel),
      buttonLabel: Fonts.s14w6.copyWith(color: palette.normalText),
      textFieldLabel: Fonts.s14w6.copyWith(color: palette.normalText),
      textField: Fonts.s14w4.copyWith(color: palette.normalText),
      hintTextField: Fonts.s14w4.copyWith(color: palette.hintTextField),
      errorTextField: Fonts.s13w4.copyWith(color: palette.errorButtonLabel),
      helperTexField: Fonts.s13w4.copyWith(color: palette.normalText),
      strikedBody1: Fonts.s16w4.copyWith(
        color: palette.disabledButtonLabel,
        decoration: TextDecoration.lineThrough,
      ),
      disabledHeading1: Fonts.s32w7.copyWith(color: palette.disabledText),
      disabledHeading2: Fonts.s24w7.copyWith(color: palette.disabledText),
      disabledSubHeading1: Fonts.s20w7.copyWith(color: palette.disabledText),
      disabledsubHeading2: Fonts.s16w6.copyWith(color: palette.disabledText),
      strikedSubHeading1: Fonts.s20w7.copyWith(
        color: palette.disabledText,
        decoration: TextDecoration.lineThrough,
      ),
      strikedSubHeading2: Fonts.s16w4.copyWith(
        color: palette.disabledText,
        decoration: TextDecoration.lineThrough,
      ),
    );
  }

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? heading1,
    TextStyle? heading2,
    TextStyle? subHeading1,
    TextStyle? subHeading2,
    TextStyle? subHeading3,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? metadata1,
    TextStyle? metadata2,
    TextStyle? metadata3,
    TextStyle? errorButtonLabel,
    TextStyle? buttonLabel,
    TextStyle? textFieldLabel,
    TextStyle? textField,
    TextStyle? hintTextField,
    TextStyle? errorTextField,
    TextStyle? helperTexField,
    TextStyle? strikedBody1,
    TextStyle? disabledHeading1,
    TextStyle? disabledHeading2,
    TextStyle? disabledSubHeading1,
    TextStyle? disabledsubHeading2,
    TextStyle? strikedSubHeading1,
    TextStyle? strikedSubHeading2,
  }) {
    return AppTextStyles(
      heading1: heading1 ?? this.heading1,
      heading2: heading2 ?? this.heading2,
      subHeading1: subHeading1 ?? this.subHeading1,
      subHeading2: subHeading2 ?? this.subHeading2,
      subHeading3: subHeading3 ?? this.subHeading3,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      metadata1: metadata1 ?? this.metadata1,
      metadata2: metadata2 ?? this.metadata2,
      metadata3: metadata3 ?? this.metadata3,
      errorButtonLabel: errorButtonLabel ?? this.errorButtonLabel,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      textFieldLabel: textFieldLabel ?? this.textFieldLabel,
      textField: textField ?? this.textField,
      hintTextField: hintTextField ?? this.hintTextField,
      errorTextField: errorTextField ?? this.errorTextField,
      helperTexField: helperTexField ?? this.helperTexField,
      strikedBody1: strikedBody1 ?? this.strikedBody1,
      disabledHeading1: disabledHeading1 ?? this.disabledHeading1,
      disabledHeading2: disabledHeading2 ?? this.disabledHeading2,
      disabledSubHeading1: disabledSubHeading1 ?? this.disabledSubHeading1,
      disabledsubHeading2: disabledsubHeading2 ?? this.disabledsubHeading2,
      strikedSubHeading1: strikedSubHeading1 ?? this.strikedSubHeading1,
      strikedSubHeading2: strikedSubHeading2 ?? this.strikedSubHeading2,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
      covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles || identical(this, other)) {
      return this;
    }

    return AppTextStyles(
      heading1: TextStyle.lerp(heading1, other.heading1, t)!,
      heading2: TextStyle.lerp(heading2, other.heading2, t)!,
      subHeading1: TextStyle.lerp(subHeading1, other.subHeading1, t)!,
      subHeading2: TextStyle.lerp(subHeading2, other.subHeading2, t)!,
      subHeading3: TextStyle.lerp(subHeading3, other.subHeading3, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      metadata1: TextStyle.lerp(metadata1, other.metadata1, t)!,
      metadata2: TextStyle.lerp(metadata2, other.metadata2, t)!,
      metadata3: TextStyle.lerp(metadata3, other.metadata3, t)!,
      errorButtonLabel:
          TextStyle.lerp(errorButtonLabel, other.errorButtonLabel, t)!,
      buttonLabel: TextStyle.lerp(buttonLabel, other.buttonLabel, t)!,
      textFieldLabel: TextStyle.lerp(textFieldLabel, other.textFieldLabel, t)!,
      textField: TextStyle.lerp(textField, other.textField, t)!,
      hintTextField: TextStyle.lerp(hintTextField, other.hintTextField, t)!,
      errorTextField: TextStyle.lerp(errorTextField, other.errorTextField, t)!,
      helperTexField: TextStyle.lerp(helperTexField, other.helperTexField, t)!,
      strikedBody1: TextStyle.lerp(strikedBody1, other.strikedBody1, t)!,
      disabledHeading1:
          TextStyle.lerp(disabledHeading1, other.disabledHeading1, t)!,
      disabledHeading2:
          TextStyle.lerp(disabledHeading2, other.disabledHeading2, t)!,
      disabledSubHeading1:
          TextStyle.lerp(disabledSubHeading1, other.disabledSubHeading1, t)!,
      disabledsubHeading2:
          TextStyle.lerp(disabledsubHeading2, other.disabledsubHeading2, t)!,
      strikedSubHeading1:
          TextStyle.lerp(strikedSubHeading1, other.strikedSubHeading1, t)!,
      strikedSubHeading2:
          TextStyle.lerp(strikedSubHeading2, other.strikedSubHeading2, t)!,
    );
  }
}
