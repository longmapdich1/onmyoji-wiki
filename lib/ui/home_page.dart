import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;

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
          Container(
            color: Colors.grey,
            child: TabBar(
              controller: _controller,
              tabs: const [
                Tab(text: "SP"),
                Tab(text: "SSR"),
                Tab(text: "SR"),
                Tab(text: "R"),
                Tab(text: "N"),
              ],
            ),
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
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: Row(
            children: [
              const CircleAvatar(),
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
