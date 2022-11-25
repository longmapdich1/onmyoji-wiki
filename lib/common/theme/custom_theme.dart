import 'package:flutter/material.dart';
import 'package:onmyoji_wiki/common/theme/custom_colors.dart';

///Config ThemeData For DarkMode
ThemeData _getThemeDataDark(BuildContext context) {
  final baseTheme = ThemeData.dark();
  return baseTheme.copyWith();
}

class DynamicTheme extends InheritedWidget {
  final BuildContext context;
  late ThemeData themeData;
  late CustomColor customColor;

  DynamicTheme(
    this.context, {
    Key? key,
    Widget? child,
  }) : super(key: key, child: child!) {
    themeData = _getThemeDataDark(context);
    customColor = CustomColor();
  }

  @override
  bool updateShouldNotify(DynamicTheme oldWidget) {
    return true;
  }

  static DynamicTheme of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<DynamicTheme>();
    if (theme == null) {
      throw Exception('Context not within CustomTheme');
    }
    return theme;
  }
}
