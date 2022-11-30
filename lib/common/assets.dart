import 'package:flutter/material.dart';

class ImageAssets {
  static const path = 'assets';
  static const pathImages = 'images';
  static const pathSP = 'SP';
  static const pathSSR = 'SSR';
  static const pathSR = 'SR';
  static const pathR = 'R';
  static const pathN = 'N';

  static const icN = "$path/$pathImages/icN.png";
  static const icR = "$path/$pathImages/icR.png";
  static const icSR = "$path/$pathImages/icSR.png";
  static const icSSR = "$path/$pathImages/icSSR.png";
  static const icSP = "$path/$pathImages/icSP.png";
  static const soul = "$path/$pathImages/soul.png";
  static const imageWallpaper = "$path/$pathImages/wallpaper.jpg";
  static const imageWallpaper2 = "$path/$pathImages/wallpaper2.png";

  static Image getAvatarByNameAndType(String name, String type) {
    return pngAssets(
        "$path/${type.toUpperCase()}/${name.toLowerCase()}/avatar.png",
        fit: BoxFit.cover);
  }

  static String getAvatarPathByNameAndType(String name, String type) {
    return "$path/${type.toUpperCase()}/${name.toLowerCase()}/avatar.png";
  }

  static Image getFullImageByNameAndType(String name, String type) {
    return pngAssets(
        "$path/${type.toUpperCase()}/${name.toLowerCase()}/full.png",
        fit: BoxFit.cover);
  }

  static Image getSkillByNameTypeAndNumber(
      String name, String type, int number) {
    return pngAssets(
        "$path/${type.toUpperCase()}/${name.toLowerCase()}/skill$number.png",
        fit: BoxFit.cover);
  }

  static Image getBonusSkillByNameTypeAndNumber(
      String name, String type, int number) {
    return pngAssets(
        "$path/${type.toUpperCase()}/${name.toLowerCase()}/skillBonus$number.png",
        fit: BoxFit.cover);
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
