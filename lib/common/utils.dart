import 'package:flutter/material.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';

extension UpperCaseFirst on String {
  String get upperCaseFirst {
    return substring(0, 1).toUpperCase() + substring(1);
  }

  RichText get textWithBold {
    int lengthSubString = "'".allMatches(this).length;
    List<TextSpan> getList() {
      List<TextSpan> result = [];
      int index = 0;
      if (this[0] == "'") {
        lengthSubString = lengthSubString - 1;
      }
      for (int i = 0; i < lengthSubString + 1; i++) {
        result.add(
          TextSpan(
            text: substring(index,
                    i == lengthSubString ? length : indexOf("'", index + 1) + 1)
                .replaceAll("'", ""),
            style: StyleApp.s14().copyWith(
              color: Colors.black,
              fontWeight: this[0] == "'"
                  ? i % 2 == 0
                      ? FontWeight.w700
                      : FontWeight.w400
                  : i % 2 != 0
                      ? FontWeight.w700
                      : FontWeight.w400,
            ),
          ),
        );

        index = indexOf("'", index + 1) + 1;
      }
      return result;
    }

    return RichText(
      text: TextSpan(
        children: getList(),
      ),
    );
  }
}
