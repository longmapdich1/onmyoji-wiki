import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onmyoji_wiki/common/navigator.dart';
import 'package:onmyoji_wiki/common/theme/style_app.dart';
import 'package:onmyoji_wiki/common/utils.dart';
import 'package:onmyoji_wiki/common/widgets/common_bottom_sheet.dart';
import 'package:onmyoji_wiki/common/widgets/list_info_item.dart';
import 'package:onmyoji_wiki/common/widgets/loading_screen.dart';
import 'package:onmyoji_wiki/models/shiki.dart';
import 'package:onmyoji_wiki/models/skill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShikiDetails extends StatefulWidget {
  const ShikiDetails({super.key, required this.shikiId});
  final int shikiId;

  @override
  State<ShikiDetails> createState() => _ShikiDetailsState();
}

class _ShikiDetailsState extends State<ShikiDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  final supabase = Supabase.instance.client;
  late Animation _animation;
  late Shiki _shiki;
  late Uint8List _avatar;
  late Uint8List _skill1;
  late Uint8List _skill2;
  late Uint8List _skill3;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    supabase.dispose();
    super.dispose();
  }

  Future<Shiki> _fetchData() async {
    final dataShiki = await supabase.from('Shiki').select<PostgrestList>('''
      id,name,type,image,
      Stat(*) 
''').eq("id", widget.shikiId);

    final dataSkill = await supabase.from('Skill').select<PostgrestList>('''
          id,name,describe,cost,bonus,cooldown,type,image,
          LinkSkillAndNote(
            SkillNote(name, describe)
          ),
          SkillLevelUp(
            content
          )
''').eq("shiki", "${dataShiki[0]["id"]}").order("id", ascending: true);
    // print(dataSkill[1]);
    List<Skill> tempList = [];
    for (var element in dataSkill) {
      tempList.add(Skill.fromJson(element));
    }
    final Shiki tempShiki = Shiki.fromJson(dataShiki[0], tempList);
    _avatar = base64Decode(tempShiki.image!);
    _skill1 = base64Decode(tempList[0].image);
    _skill2 = base64Decode(tempList[1].image);
    _skill3 = base64Decode(tempList[2].image);
    return tempShiki;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Shiki>(
        future: _fetchData(),
        builder: (context, snapshot) {
          final state = snapshot.data;
          if (state == null) {
            return const Center(
              child: LoadingScreen(),
            );
          }
          _animationController.forward();
          _shiki = snapshot.data!;
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
                _shiki.name.upperCaseFirst,
                style: StyleApp.s28(),
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
                        Tab(child: Text("Ch??? s???", style: StyleApp.s16(true))),
                        Tab(
                          child: Text("Truy???n k??", style: StyleApp.s16(true)),
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
        });
  }

  Widget _buildAvatarContainer() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Stack(
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
                      height: 375.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    ...List.generate(
                      3,
                      (index) => _buildCircleContainer(
                          skill: _shiki.skills![index],
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
            clipper: _CustomRoundClipper(50.h),
            child: Container(
              height: 140.h,
              color: Colors.black,
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: ClipOval(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 3.0)
                      ],
                    ),
                    child: Image.memory(
                      _avatar,
                      width: 100.sp,
                      height: 100.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
          showNativeSheet(context, _SkillBottomSheet(skill, index, _shiki));
        },
        child: RotatedBox(
          quarterTurns: 2,
          child: Image.memory(
            index == 0
                ? _skill1
                : index == 1
                    ? _skill2
                    : _skill3,
          ),
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
          ListInfo(list: [
            ListInfoItem(
                title: "ATK (T???n c??ng): ",
                content: _shiki.stat?.attack.toString()),
            ListInfoItem(
                title: "HP (M??u): ", content: _shiki.stat?.hp.toString()),
            ListInfoItem(
                title: "DEF (Th???): ", content: _shiki.stat?.def.toString()),
            ListInfoItem(
                title: "SPD (T???c): ", content: _shiki.stat?.spd.toString()),
            ListInfoItem(
                title: "CRIT (T??? l??? ch?? m???ng): ",
                content: "${_shiki.stat?.crit.toInt()}%"),
            ListInfoItem(
                title: "CRIT DMG (S??t th????ng ch?? m???ng): ",
                content: "${_shiki.stat?.critDame.toInt()}%"),
            ListInfoItem(
                title: "EFFECT HIT (T??? l??? ch??nh x??c): ",
                content: "${_shiki.stat?.effectHit.toInt()}%"),
            ListInfoItem(
                title: "EFFECT RES (T??? l??? kh??ng): ",
                content: "${_shiki.stat?.effectRes.toInt()}%"),
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
          style: StyleApp.s28(true),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: image,
        ),
        Text(
          "Lo???i: ${skill.type.toVietNamString}",
          style: StyleApp.s16(true),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: skill.describe.textWithBold),
        SizedBox(height: 8.h),
        ...List.generate(
          skill.levelUp.length,
          (index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "C???p ${index + 2}: ",
                style: StyleApp.s14().copyWith(fontWeight: FontWeight.w700),
              ),
              Flexible(
                child: skill.levelUp[index].textWithBold,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        ...List.generate(
          skill.note.length,
          (index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${skill.note[index].name}: ",
                style: StyleApp.s14().copyWith(fontWeight: FontWeight.w700),
              ),
              Flexible(
                child: Text(
                  skill.note[index].describe,
                  style: StyleApp.s14(),
                ),
              ),
            ],
          ),
        ),
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
              image: Image.memory(base64Decode(skill.image)),
            ),
            if (skill.bonusId != null)
              _buildSkillItem(
                skill: shiki.skills!
                    .firstWhere((element) => element.id == skill.bonusId),
                image: Image.memory(base64Decode(shiki.skills!
                    .firstWhere((element) => element.id == skill.bonusId)
                    .image)),
              )
          ],
        ),
      ),
    );
  }
}
