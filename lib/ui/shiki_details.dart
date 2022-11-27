import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/widgets/list_info_item.dart';
import 'package:onmyoji_wiki/models/shiki.dart';

class ShikiDetails extends StatefulWidget {
  const ShikiDetails({super.key, required this.shiki});
  final Shiki shiki;

  @override
  State<ShikiDetails> createState() => _ShikiDetailsState();
}

class _ShikiDetailsState extends State<ShikiDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ImageAssets.getFullImageByNameAndType(
                widget.shiki.name, widget.shiki.type.name),
            Text(
              widget.shiki.name,
              style: StyleApp.s36(),
            ),
            TabBar(
              tabs: [
                Tab(text: "Chỉ số"),
                Tab(text: "Kỹ năng"),
              ],
              controller: _tabController,
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStatTab(),
                  _buildSkillTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillTab() {
    return Container();
  }

  ListInfo _buildStatTab() {
    return ListInfo(list: [
      ListInfoItem(
          title: "ATK (Tấn công): ",
          content: widget.shiki.stat.attack.toString()),
      ListInfoItem(
          title: "HP (Máu): ", content: widget.shiki.stat.hp.toString()),
      ListInfoItem(
          title: "DEF (Thủ): ", content: widget.shiki.stat.def.toString()),
      ListInfoItem(
          title: "SPD (Tốc): ", content: widget.shiki.stat.spd.toString()),
      ListInfoItem(
          title: "CRIT (Tỉ lệ chí mạng): ",
          content: "${widget.shiki.stat.crit.toInt()}%"),
      ListInfoItem(
          title: "CRIT DMG (Sát thương chí mạng): ",
          content: "${widget.shiki.stat.critDame.toInt()}%"),
      ListInfoItem(
          title: "EFFECT HIT (Tỉ lệ chính xác): ",
          content: "${widget.shiki.stat.effectHit.toInt()}%"),
      ListInfoItem(
          title: "EFFECT RES (Tỉ lệ kháng): ",
          content: "${widget.shiki.stat.effectRes.toInt()}%"),
    ]);
  }
}
