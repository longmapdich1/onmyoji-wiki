import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StyleApp {
  static Color getShimmerColor() {
    return Colors.grey;
  }

  static TextStyle s14([bool isBold = false]) {
    FontWeight weight = FontWeight.w400;
    if (isBold) {
      weight = FontWeight.w500;
    }
    return TextStyle(
      fontSize: 14.sp,
      fontWeight: weight,
      height: (20 / 14).sp,
    );
  }

  static TextStyle s16([bool isBold = false]) {
    FontWeight weight = FontWeight.w400;
    if (isBold) {
      weight = FontWeight.w500;
    }
    return TextStyle(
      fontSize: 16.sp,
      fontWeight: weight,
      height: (20 / 16).sp,
      fontFamily: "Game",
    );
  }

  static TextStyle s12([bool isBold = false]) {
    FontWeight weight = FontWeight.w400;
    if (isBold) {
      weight = FontWeight.w500;
    }
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: weight,
      height: (16 / 12).sp,
    );
  }

  static TextStyle s20([bool isBold = false]) {
    FontWeight weight = FontWeight.w400;
    if (isBold) {
      weight = FontWeight.w500;
    }
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: weight,
      height: (28 / 20).sp,
    );
  }

  static TextStyle s36([bool isBold = false]) {
    FontWeight weight = FontWeight.w400;
    if (isBold) {
      weight = FontWeight.w500;
    }
    return TextStyle(
      fontSize: 36.sp,
      fontWeight: weight,
      height: (40 / 36).sp,
    );
  }
}
