import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/utils.dart';
import 'package:onmyoji_wiki/common/widgets/list_stagger.dart';
import 'package:onmyoji_wiki/common/widgets/search_bar.dart';
import 'package:onmyoji_wiki/models/shiki.dart';
import 'package:onmyoji_wiki/ui/shiki_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;

  late List<Shiki> _shiki;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImageAssets.imageWallpaper), fit: BoxFit.fill),
      ),
      child: FutureBuilder<List<Shiki>>(
          future: _getListShiki(),
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            _shiki = snapshot.data!;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 12.h,
                      top: MediaQuery.of(context).viewPadding.top + 12.h),
                  child: Text(
                    "Thức thần lục",
                    style: StyleApp.s36(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const SearchBar(),
                ),
                SizedBox(height: 12.h),
                TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  controller: _controller,
                  tabs: [
                    Tab(child: ImageAssets.pngAssets(ImageAssets.icSP)),
                    Tab(child: ImageAssets.pngAssets(ImageAssets.icSSR)),
                    Tab(child: ImageAssets.pngAssets(ImageAssets.icSR)),
                    Tab(child: ImageAssets.pngAssets(ImageAssets.icR)),
                    Tab(child: ImageAssets.pngAssets(ImageAssets.icN)),
                  ],
                ),
                Expanded(
                  child: TabBarView(controller: _controller, children: [
                    _buildTabView(ShikiType.sp),
                    _buildTabView(ShikiType.ssr),
                    _buildTabView(ShikiType.sr),
                    _buildTabView(ShikiType.r),
                    _buildTabView(ShikiType.n),
                  ]),
                ),
              ],
            );
          }),
    ));
  }

  Widget _buildTabView(ShikiType type) {
    List<Shiki> tempList =
        _shiki.where((element) => element.type == type).toList();
    return ListStagger<Shiki>(
      list: tempList,
      itemWidget: _buildShikiItem,
    );
  }

  Widget _buildShikiItem(Shiki shiki) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            navigateTo(
              context,
              ShikiDetails(shiki: shiki),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2)),
            child: Row(
              children: [
                ClipOval(
                  child: SizedBox(
                    height: 64.sp,
                    child: ImageAssets.getAvatarByNameAndType(
                        shiki.name, shiki.type.name),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  shiki.name.upperCaseFirst,
                  style: StyleApp.s20(true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Shiki>> _getListShiki() async {
    Set<Shiki> list = {};
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final List images = json
        .decode(manifestJson)
        .keys
        .where((String key) =>
            key.startsWith('assets/') && !key.contains("images") && !key.contains("font"))
        .toList();
    List<String> alreadyShiki = [];
    for (var element in images) {
      var tempElement = element.toString().split("/");
      tempElement.removeLast();

      final name = element.toString().split("/")[2];
      if (alreadyShiki.contains(name)) continue;
      final type = ShikiType.values
          .byName(element.toString().split("/")[1].toLowerCase());
      String skillPath =
          await rootBundle.loadString("${tempElement.join("/")}/skill.json");
      String statPath =
          await rootBundle.loadString("${tempElement.join("/")}/stat.json");

      Stat tempStat = Stat.fromJson(jsonDecode(statPath));
      final tempShiki = Shiki(
          id: "${name}1",
          name: name,
          skills: Shiki.getListSkill(jsonDecode(skillPath)),
          stat: tempStat,
          type: type,
          stories: []);
      list.add(tempShiki);
      alreadyShiki.add(name);
    }
    return list.toList();
  }
}
