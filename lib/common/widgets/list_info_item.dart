import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';

class ListInfoItem {
  final String title;
  final int maxLineContent;
  final String? content;
  final Widget? widget;
  ListInfoItem(
      {required this.title,
      this.content,
      this.widget,
      this.maxLineContent = 2}) {
    assert(content != null || widget != null);
    assert(content == null || widget == null);
  }
}

class ListInfo extends StatelessWidget {
  const ListInfo({Key? key, required this.list}) : super(key: key);

  final List<ListInfoItem> list;
  List<Widget> _getListWidget(BuildContext context, List<ListInfoItem> list) {
    List<Widget> listWidget = [];
    for (ListInfoItem item in list) {
      listWidget.add(
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.title,
                    style: StyleApp.s16(),
                  ),
                  SizedBox(width: 16.w),
                  item.content == null
                      ? item.widget!
                      : Expanded(
                          child: Text(
                            item.content!,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: item.maxLineContent,
                            style: StyleApp.s14(),
                          ),
                        ),
                ],
              ),
            ),
            Divider(height: 1.h, thickness: 1.h),
          ],
        ),
      );
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [..._getListWidget(context, list)],
      ),
    );
  }
}
