import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';

Future<T?> showCommonBottomSheet<T>(BuildContext context,
    {bool enableFloatBar = true,
    Widget? body,
    String? title,
    TextStyle? titleStyle,
    bool showCloseButton = false}) {
  final sheet = CommonBottomSheet(
    body: body,
    title: title,
    titleStyle: titleStyle,
    showCloseButton: showCloseButton,
  );
  return context.nativeSheet(sheet,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)));
}

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({
    Key? key,
    this.body,
    this.title,
    this.titleStyle,
    this.showCloseButton = false,
  }) : super(key: key);
  final Widget? body;
  final String? title;
  final TextStyle? titleStyle;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      visible: showCloseButton,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => context.pop(),
                          customBorder: const CircleBorder(),
                          child: Container(
                              alignment: Alignment.center,
                              width: 32.r,
                              height: 32.r,
                              child: const Icon(Icons.close)),
                        ),
                      ),
                    ),
                    Text(title ?? "", style: titleStyle ?? StyleApp.s20(true)),
                    SizedBox(width: 32.r, height: 32.r),
                  ],
                ),
              ),
              body ?? const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
