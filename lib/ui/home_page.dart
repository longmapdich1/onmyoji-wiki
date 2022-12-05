import 'dart:convert';
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
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;
  final supabase = Supabase.instance.client;
  List<Shiki> _shiki = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    supabase.dispose();
    super.dispose();
  }

  Future<List<Shiki>> _fetchData() async {
    List<Shiki> result = [];
    final dataShiki = await supabase.from('Shiki').select<PostgrestList>('''
      id,name,type,image
''');
    for (var element in dataShiki) {
      result.add(
        Shiki(
          id: element['id'],
          name: element['name'],
          image: element['image'],
          type:
              ShikiType.values.firstWhere((e) => e.fromJson == element['type']),
        ),
      );
    }
    return result;
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
          future: _fetchData(),
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state != null) {
              _shiki = snapshot.data!;
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 12.h,
                      top: MediaQuery.of(context).viewPadding.top + 12.h),
                  child: Text(
                    "Thức thần lục",
                    style: StyleApp.s28(),
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
                SizedBox(height: 4.h),
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
    List<Shiki> tempList = [];
    if (_shiki.isNotEmpty) {
      tempList = _shiki.where((element) => element.type == type).toList();
    }

    return _shiki.isNotEmpty
        ? ListStagger<Shiki>(
            list: tempList,
            itemWidget: _buildShikiItem,
          )
        : _buildShimmerItem();
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
              10,
              (_) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.2)),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              color: Colors.white.withOpacity(0.3),
                              height: 64.sp,
                              width: 64.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Container(
                              height: 12.0,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
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
              ShikiDetails(shikiId: shiki.id),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.2)),
            child: Row(
              children: [
                if (shiki.image != null)
                  ClipOval(
                    child: SizedBox(
                      height: 64.sp,
                      child: Image.memory(
                        base64Decode(shiki.image!),
                      ),
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
}
