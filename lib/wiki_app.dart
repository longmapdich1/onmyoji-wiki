import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/theme/custom_theme.dart';
import 'package:onmyoji_wiki/ui/home_page.dart';

class WikiApp extends StatelessWidget {
  const WikiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => DynamicTheme(
        context,
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: MaterialApp(
            theme: getTheme(context),
            title: "Onmyoji Wiki",
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          ),
        ),
      ),
    );
  }
}
