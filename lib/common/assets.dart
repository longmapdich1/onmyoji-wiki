import 'package:flutter/material.dart';

class ImageAssets {
  static const path = 'assets/';

  static Image pngAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      name,
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
