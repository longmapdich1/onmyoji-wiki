import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Route<T> buildRoute<T>(
  Widget page, {
  TransitionType transitionType = TransitionType.native,
  RouteSettings? settings,
  Curve curve = Curves.ease,
  Duration duration = const Duration(milliseconds: 300),
  Duration reverseDuration = const Duration(milliseconds: 300),
  RouteTransitionsBuilder? customTransition,
  bool barrierDismissible = false,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool opaque = true,
  Color? barrierColor,
  String? barrierLabel,
}) {
  assert(transitionType != TransitionType.custom || customTransition != null);
  assert(customTransition == null || transitionType == TransitionType.custom);
  if (transitionType == TransitionType.native ||
      transitionType == TransitionType.material ||
      transitionType == TransitionType.cupertino ||
      transitionType == TransitionType.theme) {
    final useCupertino = Platform.isIOS ||
        Platform.isMacOS ||
        transitionType == TransitionType.cupertino;
    if (useCupertino) {
      return CupertinoPageRoute<T>(
        builder: (context) => page,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    }
    return MaterialPageRoute<T>(
      builder: (context) => page,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  }

  RouteTransitionsBuilder transitionsBuilder =
      customTransition ?? _buildTransition(transitionType, curve);

  return PageRouteBuilder<T>(
    opaque: opaque,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: duration,
    settings: settings,
    transitionsBuilder: transitionsBuilder,
    barrierDismissible: barrierDismissible,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
  );
}

RouteTransitionsBuilder _buildTransition(TransitionType transitionType,
    [Curve curve = Curves.ease]) {
  switch (transitionType) {
    case TransitionType.inFromLeft:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final tween =
            Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero);
        return SlideTransition(
          position:
              tween.animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      };
    case TransitionType.inFromRight:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final tween =
            Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
        return SlideTransition(
          position:
              tween.animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      };
    case TransitionType.inFromTop:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final tween =
            Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
        return SlideTransition(
          position:
              tween.animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      };
    case TransitionType.inFromBottom:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        final tween =
            Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
        return SlideTransition(
          position:
              tween.animate(CurvedAnimation(parent: animation, curve: curve)),
          child: child,
        );
      };
    case TransitionType.fadeIn:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      };
    case TransitionType.none:
      return (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return child;
      };
    case TransitionType.material:
    case TransitionType.cupertino:
    case TransitionType.native:
    case TransitionType.custom:
    case TransitionType.theme:
      throw UnimplementedError();
  }
}

enum BottomSheetType {
  material,
  cupertino,
  native,
}

enum TransitionType {
  inFromLeft,
  inFromRight,
  inFromTop,
  inFromBottom,
  fadeIn,
  material,
  cupertino,
  native,
  none,
  custom,
  theme,
}

Future<T?> showNativeSheet<T>(
  BuildContext context,
  Widget widget, {
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool bounce = false,
  bool expand = false,
  Curve? curve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  RouteSettings? settings,
  BottomSheetType bottomSheetType = BottomSheetType.native,
}) {
  final useCupertino = ((Platform.isIOS || Platform.isMacOS) &&
          bottomSheetType == BottomSheetType.native) ||
      bottomSheetType == BottomSheetType.cupertino;
  if (useCupertino) {
    return showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => widget,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      bounce: bounce,
      expand: expand,
      animationCurve: curve,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
      settings: settings,
    );
  }
  return showMaterialModalBottomSheet(
    context: context,
    builder: (context) => widget,
    backgroundColor: backgroundColor ?? Colors.transparent,
    elevation: elevation,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    bounce: bounce,
    expand: expand,
    animationCurve: curve,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    duration: duration,
    settings: settings,
  );
}

Future<T?> navigateTo<T>(
  BuildContext context,
  Widget page, {
  NavigatorState? navigatorState,
  TransitionType transitionType = TransitionType.native,
  RouteSettings? settings,
  Curve curve = Curves.ease,
  Duration duration = const Duration(milliseconds: 300),
  Duration reverseDuration = const Duration(milliseconds: 300),
  RouteTransitionsBuilder? customTransition,
  bool barrierDismissible = false,
  bool replace = false,
  bool clearStack = false,
  bool useRootNavigator = false,
  bool maintainState = true,
  bool fullscreenDialog = false,
  bool opaque = true,
  Color? barrierColor,
  String? barrierLabel,
}) async {
  final route = buildRoute<T>(
    page,
    opaque: opaque,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor,
    transitionType: transitionType,
    settings: settings,
    duration: duration,
    curve: curve,
    reverseDuration: reverseDuration,
    customTransition: customTransition,
    barrierDismissible: barrierDismissible,
  );
  final navigator =
      navigatorState ?? Navigator.of(context, rootNavigator: useRootNavigator);
  if (clearStack) {
    return navigator.pushAndRemoveUntil(route, (route) => false);
  }
  if (replace) {
    return navigator.pushReplacement(route);
  }
  return navigator.push(route);
}

extension NavigateExt on BuildContext {
  Future<T?> push<T>(
    Widget page, {
    NavigatorState? navigatorState,
    TransitionType transitionType = TransitionType.native,
    RouteSettings? settings,
    Curve curve = Curves.ease,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    RouteTransitionsBuilder? customTransition,
    bool barrierDismissible = false,
    bool replace = false,
    bool clearStack = false,
    bool useRootNavigator = false,
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool opaque = true,
    Color? barrierColor,
    String? barrierLabel,
  }) {
    return navigateTo(
      this,
      page,
      navigatorState: navigatorState,
      opaque: opaque,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      transitionType: transitionType,
      settings: settings,
      curve: curve,
      duration: duration,
      reverseDuration: reverseDuration,
      customTransition: customTransition,
      barrierDismissible: barrierDismissible,
      replace: replace,
      clearStack: clearStack,
      useRootNavigator: useRootNavigator,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  }

  void pop<T>({T? result, NavigatorState? navigatorState}) {
    final navigator = navigatorState ?? Navigator.of(this);
    return navigator.pop(result);
  }

  Future<T?> nativeSheet<T>(
    Widget widget, {
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool bounce = false,
    bool expand = false,
    Curve? curve,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Duration? duration,
    RouteSettings? settings,
    BottomSheetType bottomSheetType = BottomSheetType.native,
  }) {
    return showNativeSheet(
      this,
      widget,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      barrierColor: barrierColor,
      bounce: bounce,
      expand: expand,
      curve: curve,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
      settings: settings,
      bottomSheetType: bottomSheetType,
    );
  }
}
