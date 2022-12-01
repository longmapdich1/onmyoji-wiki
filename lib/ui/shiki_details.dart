import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/assets.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/utils.dart';
import 'package:onmyoji_wiki/common/widgets/common_bottom_sheet.dart';
import 'package:onmyoji_wiki/common/widgets/list_info_item.dart';
import 'package:onmyoji_wiki/models/shiki.dart';
import 'package:onmyoji_wiki/models/skill.dart';

class ShikiDetails extends StatefulWidget {
  const ShikiDetails({super.key, required this.shiki});
  final Shiki shiki;

  @override
  State<ShikiDetails> createState() => _ShikiDetailsState();
}

class _ShikiDetailsState extends State<ShikiDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          widget.shiki.name.upperCaseFirst,
          style: StyleApp.s36(),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatarContainer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Container(
              height: 40.h,
              padding: EdgeInsets.all(2.sp),
              decoration: BoxDecoration(
                color: const Color(0xffF3F6FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: Colors.white),
                labelStyle: StyleApp.s16(true),
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(child: Text("Chỉ số", style: StyleApp.s16(true))),
                  Tab(
                    child: Text("Truyện ký", style: StyleApp.s16(true)),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStatTab(),
                  _buildStoriesTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarContainer() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(height: MediaQuery.of(context).size.height / 2.8),
        Positioned(
          top: -250.h,
          child: Transform.rotate(
            angle: -_animation.value * pi,
            child: Transform.scale(
              scale: 1.5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 375,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  ...List.generate(
                    widget.shiki.skills.length,
                    (index) => _buildCircleContainer(
                        skill: widget.shiki.skills[index],
                        index: index,
                        left: index == 0
                            ? MediaQuery.of(context).size.width / 1.5
                            : index == 1
                                ? MediaQuery.of(context).size.width / 2.35
                                : MediaQuery.of(context).size.width / 5.2,
                        top: index == 1 ? -20.h : null),
                  ),
                ],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: _CustomRoundClipper(70.h),
          child: Container(
            height: 150.h,
            color: Colors.black,
          ),
        ),
        Positioned(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 30.h),
              height: 120.sp,
              width: 120.sp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black, blurRadius: 3.0)
                ],
                image: DecorationImage(
                    image: AssetImage(
                      ImageAssets.getAvatarPathByNameAndType(
                          widget.shiki.name, widget.shiki.type.name),
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCircleContainer({
    required Skill skill,
    required int index,
    double? left,
    double? top,
  }) {
    return Positioned(
      left: left,
      top: top,
      height: 52.sp,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          showNativeSheet(
              context, _SkillBottomSheet(skill, index, widget.shiki));
        },
        child: RotatedBox(
          quarterTurns: 2,
          child: ImageAssets.getSkillByNameTypeAndNumber(
              widget.shiki.name, widget.shiki.type.name, index + 1),
        ),
      ),
    );
  }

  Widget _buildStoriesTab() {
    return Container();
  }

  Widget _buildStatTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(Icons.arrow_forward),
          ListInfo(list: [
            ListInfoItem(
                title: "ATK (Tấn công): ",
                content: widget.shiki.stat.attack.toString()),
            ListInfoItem(
                title: "HP (Máu): ", content: widget.shiki.stat.hp.toString()),
            ListInfoItem(
                title: "DEF (Thủ): ",
                content: widget.shiki.stat.def.toString()),
            ListInfoItem(
                title: "SPD (Tốc): ",
                content: widget.shiki.stat.spd.toString()),
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
          ]),
        ],
      ),
    );
  }
}

class _CustomRoundClipper extends CustomClipper<Path> {
  final double point;

  _CustomRoundClipper(this.point);
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, point);
    path.quadraticBezierTo(w / 2, h + h / 4, w, point);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _SkillBottomSheet extends StatelessWidget {
  const _SkillBottomSheet(this.skill, this.index, this.shiki);
  final Shiki shiki;
  final Skill skill;
  final int index;

  Widget _buildSkillItem({required Skill skill, required Widget image}) {
    return Column(
      children: [
        Text(
          skill.name,
          style: StyleApp.s36(true),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: image,
        ),
        Text(
          "Loại: ${skill.type.toVietNamString}",
          style: StyleApp.s16(true),
        ),
        Text(skill.describe, style: StyleApp.s14()),
        SizedBox(height: 4.h),
        if (skill.levelUp != null) ...[
          SizedBox(height: 4.h),
          ...List.generate(
            skill.levelUp!.length,
            (index) => Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Level ${index + 2}: ${skill.levelUp![index]}",
                style: StyleApp.s14(),
              ),
            ),
          ),
        ],
        SizedBox(height: 16.h)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            _buildSkillItem(
              skill: skill,
              image: ImageAssets.getSkillByNameTypeAndNumber(
                  shiki.name, shiki.type.name, index + 1),
            ),
            if (skill.bonus != null)
              _buildSkillItem(
                skill: skill.bonus!,
                image: ImageAssets.getBonusSkillByNameTypeAndNumber(
                    shiki.name, shiki.type.name, index + 1),
              )
          ],
        ),
      ),
    );
  }
}
