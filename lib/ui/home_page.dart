import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
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

  final Shiki _shiki = Shiki(
      id: "id1",
      name: "Kiyohime",
      skills: [],
      stat: Stat(
          attack: 144,
          def: 68,
          hp: 1128,
          spd: 118,
          effectHit: 0,
          effectRes: 0,
          crit: 3,
          critDame: 150),
      type: ShikiType.sp,
      stories: []);

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(56), color: Colors.red),
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
              _buildTabSP(),
              _buildTabSSR(),
              _buildTabSR(),
              _buildTabR(),
              _buildTabN(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSP() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(20, (index) => _buildShikiItem()),
      ),
    );
  }

  Widget _buildShikiItem() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          go(
            context,
            ShikiDetails(shiki: _shiki),
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
                      _shiki.name, _shiki.type.name),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                "Kiyohime SP (Thanh cơ SP)",
                style: StyleApp.s16(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabSSR() {
    return Container();
  }

  Widget _buildTabSR() {
    return Container();
  }

  Widget _buildTabR() {
    return Container();
  }

  Widget _buildTabN() {
    return Container();
  }
}
