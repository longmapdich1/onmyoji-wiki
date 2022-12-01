import 'package:onmyoji_wiki/models/skill.dart';

enum ShikiType { n, ssn, r, sr, ssr, sp }

class Stat {
  final int attack;
  final int def;
  final int hp;
  final int spd;
  final int effectHit;
  final int effectRes;
  final int crit;
  final int critDame;

  Stat({
    required this.attack,
    required this.def,
    required this.hp,
    required this.spd,
    required this.effectHit,
    required this.effectRes,
    required this.crit,
    required this.critDame,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    List<String> tempLevelUp = [];
    for (int i = 2; i < 10; i++) {
      if (json["level$i"] != null) {
        tempLevelUp.add(json['level$i']);
      } else {
        break;
      }
    }
    return Stat(
      attack: json["attack"],
      def: json["def"],
      hp: json["hp"],
      spd: json["spd"],
      effectHit: json["effectHit"],
      effectRes: json["effectRes"],
      crit: json["crit"],
      critDame: json["critDame"],
    );
  }
}



class Shiki {
  final String id;
  final String name;
  final List<Skill> skills;
  final Stat stat;
  final ShikiType type;
  final List<String> stories;

  Shiki(
      {required this.id,
      required this.name,
      required this.skills,
      required this.stat,
      required this.type,
      required this.stories});

  static List<Skill> getListSkill(Map<String, dynamic> json) {
    List<Skill> result = [];
    for (int i = 1; i < 10; i++) {
      if (json["skill$i"] != null) {
        result.add(Skill.fromJson(json["skill$i"]));
      } else {
        break;
      }
    }
    return result;
  }
}
