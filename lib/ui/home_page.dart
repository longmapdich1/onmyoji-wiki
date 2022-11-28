import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/utils.dart';
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
      appBar: AppBar(),
      body: FutureBuilder<List<Shiki>>(
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
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(
                    "Onmyoji Wiki",
                    style: StyleApp.s36(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const SearchBar(),
                ),
                SizedBox(height: 12.h),
                TabBar(
                  indicatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
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
    );
  }

  Widget _buildTabView(ShikiType type) {
    List<Shiki> tempList =
        _shiki.where((element) => element.type == type).toList();
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            tempList.length, (index) => _buildShikiItem(tempList[index])),
      ),
    );
  }

  Widget _buildShikiItem(Shiki shiki) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          go(
            context,
            ShikiDetails(shiki: shiki),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(300.0),
                child: SizedBox(
                  height: 64.sp,
                  child: ImageAssets.getAvtarByNameAndType(
                      shiki.name, shiki.type.name),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                shiki.name.upperCaseFirst,
                style: StyleApp.s16(),
              ),
            ],
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
            key.startsWith('assets/') &&
            !key.contains("icN") &&
            !key.contains("icR") &&
            !key.contains("icSR") &&
            !key.contains("icSSR") &&
            !key.contains("icSP"))
        .toList();
    // String skill1 = await rootBundle.loadString("assets/SP/enma/skill1");
    // print(skill1);
    List<String> alreadyShiki = [];
    for (var element in images) {
      var tempElement = element.toString().split("/");
      tempElement.removeLast();

      final name = element.toString().split("/")[2];
      if (alreadyShiki.contains(name)) continue;
      final type = ShikiType.values
          .byName(element.toString().split("/")[1].toLowerCase());
      String skill1 =
          await rootBundle.loadString("${tempElement.join("/")}/skill1.txt");
      Skill tempSkill1 = Skill.fromJson(jsonDecode(skill1));
      final tempShiki = Shiki(
          id: "${name}1",
          name: name,
          skills: [tempSkill1],
          stat: Stat(
              attack: 144,
              def: 68,
              hp: 1128,
              spd: 118,
              effectHit: 0,
              effectRes: 0,
              crit: 3,
              critDame: 150),
          type: type,
          stories: []);
      list.add(tempShiki);
      alreadyShiki.add(name);
    }
    return list.toList();
  }
}
