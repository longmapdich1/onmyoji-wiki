import 'package:flutter/material.dart';

class ImageAssets {
  static const path = 'assets';
  static const pathSP = 'SP';
  static const pathSSR = 'SSR';
  static const pathSR = 'SR';
  static const pathR = 'R';
  static const pathN = 'N';

  static const icN ="$path/icN.png";
  static const icR ="$path/icR.png";
  static const icSR ="$path/icSR.png";
  static const icSSR ="$path/icSSR.png";
  static const icSP ="$path/icSP.png";

  static Image getAvtarByNameAndType(String name, String type){
    return pngAssets("$path/${type.toUpperCase()}/${name.toLowerCase()}/avatar.png");
  }

    static Image getFullImageByNameAndType(String name, String type) {
    return pngAssets(
        "$path/${type.toUpperCase()}/${name.toLowerCase()}/full.png");
  }

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
