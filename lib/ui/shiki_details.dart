import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/utils.dart';
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 200.sp,
            width: 200.sp,
            child: ImageAssets.getFullImageByNameAndType(
                widget.shiki.name, widget.shiki.type.name),
          ),
          Text(
            widget.shiki.name.upperCaseFirst,
            style: StyleApp.s36(),
          ),
          TabBar(
            labelStyle: StyleApp.s16(true),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 8.w),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: "Chỉ số"),
              Tab(text: "Kỹ năng"),
              Tab(text: "Truyện ký")
            ],
            controller: _tabController,
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStatTab(),
                  _buildSkillTab(),
                  _buildStoriesTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTab() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          widget.shiki.skills.length,
          (index) => _buildSkillItem(widget.shiki.skills[index]),
        ),
      ),
    );
  }

  Widget _buildSkillItem(Skill skill) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(),
          SizedBox(width: 8.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  skill.name,
                  style: StyleApp.s16(true),
                ),
                SizedBox(height: 4.h),
                Text(skill.describe),
                if (skill.levelUp != null) ...[
                  SizedBox(height: 4.h),
                  ...List.generate(
                    skill.levelUp!.length,
                    (index) =>
                        Text("Level ${index + 2}: ${skill.levelUp![index]}"),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoriesTab() {
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
