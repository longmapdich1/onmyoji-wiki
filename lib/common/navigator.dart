import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> go<T extends Object>(BuildContext context, Widget page,
    {bool cuper = true}) {
  if (cuper) {
    return Navigator.push(
        context, CupertinoPageRoute(builder: (context) => page));
  }
  return Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}
