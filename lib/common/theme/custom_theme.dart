import 'package:flutter/material.dart';
import 'package:onmyoji_wiki/common/theme/custom_colors.dart';

///Config ThemeData For DarkMode
ThemeData getTheme(BuildContext context) {
  final baseTheme = ThemeData.light();
  return baseTheme.copyWith(
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}

class DynamicTheme extends InheritedWidget {
  final BuildContext context;
  late final ThemeData themeData;
  late final CustomColor customColor;

  DynamicTheme(
    this.context, {
    Key? key,
    Widget? child,
  }) : super(key: key, child: child!) {
    themeData = getTheme(context);
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
