import 'package:flutter/material.dart';
import 'package:taskmanager/common/theme/palette.dart';
import 'package:taskmanager/common/theme/text_style.dart';

extension ContextExtension on BuildContext {
  Palette get palette => Theme.of(this).extension<Palette>()!;
  AppTextStyles get appTextStyles => Theme.of(this).extension<AppTextStyles>()!;
}
